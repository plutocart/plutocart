package com.example.plutocart.dtos.transaction;

import com.example.plutocart.entities.TransactionCategory;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class GraphDetailDTO {
    private TransactionCategory transactionCategory;
    private BigDecimal totalInTransactionCategory;
//    private BigDecimal totalExpenseInTransactionCategory;
}
