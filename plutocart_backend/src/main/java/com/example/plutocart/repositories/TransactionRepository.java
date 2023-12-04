package com.example.plutocart.repositories;

import com.example.plutocart.entities.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Integer> {

    @Transactional
    @Query(value = "SELECT t.* FROM wallet w JOIN transaction t ON w.id_wallet = t.wallet_id_wallet and account_id_account = :accountId", nativeQuery = true)
    List<Transaction> viewTransactionByAccountId(int accountId);

    @Transactional
    @Modifying
    @Query(value = "insert into transaction (stm_transaction, statement_type , date_transaction , tran_category_id_category , description , image_url , debt_id_debt , goal_id_goal , create_transaction_on , update_transaction_on , wallet_id_wallet )" +
            " values(:stm_transaction , :statement_type , :date_transaction , :tran_category_id_category , :description , :image_url , :debt_id_debt , :goal_id_goal , :create_transaction_on , :update_transaction_on , :wallet_id_wallet)", nativeQuery = true)
    void insertTransactionByAccountID(BigDecimal stm_transaction, String statement_type, LocalDateTime date_transaction, Integer tran_category_id_category, String description, String image_url, Integer debt_id_debt, Integer goal_id_goal, LocalDateTime create_transaction_on, LocalDateTime update_transaction_on, Integer wallet_id_wallet);

}