package com.example.plutocart.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import lombok.Getter;
import lombok.Setter;

import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "account")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_account", nullable = false)
    private Integer accountId;

    @Column(name = "imei", nullable = false, length = 200)
    private String imei;

    @Column(name = "email", length = 50)
    private String email;
    @Lob
    @Column(name = "account_role", nullable = false)
    private String accountRole;

    @OneToMany(mappedBy = "accountIdAccount")
    private Set<Debt> debts = new LinkedHashSet<>();

    @OneToMany(mappedBy = "accountIdAccount")
    private Set<Goal> goals = new LinkedHashSet<>();

    @OneToMany(mappedBy = "accountIdAccount")
    private Set<Wallet> wallets = new LinkedHashSet<>();

}