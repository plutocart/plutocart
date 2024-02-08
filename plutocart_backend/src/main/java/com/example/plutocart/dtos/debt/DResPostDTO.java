package com.example.plutocart.dtos.debt;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class DResPostDTO {
    private Integer accountId;
    private String nameDebt;
    private BigDecimal amountDebt;
    private Integer installmentDebt;
    private Integer numOfInstallmentPay;
    private BigDecimal totalPaidDebt;
    private String description;
    private String alert;
}
