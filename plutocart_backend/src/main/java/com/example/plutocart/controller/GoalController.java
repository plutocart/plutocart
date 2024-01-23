package com.example.plutocart.controller;

import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.services.GoalService;
import com.example.plutocart.utils.GenericResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
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
    public ResponseEntity<GenericResponse> createGoalByAccountId(@Valid @PathVariable(value = "account-id") Integer accountId ,
                                                                 @RequestParam(name = "nameGoal") String nameGoal ,
                                                                 @RequestParam(name = "amountGoal") BigDecimal amountGoal ,
                                                                 @RequestParam(name = "deficit") BigDecimal deficit ,
                                                                 @RequestParam(name = "endDateGoal", required = false)
                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endDateGoal
    ){
        LocalDateTime actualEndDateGoal = (endDateGoal != null) ? endDateGoal : LocalDateTime.now();
//        System.out.println(actualEndDateGoal);
////        System.out.println("account id : " + accountId);
////        System.out.println("nameGoal: " + nameGoal);
////        System.out.println("amountGoal : " + amountGoal);
////        System.out.println("deficit : " + deficit);
////        System.out.println("endDateGoal: " + endDateGoal);
        GenericResponse result = goalService.insertGoalByAccountId(nameGoal, amountGoal, deficit, actualEndDateGoal, accountId);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }
}
