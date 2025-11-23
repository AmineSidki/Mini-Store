package org.aminesidki.ministore.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class User {
     private Long id;
     private String username;
     private String email;
     private String passwordHash;
     private Timestamp createdAt;
}
