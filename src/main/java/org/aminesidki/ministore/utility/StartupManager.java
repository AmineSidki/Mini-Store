package org.aminesidki.ministore.utility;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.aminesidki.ministore.dao.ProductDao;
import org.aminesidki.ministore.dao.UserDao;

import java.sql.SQLException;

@WebListener
public class StartupManager implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Web application started!");

        //Initialize the db connection :
        try{
            ConnectionManager.InitializeConnection();
        }catch(SQLException e){
            throw new RuntimeException("Failure to connect to db :" + e);
        }

        //Initialize DAOs
        DaoManager.productDao = new ProductDao(ConnectionManager.getConnection());
        DaoManager.userDao = new UserDao(ConnectionManager.getConnection(), DaoManager.salt);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Web application shut down!");
    }
}
