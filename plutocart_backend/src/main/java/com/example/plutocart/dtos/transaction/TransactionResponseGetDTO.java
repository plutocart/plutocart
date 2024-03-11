package com.example.plutocart.dtos.transaction;

import com.example.plutocart.dtos.debt.DebtDTO;
import com.example.plutocart.dtos.goal.GoalDTO;
import com.example.plutocart.dtos.transaction_category.TSCResGetDTO;
import com.example.plutocart.dtos.wallet.WalletDTO;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
public class TransactionResponseGetDTO {
    private Integer id;
    private BigDecimal stmTransaction;
    private String statementType;
    private Instant dateTransaction;
    private String description;
    private String imageUrl;
    private TSCResGetDTO tranCategoryIdCategory;
    private DebtDTO debtIdDebt;
    private GoalDTO goalIdGoal;
    private WalletDTO walletIdWallet;
}
