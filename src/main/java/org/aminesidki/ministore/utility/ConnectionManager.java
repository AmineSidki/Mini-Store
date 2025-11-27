package org.aminesidki.ministore.utility;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionManager {
    private static HikariDataSource dataSource ;

    public static Connection getConnection() throws SQLException {
        if(dataSource == null) throw new RuntimeException("Datasource is null , call initializeConnection()");
        return dataSource.getConnection();
    }

    public static void initializeConnection(){
        try{
            Class.forName("org.postgresql.Driver");
        }catch(Exception e ){
            throw new RuntimeException(e);
        }

        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:postgresql://aws-1-eu-west-1.pooler.supabase.com:6543/postgres");
        config.setUsername(System.getenv("DB_USR"));
        config.setPassword(System.getenv("DB_PWD"));
        config.setMaximumPoolSize(10);
        config.setMinimumIdle(2);
        config.setIdleTimeout(30000);
        config.setConnectionTimeout(10000);
        config.setPoolName("MyHikariPool");

        dataSource = new HikariDataSource(config);
    }

}
