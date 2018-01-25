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
    sql::Driver *driver;
    sql::Connection *con;
    sql::Statement *stmt;

    try {


        driver = get_driver_instance();
        con = driver->connect("tcp://127.0.0.1:3306", "cbuser", "cbpass");
        con->setSchema("cookbook");

        con->setAutoCommit(false);
        stmt = con->createStatement();
        try {

            // will success
            int num = stmt->executeUpdate("INSERT INTO test_transaction (i) VALUES ('4')");
            if (num > 0) {
                cout << "execute success, but not commit." << endl;
            }
            // will fails
            num = stmt->executeUpdate("INSERT INTO test_transaction (x) VALUES ('5')");
            if (num > 0) {
                cout << "insert success, but not commit." << endl;
            }

            stmt->close();
            con->commit();
            con->setAutoCommit(true);

        } catch (sql::SQLException &e) {
            cout << "# ERR: SQLException in " << __FILE__;
            cout << "# ERR: " << e.what();
            cout << " (MySQL error code: " << e.getErrorCode();
            cout << ", SQLState: " << e.getSQLState() << " )" << endl;

            con->rollback();
            con->setAutoCommit(true);
        }

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