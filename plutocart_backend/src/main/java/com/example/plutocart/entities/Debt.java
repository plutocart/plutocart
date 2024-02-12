package com.example.plutocart.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.LinkedHashSet;
import java.util.Set;

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

    @Column(name = "pay_period", nullable = false)
    private Integer payPeriod;

    @Column(name = "num_of_paid_period", nullable = false)
    private Integer numOfPaidPeriod;

    @Column(name = "paid_debt_per_period", nullable = false, precision = 13, scale = 2)
    private BigDecimal paidDebtPerPeriod;

    @Column(name = "total_paid_debt", nullable = false, precision = 13, scale = 2)
    private BigDecimal totalPaidDebt;

    @Column(name = "money_lender", length = 100)
    private String moneyLender;

    @Column(name = "status_debt", nullable = false)
    private Integer statusDebt;

    @Column(name = "latest_pay_date", nullable = false)
    private LocalDateTime latestPayDate;

    @Column(name = "create_debt_on", nullable = false)
    private Instant createDebtOn;

    @Column(name = "update_debt_on", nullable = false)
    private Instant updateDebtOn;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "account_id_account", nullable = false)
    private Account accountIdAccount;

    @OneToMany(mappedBy = "debtIdDebt")
    private Set<Transaction> transactions = new LinkedHashSet<>();

}