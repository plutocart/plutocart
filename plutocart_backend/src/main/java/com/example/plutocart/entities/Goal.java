package com.example.plutocart.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "goal")
public class Goal {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_goal", nullable = false)
    private Integer id;

    @Column(name = "name_goal", nullable = false, length = 45)
    private String nameGoal;

    @Column(name = "total_goal", nullable = false, precision = 13, scale = 2)
    private BigDecimal totalGoal;

    @Column(name = "collected_money", nullable = false, precision = 13, scale = 2)
    private BigDecimal collectedMoney;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "account_id_account", nullable = false)
    private Account accountIdAccount;

    @Column(name = "create_goal_on", nullable = false)
    private Instant createGoalOn;

    @Column(name = "update_goal_on", nullable = false)
    private Instant updateGoalOn;

    @OneToMany(mappedBy = "goalIdGoal")
    private Set<Transaction> transactions = new LinkedHashSet<>();

    @NotNull
    @Column(name = "end_date_goal", nullable = false)
    private LocalDateTime endDateGoal;

    @NotNull
    @Column(name = "status_goal", nullable = false)
    private Integer statusGoal;

}