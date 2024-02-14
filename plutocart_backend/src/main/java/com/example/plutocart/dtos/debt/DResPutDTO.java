package com.example.plutocart.dtos.debt;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class DResPutDTO {
    private Integer accountId;
    private Integer debtId;
    private String nameDebt;
    private BigDecimal amountDebt;
    private Integer payPeriod;
    private Integer numOfPaidPeriod;
    private BigDecimal paidDebtPerPeriod;
    private BigDecimal totalPaidDebt;
    private String moneyLender;
    private LocalDateTime latestPayDate;
    private String description;
}
