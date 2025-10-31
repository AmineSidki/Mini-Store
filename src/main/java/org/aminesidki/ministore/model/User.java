package org.aminesidki.ministore.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;

@AllArgsConstructor
@Data
public class User {
     private Long id;
     private String username;
     private String email;
     private String passwordHash;
     private Timestamp createdAt;
}
