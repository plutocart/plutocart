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
                                                              @Valid @PathVariable(value = "account-id") String accountId) throws PlutoCartServiceApiException {
        GenericResponse result = debtService.getDebtByAccountId(accountId, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }


    @PostMapping("account/{account-id}/debt")
    public ResponseEntity<GenericResponse> createDebtByAccountId(@RequestHeader("Authorization") String token,
                                                                 @Valid @PathVariable(value = "account-id") String accountId,
                                                                 @RequestParam(name = "nameDebt") String nameDebt,
                                                                 @RequestParam(name = "amountDebt") String amountDebt,
                                                                 @RequestParam(name = "payPeriod") String payPeriod,
                                                                 @RequestParam(name = "numOfPaidPeriod") String numOfPaidPeriod,
                                                                 @RequestParam(name = "paidDebtPerPeriod") String paidDebtPerPeriod,
                                                                 @RequestParam(name = "totalPaidDebt") String totalPaidDebt,
                                                                 @RequestParam(name = "moneyLender") String moneyLender,
                                                                 @RequestParam(name = "latestPayDate", required = false)
                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime latestPayDate
    ) throws PlutoCartServiceApiException {
//        LocalDateTime actualEndDateGoal = (latestPayDate != null) ? latestPayDate : LocalDateTime.now();
        GenericResponse result = debtService.insertDebtByAccountId(accountId, nameDebt, amountDebt, payPeriod, numOfPaidPeriod, paidDebtPerPeriod, totalPaidDebt, moneyLender, latestPayDate, token);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @PatchMapping("account/{account-id}/debt/{debt-id}")
    public ResponseEntity<GenericResponse> updateDebtByAccountId(@RequestHeader("Authorization") String token,
                                                                 @Valid @PathVariable(value = "account-id") String accountId,
                                                                 @Valid @PathVariable(value = "debt-id") String debtId,
                                                                 @RequestParam(name = "nameDebt") String nameDebt,
                                                                 @RequestParam(name = "amountDebt") String amountDebt,
                                                                 @RequestParam(name = "payPeriod") String payPeriod,
                                                                 @RequestParam(name = "numOfPaidPeriod") String numOfPaidPeriod,
                                                                 @RequestParam(name = "paidDebtPerPeriod") String paidDebtPerPeriod,
                                                                 @RequestParam(name = "totalPaidDebt") String totalPaidDebt,
                                                                 @RequestParam(name = "moneyLender") String moneyLender,
                                                                 @RequestParam(name = "latestPayDate", required = false)
                                                                 @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime latestPayDate
    ) throws PlutoCartServiceApiException {
//        LocalDateTime actualEndDateGoal = (latestPayDate != null) ? latestPayDate : LocalDateTime.now();
        GenericResponse result = debtService.updateDebtByAccountId(accountId, debtId, nameDebt, amountDebt, payPeriod, numOfPaidPeriod, paidDebtPerPeriod, totalPaidDebt, moneyLender, latestPayDate, token);
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