package com.example.plutocart.dtos.goal;

import com.example.plutocart.dtos.account.AccountDTO;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Setter
@Getter
public class GoalDTO {

    private Integer id;
    private String nameGoal;
    private BigDecimal totalGoal;
    private BigDecimal collectedMoney;
    private LocalDateTime endDateGoal;
    private Integer statusGoal;
    private AccountDTO accountIdAccount;
}
