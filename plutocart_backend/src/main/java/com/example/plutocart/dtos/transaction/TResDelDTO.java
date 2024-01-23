package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TResDelDTO {
    private Integer transactionId;
    private Integer walletId;
    private String description;
}
