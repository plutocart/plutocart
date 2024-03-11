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
    private BigDecimal totalDebt;
    private Integer totalPeriod;
    private Integer paidPeriod;
    private BigDecimal monthlyPayment;
    private BigDecimal debtPaid;
    private String moneyLender;
    private Integer statusDebt;
    private LocalDateTime latestPayDate;
//    private Account accountIdAccount;
}
