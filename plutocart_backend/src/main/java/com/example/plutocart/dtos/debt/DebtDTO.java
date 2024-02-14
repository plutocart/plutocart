package com.example.plutocart.dtos.debt;

import com.example.plutocart.entities.Account;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class DebtDTO {
    private Integer id;
    private String nameDebt;
    private BigDecimal amountDebt;
    private Integer payPeriod;
    private Integer numOfPaidPeriod;
    private BigDecimal paidDebtPerPeriod;
    private BigDecimal totalPaidDebt;
    private String moneyLender;
    private Integer statusDebt;
    private LocalDateTime latestPayDate;
//    private Account accountIdAccount;
}
