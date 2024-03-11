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

    @Column(name = "total_debt", nullable = false, precision = 13, scale = 2)
    private BigDecimal totalDebt;

    @Column(name = "total_period", nullable = false)
    private Integer totalPeriod;

    @Column(name = "paid_period", nullable = false)
    private Integer paidPeriod;

    @Column(name = "monthly_payment", nullable = false, precision = 13, scale = 2)
    private BigDecimal monthlyPayment;

    @Column(name = "debt_paid", nullable = false, precision = 13, scale = 2)
    private BigDecimal debtPaid;

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