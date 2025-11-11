package org.aminesidki.ministore.dao;

import lombok.RequiredArgsConstructor;
import org.aminesidki.ministore.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
public class UserDao implements Dao<User, Long>{
    private final Connection conn;
    private final String salt ;

    @Override
    public User get(Long aLong) {
        try{
            PreparedStatement st = conn.prepareStatement("SELECT * FROM app_user WHERE id = ?");
            st.setLong(1 , aLong);

            ResultSet rs = st.executeQuery();

            User user = null;

            if(rs.next()){
                user = new User(rs.getLong(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getTimestamp(5));
            }

            rs.close();
            st.close();

            return user;
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    public User getByUsername(String username){
        try{
            PreparedStatement st = conn.prepareStatement("SELECT * FROM app_user WHERE username = ?");
            st.setString(1 , username);

            ResultSet rs = st.executeQuery();

            User user = null;

            if(rs.next()){
                user = new User(rs.getLong(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getTimestamp(5));
            }

            rs.close();
            st.close();

            return user;
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<User> getAll() {
        try{
            List<User> allUsers = new ArrayList<>();
            Statement st = conn.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM app_user");

            while(rs.next()){
                User user = new User(rs.getLong(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getTimestamp(5));

                allUsers.add(user);
            }

            rs.close();
            st.close();

            return allUsers;
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
    }

    @Override
    public User save(User object) {
        User user = object.getId() == null ? null : get(object.getId());
        PreparedStatement st;
        try{
            if(user == null){
                object.setPasswordHash(BCrypt.hashpw(object.getPasswordHash() , salt));
                st = conn.prepareStatement("INSERT INTO app_user(username,email,password_hash) VALUES (?,?,?)");
                st.setString(1,object.getUsername());
                st.setString(2,object.getEmail());
                st.setString(3, object.getPasswordHash());
            }else{
                st = conn.prepareStatement("UPDATE app_user" +
                        " SET username = ?," +
                        " SET email = ?," +
                        " SET password_hash = ?," +
                        " SET created_at = ?" +
                        "WHERE id = ?");
                st.setString(1,object.getUsername());
                st.setString(2,object.getEmail());
                st.setString(3, object.getPasswordHash());
                st.setTimestamp(4,object.getCreatedAt());
                st.setLong(5,object.getId());
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
            PreparedStatement st = conn.prepareStatement("DELETE FROM app_user WHERE id = ?");
            st.setLong(1, aLong);
            st.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
