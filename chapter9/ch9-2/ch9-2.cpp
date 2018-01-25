#include <cstdlib>
#include <iostream>

/*
  Include directly the different
  headers from cppconn/ and mysql_driver.h + mysql_util.h
  (and mysql_connection.h). This will reduce your build time!
*/
#include "mysql_connection.h"

#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>

using namespace std;

int main()
{
    try {
        sql::Driver *driver;
        sql::Connection *con;
        sql::Statement *stmt;
        sql::ResultSet *res;

        driver = get_driver_instance();
        con = driver->connect("tcp://127.0.0.1:3306", "cbuser", "cbpass");
        con->setSchema("cookbook");

        stmt = con->createStatement();
        res = stmt->executeQuery("SELECT id, name, birth FROM profile");
        sql::ResultSetMetaData *md = res->getMetaData();
        const size_t num_cols = md->getColumnCount();
        vector<size_t> vi(num_cols + 1);
        string b{"+"};
        for (unsigned int i = 1; i <= num_cols; ++i) {
            vi[i] = md->getColumnDisplaySize(i);
            if (vi[i] < md->getColumnName(i).length()) {
                vi[i] = md->getColumnName(i).length();
            }
            if (vi[i] < 4 && md->isNullable(i) != 0) {
                vi[i] = 4;
            }
        }
        for (unsigned int i = 1; i <= num_cols; ++i) {
            for (int j = 0; j < vi[i]; ++j) {
                b.append("-");
            }
            b.append("+");
        }
        cout << b << endl;
        cout << "|";
        for (unsigned int i = 1; i <= num_cols; ++i) {
            cout << md->getColumnName(i);
            for (size_t j = md->getColumnName(i).length(); j < vi[i]; ++j) {
                cout << " ";
            }
            cout << "|";
        }
        cout << endl;
        cout << b << endl;
        int num_rows = 0;
        while (res->next()) {
            ++num_rows;
            cout << "|";
            for (unsigned int i = 1; i <= num_cols; ++i) {
                string s = res->getString(i);
                if (res->wasNull()) {
                    s = "NULL";
                }
                cout << s;
                for (size_t j = s.length(); j < vi[i]; ++j) {
                    cout << " ";
                }
                cout << "|";
            }
            cout << endl;
        }
        cout << b << endl;
        cout << "Number of rows selected: " << num_rows << endl;
        delete res;
        delete stmt;
        delete con;

    } catch (sql::SQLException &e) {
        cout << "# ERR: SQLException in " << __FILE__;
        cout << "# ERR: " << e.what();
        cout << " (MySQL error code: " << e.getErrorCode();
        cout << ", SQLState: " << e.getSQLState() << " )" << endl;
    }

    cout << endl;

    return EXIT_SUCCESS;
}
