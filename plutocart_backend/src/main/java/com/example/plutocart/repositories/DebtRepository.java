package com.example.plutocart.repositories;

import com.example.plutocart.entities.Debt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Repository
public interface DebtRepository extends JpaRepository<Debt, Integer> {

    @Transactional
    @Query(value = "SELECT * FROM debt where id_debt = :debtId", nativeQuery = true)
    Debt viewDebtByDebtId(Integer debtId);

    @Transactional
    @Modifying
    @Procedure(procedureName = "createDebtByAccountId")
    void insertDebtByAccountId(String nameDebt, BigDecimal amountDebt, Integer payPeriod, Integer numOfPaidPeriod, BigDecimal paidDebtPerPeriod, BigDecimal totalPaidDebt, String moneyLender, LocalDateTime latestPayDate, Integer accountId);

    @Transactional
    @Modifying
    @Query(value = "DELETE FROM debt where id_debt = :debtId", nativeQuery = true)
    void deleteDebtByDebtId(Integer debtId);

}