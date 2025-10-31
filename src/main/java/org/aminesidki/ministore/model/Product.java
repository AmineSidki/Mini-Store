package org.aminesidki.ministore.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.sql.Timestamp;

@AllArgsConstructor
@Data
public class Product {
     private Long id;
     private String name;
     private Float price;
     private String description;
     private Timestamp createdAt;
}
