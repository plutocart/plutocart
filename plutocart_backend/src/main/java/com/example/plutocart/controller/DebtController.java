package com.example.plutocart.controller;

import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.services.DebtService;
import com.example.plutocart.utils.GenericResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class DebtController {

    @Autowired
    DebtService debtService;

    @PostMapping("account/{account-id}/debt")
    public ResponseEntity<GenericResponse> createGoalByAccountId(
//            @RequestHeader("Authorization") String token,
            @Valid @PathVariable(value = "account-id") String accountId,
            @RequestParam(name = "nameDebt") String nameDebt,
            @RequestParam(name = "amountDebt") String amountDebt,
            @RequestParam(name = "installmentDebt") String installmentDebt,
            @RequestParam(name = "numOfInstallmentPay") String numOfInstallmentPay,
            @RequestParam(name = "totalPaidDebt") String totalPaidDebt,
            @RequestParam(name = "description") String description
//                                                                 @RequestParam(name = "endDateDebt", required = false)
//                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime endDateDebt
    ) throws PlutoCartServiceApiException {
//        LocalDateTime actualEndDateGoal = (endDateGoal != null) ? endDateGoal : LocalDateTime.now();
        GenericResponse result = debtService.insertDebtByAccountId(accountId, nameDebt, amountDebt, installmentDebt, numOfInstallmentPay, totalPaidDebt, description);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }
}