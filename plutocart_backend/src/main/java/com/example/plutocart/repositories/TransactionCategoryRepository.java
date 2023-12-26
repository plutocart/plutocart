package com.example.plutocart.repositories;

import com.example.plutocart.entities.Transaction;
import com.example.plutocart.entities.TransactionCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface TransactionCategoryRepository extends JpaRepository<TransactionCategory, Integer> {
    @Transactional
    @Modifying
    @Query(value = "UPDATE transaction_category SET image_icon_url = :imageIconUrl WHERE id_transaction_category = :transactionCategoryId", nativeQuery = true)
    void updateTransactionCategoryImageIconUrl(String imageIconUrl, Integer transactionCategoryId);

    @Transactional
    @Query(value = "SELECT * FROM transaction_category where id_transaction_category = :transactionCategoryId", nativeQuery = true)
    TransactionCategory viewTransactionCategoryById(Integer transactionCategoryId);

}