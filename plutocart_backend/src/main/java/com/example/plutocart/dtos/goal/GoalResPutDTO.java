package com.example.plutocart.dtos.goal;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class GoalResPutDTO {

    private Integer acId;
    private Integer goalId;
    private String nameGoal;
    private BigDecimal totalGoal;
    private BigDecimal collectedMoney;
    private LocalDateTime endDateGoal;
    private String description;
}
