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
import java.util.List;

@Repository
public interface DebtRepository extends JpaRepository<Debt, Integer> {
    @Transactional
    @Query(value = "SELECT * FROM debt where account_id_account = :accountId", nativeQuery = true)
    List<Debt> viewDebtByAccountId(Integer accountId);

    @Transactional
    @Query(value = "SELECT * FROM debt where id_debt = :debtId", nativeQuery = true)
    Debt viewDebtByDebtId(Integer debtId);


    @Transactional
    @Modifying
    @Procedure(procedureName = "createDebtByAccountId")
    void insertDebtByAccountId(String nameDebt, BigDecimal totalDebt, Integer totalPeriod, Integer paidPeriod, BigDecimal monthlyPayment, BigDecimal debtPaid, String moneyLender, LocalDateTime latestPayDate, Integer accountId);

    @Transactional
    @Modifying
    @Procedure(procedureName = "updateDebtByAccountId")
    void updateDebtByAccountId(String nameDebt, BigDecimal totalDebt, Integer totalPeriod, Integer paidPeriod, BigDecimal monthlyPayment, BigDecimal debtPaid, String moneyLender, LocalDateTime latestPayDate, Integer debtId);


    @Transactional
    @Modifying
    @Query(value = "DELETE FROM debt where id_debt = :debtId", nativeQuery = true)
    void deleteDebtByDebtId(Integer debtId);

    @Transactional
    @Modifying
    @Procedure(procedureName = "updateDebtToComplete")
    void updateDebtToComplete(Integer accountId, Integer debtId);

}