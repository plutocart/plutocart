package com.example.plutocart.repositories;

import com.example.plutocart.entities.Goal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Repository
public interface GoalRepository extends JpaRepository<Goal, Integer> {

    @Modifying
    @Transactional
    @Procedure(name = "createGoalByAccountId")
    void insertGoalByAccountId(String nameGoal , BigDecimal amountGoal , BigDecimal deficit , LocalDateTime endDateGoal , Integer accountId  );
}