package com.example.plutocart.repositories;

import com.example.plutocart.entities.Debt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DebtRepository extends JpaRepository<Debt, Integer> {
}