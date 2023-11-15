package com.example.plutocart.dtos;

import lombok.Data;
import org.hibernate.type.descriptor.jdbc.TinyIntJdbcType;

import java.math.BigDecimal;

@Data
public class WalletDto {
    private int idWallet;
    private String nameWallet;
    private BigDecimal balanceWallet;
    private Byte statusWallet;


}
