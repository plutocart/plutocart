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
    private BigDecimal amountGoal;
    private BigDecimal deficit;
    private LocalDateTime endDateGoal;
    private AccountDTO accountIdAccount;
}
