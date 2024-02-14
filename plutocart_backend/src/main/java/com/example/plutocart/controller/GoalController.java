package com.example.plutocart.controller;

import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.services.GoalService;
import com.example.plutocart.utils.GenericResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api")
public class GoalController {
    @Autowired
    GoalService goalService;

    @GetMapping("account/{account-id}/goal")
    public ResponseEntity<GenericResponse> getGoalByAccountId(@RequestHeader("Authorization") String token,
                                                              @PathVariable("account-id") String accountId
    ) throws PlutoCartServiceApiException {
        GenericResponse result = goalService.getGoalByAccountId(accountId, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PostMapping("account/{account-id}/goal")
    public ResponseEntity<GenericResponse> createGoalByAccountId(@RequestHeader("Authorization") String token,
                                                                 @Valid @PathVariable(value = "account-id") String accountId,
                                                                 @RequestParam(name = "nameGoal") String nameGoal,
                                                                 @RequestParam(name = "amountGoal") String amountGoal,
                                                                 @RequestParam(name = "deficit") String deficit,
                                                                 @RequestParam(name = "endDateGoal", required = false)
                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endDateGoal
    ) throws PlutoCartServiceApiException {
        LocalDateTime actualEndDateGoal = (endDateGoal != null) ? endDateGoal : LocalDateTime.now();
        GenericResponse result = goalService.insertGoalByAccountId(accountId, nameGoal, amountGoal, deficit, actualEndDateGoal, token);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @PatchMapping("account/{account-id}/goal/{goal-id}")
    public ResponseEntity<GenericResponse> updateGoalByGoalId(@RequestHeader("Authorization") String token,
                                                              @Valid @PathVariable(value = "account-id") String accountId,
                                                              @Valid @PathVariable(value = "goal-id") String goalId,
                                                              @RequestParam(name = "nameGoal") String nameGoal,
                                                              @RequestParam(name = "amountGoal") String amountGoal,
                                                              @RequestParam(name = "deficit") String deficit,
                                                              @RequestParam(name = "endDateGoal")
                                                              @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endDateGoal
    ) throws PlutoCartServiceApiException {
//        LocalDateTime actualEndDateGoal = (endDateGoal != null) ? endDateGoal : LocalDateTime.now();
        GenericResponse result = goalService.updateGoalByGoalId(accountId, goalId, nameGoal, amountGoal, deficit, endDateGoal, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PatchMapping("account/{account-id}/goal/{goal-id}/complete-now")
    public ResponseEntity<GenericResponse> updateGoalToComplete(@RequestHeader("Authorization") String token,
                                                                @Valid @PathVariable(value = "account-id") String accountId,
                                                                @Valid @PathVariable(value = "goal-id") String goalId
    ) throws PlutoCartServiceApiException {
        GenericResponse result = goalService.updateGoalToComplete(accountId, goalId, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @DeleteMapping("account/{account-id}/goal/{goal-id}")
    public ResponseEntity<GenericResponse> deleteGoalByGoalId(@RequestHeader("Authorization") String token,
                                                              @PathVariable("account-id") String accountId,
                                                              @PathVariable("goal-id") String goalId
    ) throws Exception {
        GenericResponse result = goalService.deleteGoalByGoalId(accountId, goalId, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }


}
