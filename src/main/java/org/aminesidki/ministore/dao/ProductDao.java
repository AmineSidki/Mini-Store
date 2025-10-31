package org.aminesidki.ministore.dao;

import lombok.RequiredArgsConstructor;
import org.aminesidki.ministore.model.Product;
import org.aminesidki.ministore.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
public class ProductDao implements Dao<Product,Long>{
    private final Connection conn;

    @Override
    public Product get(Long aLong) {
        try{
            PreparedStatement st = conn.prepareStatement("SELECT * FROM product WHERE id = ?");
            st.setLong(1 , aLong);

            ResultSet rs = st.executeQuery();

            if(rs.getFetchSize() == 0){
                return null;
            }

            Product product = new Product(rs.getLong(1),
                    rs.getString(2),
                    rs.getFloat(3),
                    rs.getString(4),
                    rs.getTimestamp(5));

            rs.close();
            st.close();

            return product;
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Product> getAll() {
        try{
            List<Product> allProducts = new ArrayList<>();
            Statement st = conn.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM product");

            while(rs.next()){
                Product product = new Product(rs.getLong(1),
                        rs.getString(2),
                        rs.getFloat(3),
                        rs.getString(4),
                        rs.getTimestamp(5));

                allProducts.add(product);
            }

            rs.close();
            st.close();

            return allProducts;
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    @Override
    public Product save(Product object) {
        Product product = get(object.getId());
        PreparedStatement st;
        try{
            if(product == null){
                st = conn.prepareStatement("INSERT INTO product VALUES (?,?,?,?,?)");
                st.setLong(1,object.getId());
                st.setString(2,object.getName());
                st.setFloat(3,object.getPrice());
                st.setString(4, object.getDescription());
                st.setTimestamp(5,object.getCreatedAt());
            }else{
                st = conn.prepareStatement("UPDATE product" +
                        " SET username = ?," +
                        " SET email = ?," +
                        " SET password_hash = ?," +
                        " SET created_at = ?" +
                        "WHERE id = ?");
                st.setString(1,object.getName());
                st.setFloat(2,object.getPrice());
                st.setString(3, object.getDescription());
                st.setTimestamp(4,object.getCreatedAt());
                st.setLong(5,object.getId());
            }

            if(st.executeUpdate() != 0){
                st.close();
                return object;
            }
            st.close();
            return null;

        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(Long aLong) {
        try {
            PreparedStatement st = conn.prepareStatement("DELETE FROM product WHERE id = ?");
            st.setLong(1, aLong);
            st.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
