package com.example.plutocart.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(name = "graph")
public class Graph {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_graph", nullable = false)
    private Integer id;

    @Column(name = "total_in_graph", nullable = false, precision = 13, scale = 2)
    private BigDecimal totalInGraph;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "tran_category_id_category", nullable = false)
    private TransactionCategory tranCategoryIdCategory;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "account_id_account", nullable = false)
    private Account accountIdAccount;

}
