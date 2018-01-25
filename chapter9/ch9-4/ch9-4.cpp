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
#include <cppconn/metadata.h>

using namespace std;

int main()
{
    try {
        sql::Driver *driver;
        sql::Connection *con;
        sql::ConnectOptionsMap con_map;

        con_map["hostName"] = "tcp://127.0.0.1";
        con_map["userName"] = "cbuser";
        con_map["password"] = "cbpass";
        con_map["schema"] = "cookbook";
        con_map["port"] = 3306;

        driver = get_driver_instance();
        con = driver->connect(con_map);

        {
            cout << "# (method 1)profile table column definitions: " << endl;
            boost::scoped_ptr<sql::Statement> st(con->createStatement());
            string sql = "SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE"
                    " FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = "
                    "'cookbook' AND TABLE_NAME = 'profile'";
            boost::scoped_ptr<sql::ResultSet> res(st->executeQuery(sql));
            while (res->next()) {
                cout << res->getString("COLUMN_NAME") << " ";
                cout << res->getString("DATA_TYPE") << " ";
                cout << res->getString("IS_NULLABLE") << endl;
            }
        }

        {
            cout << "# (method 2) profile table column definitions: " << endl;
            boost::scoped_ptr<sql::Statement> st(con->createStatement());
            string sql = "SHOW CREATE TABLE profile";
            boost::scoped_ptr<sql::ResultSet> res(st->executeQuery(sql));
            while (res->next()) {
                cout << res->getString("Table") << " ";
                cout << res->getString("Create Table") << endl;
            }
        }

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
