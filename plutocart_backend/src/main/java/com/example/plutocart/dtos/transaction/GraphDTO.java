package com.example.plutocart.dtos.transaction;

import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.TransactionCategory;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class GraphDTO {
    private Integer id;
    private BigDecimal totalInGraph;
    private AccountDTO accountIdAccount;
    private TransactionCategory tranCategoryIdCategory;
}
