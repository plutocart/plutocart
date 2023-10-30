package com.example.plutocart.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "wallet")
public class Wallet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_wallet", nullable = false)
    private Integer id;

    @Column(name = "name_wallet", nullable = false, length = 45)
    private String nameWallet;

    @Column(name = "balance_wallet", nullable = false, precision = 13, scale = 2)
    private BigDecimal balanceWallet;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "account_id_account", nullable = false)
    private Account accountIdAccount;

    @Column(name = "create_wallet_on", nullable = false)
    private Instant createWalletOn;

    @Column(name = "update_wallet_on", nullable = false)
    private Instant updateWalletOn;

}