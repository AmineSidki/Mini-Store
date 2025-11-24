package org.aminesidki.ministore.dao;

import lombok.RequiredArgsConstructor;
import org.aminesidki.ministore.model.Product;

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

            if(!rs.next()){
                rs.close();
                st.close();
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
        Product product = object.getId() == null ? null : get(object.getId());
        PreparedStatement st;
        try{
            if(product == null){
                st = conn.prepareStatement("INSERT INTO product(name,price,description) VALUES (?,?,?)");
                st.setString(1,object.getName());
                st.setFloat(2,object.getPrice());
                st.setString(3, object.getDescription());
            }else{
                st = conn.prepareStatement("UPDATE product" +
                        " SET name = ?," +
                        " price = ?," +
                        " description = ?" +
                        " WHERE id = ?");
                st.setString(1,object.getName());
                st.setFloat(2,object.getPrice());
                st.setString(3, object.getDescription());
                st.setLong(4,object.getId());
            }

            if(st.executeUpdate() != 0){
                return object;
            }
            return null;

        }catch (SQLException e){
            return null;
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
