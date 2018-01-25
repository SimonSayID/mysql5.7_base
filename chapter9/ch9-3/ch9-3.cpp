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
        sql::DatabaseMetaData *md;
        sql::ConnectOptionsMap con_map;

        con_map["hostName"] = "tcp://127.0.0.1";
        con_map["userName"] = "cbuser";
        con_map["password"] = "cbpass";
        con_map["schema"] = "cookbook";
        con_map["port"] = 3306;

        driver = get_driver_instance();
        con = driver->connect(con_map);

        cout << "# Server metadata: " << endl;

        md = con->getMetaData();
        cout << "DatabaseProductName: " << md->getDatabaseProductName() << endl;
        cout << "ProductVersion: " << md->getDatabaseProductVersion() << endl;
        cout << "UserName: " << md->getUserName() << endl;

        {
            cout << "# (method 1) List of available schemata/databases: " << endl;
            boost::scoped_ptr<sql::ResultSet> res(md->getSchemas());
            while (res->next()) {
                cout << res->getString("TABLE_SCHEM") << endl;
            }
        }

        {
            cout << "# (method 2) List of available schemata/databases: " << endl;
            boost::scoped_ptr<sql::Statement> st(con->createStatement());
            string sql = "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA";
            boost::scoped_ptr<sql::ResultSet> res(st->executeQuery(sql));
            while (res->next()) {
                cout << res->getString("SCHEMA_NAME") << endl;
            }
        }

        {
            cout << "# List of available tables in cookbook: " << endl;
            boost::scoped_ptr<sql::Statement> st(con->createStatement());
            string sql = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES "
                    "WHERE TABLE_SCHEMA = 'cookbook'";
            boost::scoped_ptr<sql::ResultSet> res(st->executeQuery(sql));
            while (res->next()) {
                cout << res->getString("TABLE_NAME") << endl;
            }
        }

        {
            cout << "# Supported Object types: " << endl;
            boost::scoped_ptr<sql::ResultSet> res(md->getSchemaObjectTypes());
            while (res->next()) {
                cout << res->getString(1) << endl;
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
