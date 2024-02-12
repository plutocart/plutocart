package com.example.plutocart.dtos.debt;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DResDelDTO {
    private Integer accountId;
    private Integer debtId;
    private String description;
}