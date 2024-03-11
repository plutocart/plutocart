package com.example.plutocart.dtos.debt;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class DResPostDTO {
    private Integer accountId;
    private String nameDebt;
    private BigDecimal totalDebt;
    private Integer totalPeriod;
    private Integer paidPeriod;
    private BigDecimal monthlyPayment;
    private BigDecimal debtPaid;
    private String moneyLender;
    private LocalDateTime latestPayDate;
    private String description;
}
