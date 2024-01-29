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
import java.util.List;

@Repository
public interface GoalRepository extends JpaRepository<Goal, Integer> {


    @Transactional
    @Query(value = "SELECT * FROM goal where account_id_account = :accountId", nativeQuery = true)
    List<Goal> viewGoalByAccountId(Integer accountId);

    @Transactional
    @Query(value = "SELECT * FROM goal where id_goal = :goalId", nativeQuery = true)
    Goal viewGoalByGoalId(Integer goalId);

    @Transactional
    @Modifying
    @Procedure(procedureName = "createGoalByAccountId")
    void insertGoalByAccountId(String nameGoal, BigDecimal amountGoal, BigDecimal deficit, LocalDateTime endDateGoal, Integer accountId);
}