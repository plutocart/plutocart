package com.example.plutocart.dtos.goal;

import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Setter
@Getter
public class GoalDTO {

    private AccountDTO accountIdAccount;
    private String nameGoal;
    private BigDecimal amountGoal;
    private BigDecimal deficit;
    private LocalDateTime endDateGoal;
}
