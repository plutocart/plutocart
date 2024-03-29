package com.example.plutocart.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Setter
@Getter
@Entity
@Table(name = "wallet")
public class Wallet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_wallet", nullable = false)
    private Integer walletId;

    @Size(min = 1, max = 45, message = "length wallet name less 1 or more that 45")
    @NotEmpty(message = "wallet name is empty")
    @NotNull(message = "wallet name is null")
    @NotBlank(message = "wallet name is mandatory")
    @Column(name = "name_wallet", nullable = false, length = 45)
    private String walletName;

    @Digits(integer = 13, fraction = 2, message = "Invalid decimal value")
    @DecimalMin(value = "1.00", inclusive = false, message = "wallet balance should be greater than 1.00")
    @DecimalMax(value = "99999999999.99", inclusive = true, message = "wallet balance exceeds maximum value 99999999999.99")
    @NotNull(message = "balance wallet is null")
    @Column(name = "balance_wallet", nullable = false, precision = 13, scale = 2)
    private BigDecimal WalletBalance;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "account_id_account", nullable = false)
    private Account accountIdAccount;

    @Column(name = "create_wallet_on", nullable = false)
    private Instant createWalletOn;

    @Column(name = "update_wallet_on", nullable = false)
    private Instant updateWalletOn;

    @Column(name = "status_wallet", nullable = false)
    private Byte statusWallet;

}