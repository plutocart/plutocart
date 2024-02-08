package com.example.plutocart.repositories;

import com.example.plutocart.entities.Debt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Repository
public interface DebtRepository extends JpaRepository<Debt, Integer> {

    @Transactional
    @Modifying
    @Procedure(procedureName = "createDebtByAccountId")
    void insertDebtByAccountId(String nameDebt, BigDecimal amountDebt, Integer installmentDebt, Integer numOfInstallmentPay, BigDecimal totalPaidDebt, String description, Integer accountId);

}