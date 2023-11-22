package com.example.plutocart.dtos.wallet;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Setter
@Getter
public class WalletDTO {
    private int walletId;
    @Size(min = 1, max = 45, message = "length wallet name less 1 or more that 45")
    @NotEmpty(message = "wallet name is empty")
    @NotNull(message = "wallet name is null")
    @NotBlank(message = "wallet name is mandatory")
    private String walletName;
    private BigDecimal WalletBalance;
    private Byte statusWallet;

}
