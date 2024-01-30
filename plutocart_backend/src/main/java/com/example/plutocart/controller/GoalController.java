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
    public ResponseEntity<GenericResponse> getGoalByAccountId(@PathVariable("account-id") String accountId) throws PlutoCartServiceApiException {

        GenericResponse result = goalService.getGoalByAccountId(accountId);

        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PostMapping("account/{account-id}/goal")
    public ResponseEntity<GenericResponse> createGoalByAccountId(@Valid @PathVariable(value = "account-id") String accountId,
                                                                 @RequestParam(name = "nameGoal") String nameGoal,
                                                                 @RequestParam(name = "amountGoal") String amountGoal,
                                                                 @RequestParam(name = "deficit") String deficit,
                                                                 @RequestParam(name = "endDateGoal", required = false)
                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endDateGoal
    ) throws PlutoCartServiceApiException {
        LocalDateTime actualEndDateGoal = (endDateGoal != null) ? endDateGoal : LocalDateTime.now();
        GenericResponse result = goalService.insertGoalByAccountId(accountId, nameGoal, amountGoal, deficit, actualEndDateGoal);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @PatchMapping("account/{account-id}/goal/{goal-id}")
    public ResponseEntity<GenericResponse> updateGoalByAccountId(@Valid @PathVariable(value = "account-id") String accountId,
                                                                 @Valid @PathVariable(value = "goal-id") String goalId,
                                                                 @RequestParam(name = "nameGoal") String nameGoal,
                                                                 @RequestParam(name = "amountGoal") String amountGoal,
                                                                 @RequestParam(name = "deficit") String deficit,
                                                                 @RequestParam(name = "endDateGoal")
                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endDateGoal
    ) throws PlutoCartServiceApiException {
//        LocalDateTime actualEndDateGoal = (endDateGoal != null) ? endDateGoal : LocalDateTime.now();
        GenericResponse result = goalService.updateGoalByAccountId(accountId, goalId, nameGoal, amountGoal, deficit, endDateGoal);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

}
