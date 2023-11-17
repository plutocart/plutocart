package com.example.plutocart.dtos;

import lombok.Data;
import org.hibernate.type.descriptor.jdbc.TinyIntJdbcType;

import java.math.BigDecimal;

@Data
public class WalletDto {
    private int walletId;
    private String walletName;
    private BigDecimal WalletBalance;
    private Byte statusWallet;


}
