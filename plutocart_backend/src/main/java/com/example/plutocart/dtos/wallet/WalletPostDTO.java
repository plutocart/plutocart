package com.example.plutocart.dtos.wallet;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Setter
@Getter
public class WalletPostDTO {
    private int walletId;
    private String walletName;
    private BigDecimal WalletBalance;
}
