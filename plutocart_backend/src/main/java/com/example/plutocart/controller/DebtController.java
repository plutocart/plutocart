package com.example.plutocart.controller;

import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.services.DebtService;
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
public class DebtController {

    @Autowired
    DebtService debtService;

    @GetMapping("account/{account-id}/debt")
    public ResponseEntity<GenericResponse> getDebtByAccountId(@RequestHeader("Authorization") String token,
                                                              @Valid @PathVariable(value = "account-id") String accountId,
                                                              @RequestParam(value = "status", required = false) Integer status) throws PlutoCartServiceApiException {
        GenericResponse result = debtService.getDebtByAccountId(accountId,status, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }


    @PostMapping("account/{account-id}/debt")
    public ResponseEntity<GenericResponse> createDebtByAccountId(@RequestHeader("Authorization") String token,
                                                                 @Valid @PathVariable(value = "account-id") String accountId,
                                                                 @RequestParam(name = "nameDebt") String nameDebt,
                                                                 @RequestParam(name = "totalDebt") String totalDebt,
                                                                 @RequestParam(name = "totalPeriod") String totalPeriod,
                                                                 @RequestParam(name = "paidPeriod") String paidPeriod,
                                                                 @RequestParam(name = "monthlyPayment") String monthlyPayment,
                                                                 @RequestParam(name = "debtPaid") String debtPaid,
                                                                 @RequestParam(name = "moneyLender") String moneyLender,
                                                                 @RequestParam(name = "latestPayDate", required = false)
                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime latestPayDate
    ) throws PlutoCartServiceApiException {
//        LocalDateTime actualEndDateGoal = (latestPayDate != null) ? latestPayDate : LocalDateTime.now();
        GenericResponse result = debtService.insertDebtByAccountId(accountId, nameDebt, totalDebt, totalPeriod, paidPeriod, monthlyPayment, debtPaid, moneyLender, latestPayDate, token);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @PatchMapping("account/{account-id}/debt/{debt-id}")
    public ResponseEntity<GenericResponse> updateDebtByAccountId(@RequestHeader("Authorization") String token,
                                                                 @Valid @PathVariable(value = "account-id") String accountId,
                                                                 @Valid @PathVariable(value = "debt-id") String debtId,
                                                                 @RequestParam(name = "nameDebt") String nameDebt,
                                                                 @RequestParam(name = "totalDebt") String totalDebt,
                                                                 @RequestParam(name = "totalPeriod") String totalPeriod,
                                                                 @RequestParam(name = "paidPeriod") String paidPeriod,
                                                                 @RequestParam(name = "monthlyPayment") String monthlyPayment,
                                                                 @RequestParam(name = "debtPaid") String debtPaid,
                                                                 @RequestParam(name = "moneyLender") String moneyLender,
                                                                 @RequestParam(name = "latestPayDate", required = false)
                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime latestPayDate
    ) throws PlutoCartServiceApiException {
//        LocalDateTime actualEndDateGoal = (latestPayDate != null) ? latestPayDate : LocalDateTime.now();
        GenericResponse result = debtService.updateDebtByAccountId(accountId, debtId, nameDebt, totalDebt, totalPeriod, paidPeriod, monthlyPayment, debtPaid, moneyLender, latestPayDate, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PatchMapping("account/{account-id}/debt/{debt-id}/complete-now")
    public ResponseEntity<GenericResponse> updateDebtToComplete(@RequestHeader("Authorization") String token,
                                                                @Valid @PathVariable(value = "account-id") String accountId,
                                                                @Valid @PathVariable(value = "debt-id") String debtId
    ) throws PlutoCartServiceApiException {
        GenericResponse result = debtService.updateDebtToComplete(accountId, debtId, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @DeleteMapping("account/{account-id}/debt/{debt-id}")
    public ResponseEntity<GenericResponse> deleteDebtByAccountId(@RequestHeader("Authorization") String token,
                                                                 @Valid @PathVariable(value = "account-id") String accountId,
                                                                 @Valid @PathVariable(value = "debt-id") String debtId
    ) throws Exception {
//        LocalDateTime actualEndDateGoal = (latestPayDate != null) ? latestPayDate : LocalDateTime.now();
        GenericResponse result = debtService.deleteDebtByAccountId(accountId, debtId, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

}