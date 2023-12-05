package com.example.plutocart.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

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

    @Size(max = 100)
    @NotNull
    @Column(name = "image_icon_url", nullable = false, length = 200)
    private String imageIconUrl;

    @OneToMany(mappedBy = "tranCategoryIdCategory")
    private Set<Transaction> transactions = new LinkedHashSet<>();

}