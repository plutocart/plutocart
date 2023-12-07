package com.example.plutocart.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "transaction")
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_transaction", nullable = false)
    private Integer id;

    @Column(name = "stm_transaction", nullable = false, precision = 13, scale = 2)
    private BigDecimal stmTransaction;

    @Lob
    @Column(name = "statement_type", nullable = false)
    private String statementType;

    @Column(name = "date_transaction", nullable = false)
    private Instant dateTransaction;

    @Column(name = "description", length = 100)
    private String description;

    @Column(name = "image_url", length = 200)
    private String imageUrl;

    @Column(name = "create_transaction_on", nullable = false)
    private Instant createTransactionOn;

    @Column(name = "update_transaction_on", nullable = false)
    private Instant updateTransactionOn;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "tran_category_id_category", nullable = false)
    private TransactionCategory tranCategoryIdCategory;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "debt_id_debt")
    private Debt debtIdDebt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "goal_id_goal")
    private Goal goalIdGoal;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "wallet_id_wallet", nullable = false)
    private Wallet walletIdWallet;


}