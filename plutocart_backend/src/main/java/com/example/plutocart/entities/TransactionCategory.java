package com.example.plutocart.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "transaction_category")
public class TransactionCategory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_transaction_category", nullable = false)
    private Integer id;

    @Column(name = "name_transaction_category", nullable = false, length = 45)
    private String nameTransactionCategory;

    @Lob
    @Column(name = "type_category", nullable = false)
    private String typeCategory;

}