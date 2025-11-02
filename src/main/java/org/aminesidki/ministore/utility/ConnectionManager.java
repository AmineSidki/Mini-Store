package org.aminesidki.ministore.utility;

import org.postgresql.Driver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionManager {
    private static Connection conn;

    public static Connection getConnection(){
        return conn;
    }

    public static void InitializeConnection() throws  SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String dbURL = "jdbc:postgresql://localhost:5432/ministore";
        Properties prop = new Properties();
        prop.setProperty("user",System.getenv("DB_USR"));
        prop.setProperty("password",System.getenv("DB_PWD"));
        DriverManager.getConnection(dbURL , prop);
    }
}
