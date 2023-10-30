package com.example.plutocart.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "debt")
public class Debt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_debt", nullable = false)
    private Integer id;

    @Column(name = "name_debt", nullable = false, length = 45)
    private String nameDebt;

    @Column(name = "amount_debt", nullable = false, precision = 13, scale = 2)
    private BigDecimal amountDebt;

    @Column(name = "installment_debt", nullable = false)
    private Integer installmentDebt;

    @Column(name = "num_of_installment_pay", nullable = false)
    private Integer numOfInstallmentPay;

    @Column(name = "description", length = 100)
    private String description;

    @Column(name = "create_debt_on", nullable = false)
    private Instant createDebtOn;

    @Column(name = "update_debt_on", nullable = false)
    private Instant updateDebtOn;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "account_id_account", nullable = false)
    private Account accountIdAccount;

}