package com.example.plutocart.repositories;

import com.example.plutocart.entities.TransactionCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TransactionCategoryRepository extends JpaRepository<TransactionCategory, Integer> {
}