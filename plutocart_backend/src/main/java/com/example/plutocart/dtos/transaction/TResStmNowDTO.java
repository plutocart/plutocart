package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class TResStmNowDTO {
    BigDecimal income;
    BigDecimal expense;
}
