package org.aminesidki.ministore.utility;

import org.aminesidki.ministore.dao.ProductDao;
import org.aminesidki.ministore.dao.UserDao;

public class DaoManager {
    public static ProductDao productDao;
    public static UserDao userDao;
    public static final String salt = System.getenv("ENC_SALT");
}
