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
        res = stmt->executeQuery("SELECT name, birth FROM profile");
        cout << "Total row: " << res->rowsCount() << endl;
        sql::ResultSetMetaData *md = res->getMetaData();
        int num_cols = md->getColumnCount();
        cout << "Number of columns: " << num_cols << endl;
        for (unsigned int i = 1; i <= num_cols; ++i) {
            cout << "--- Column " << i
                 << " ( " << md->getColumnName(i)  << " ) ---" << endl;
            cout << "getColumnDisplaySize: " << md->getColumnDisplaySize(i) << endl;
            cout << "getColumnLabel: " << md->getColumnLabel(i) << endl;
            cout << "getColumnType:" << md->getColumnType(i) << endl;
            cout << "getColumnTypeName: " << md->getColumnTypeName(i) << endl;
            cout << "getPrecision: " << md->getPrecision(i) << endl;
            cout << "getScale: " << md->getScale(i) << endl;
            cout << "getTableName: " << md->getTableName(i) << endl;
            cout << "getSchemaName: " << md->getSchemaName(i) << endl;
            cout << "isAutoIncrement: " << md->isAutoIncrement(i) << endl;
            cout << "isNullable: " << md->isNullable(i) << endl;
            cout << "isCaseSensitive: " << md->isCaseSensitive(i) << endl;
            cout << "isSigned: " << md->isSigned(i) << endl;
        }
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
