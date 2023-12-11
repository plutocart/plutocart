package com.example.plutocart.repositories;

import com.example.plutocart.entities.Transaction;
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
public interface TransactionRepository extends JpaRepository<Transaction, Integer> {

    @Transactional
    @Procedure(procedureName = "viewTransactionByAccountId")
    List<Transaction> viewTransactionByAccountId(Integer accountId);

    @Transactional
    @Procedure(procedureName = "viewTransactionByAccountIdLimitThree")
    List<Transaction> viewTransactionByAccountIdLimitThree(Integer accountId);

    @Transactional
    @Query(value = "SELECT * FROM transaction where wallet_id_wallet = :walletId", nativeQuery = true)
    List<Transaction> viewTransactionByWalletId(Integer walletId);

    @Transactional
    @Query(value = "SELECT * FROM transaction where wallet_id_wallet = :walletId and id_transaction = :transactionId", nativeQuery = true)
    Transaction viewTransactionByWalletIdAndTransactionId(Integer walletId, Integer transactionId);

    @Transactional
    @Query(value = "SELECT * FROM transaction where id_transaction = :transactionId", nativeQuery = true)
    Transaction viewTransactionByTransactionId(Integer transactionId);

    @Transactional
    @Procedure(procedureName = "viewTodayIncome")
    List<BigDecimal> viewTodayIncome(Integer accountId, Integer walletId);

    @Transactional
    @Procedure(procedureName = "viewTodayExpense")
    List<BigDecimal> viewTodayExpense(Integer accountId, Integer walletId);


    @Transactional
    @Modifying
    @Procedure(procedureName = "InsertIntoTransactionByWalletId")
    void InsertIntoTransactionByWalletId(Integer walletId, BigDecimal stmTransaction, Integer statementType, LocalDateTime dateTransaction,
                                         String description, String imageUrl, Integer debtIdDebt, Integer goalIdGoal);


    @Transactional
    @Modifying
    @Query(value = "UPDATE transaction SET image_url = :imageUrl WHERE id_transaction = :transactionId", nativeQuery = true)
    void updateImageUrlInTransactionToCloud(String imageUrl, Integer transactionId);

    @Transactional
    @Modifying
    @Procedure(procedureName = "DeleteTransactionByTransactionId")
    void deleteTransactionByTransactionId(Integer transactionId, BigDecimal stmTransaction, String stmType, Integer walletId);

    @Transactional
    @Modifying
    @Procedure(procedureName = "UpdateTransaction")
    void updateTransaction(Integer walletId, Integer transactionId, BigDecimal stmTransaction, Integer statementType, LocalDateTime dateTransaction, String description, String imageUrl, Integer debtIdDebt, Integer goalIdGoal);
}