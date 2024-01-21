package com.example.plutocart.dtos.goal;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Setter
@Getter
public class GoalDTO {

    private int accountId;
    private String nameGoal;
    private BigDecimal amountGoal;
    private BigDecimal deficit;
    private LocalDateTime endDateGoal;
}
