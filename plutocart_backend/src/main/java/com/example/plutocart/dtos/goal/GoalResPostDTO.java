package com.example.plutocart.dtos.goal;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class GoalResPostDTO {

    private Integer acId;
    private String nameGoal;
    private BigDecimal amountGoal;
    private BigDecimal deficit;
    private LocalDateTime endDateGoal;
    private String description;
}
