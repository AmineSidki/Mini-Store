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
public class Product {
     private Long id;
     private String name;
     private Float price;
     private String description;
     private Timestamp createdAt;
}

