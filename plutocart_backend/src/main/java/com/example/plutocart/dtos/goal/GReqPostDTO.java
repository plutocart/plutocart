package com.example.plutocart.dtos.goal;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class GReqPostDTO {
    private Integer accountId;
    private String nameGoal;
    private BigDecimal amountGoal;
    private BigDecimal deficit;
}