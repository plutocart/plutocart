package com.example.plutocart.controller;

import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.services.TransactionService;
import com.example.plutocart.utils.GenericResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/api")
public class TransactionController {
    @Autowired
    TransactionService transactionService;

    @GetMapping("/account/{account-id}/transaction")
    private ResponseEntity<GenericResponse> getTransactionByAccountId(@PathVariable("account-id") String accountId) throws PlutoCartServiceApiException {
        GenericResponse result = transactionService.getTransactionByAccountId(accountId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/account/{account-id}/transaction-limit")
    private ResponseEntity<GenericResponse> getTransactionByAccountIdLimitThree(@PathVariable("account-id") String accountId) throws PlutoCartServiceApiException {
        GenericResponse result = transactionService.getTransactionByAccountIdLimitThree(accountId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/account/{account-id}/wallet/{wallet-id}/transaction")
    private ResponseEntity<GenericResponse> getTransactionByAccountIdAndWalletId(@PathVariable("account-id") String accountId,
                                                                                 @PathVariable("wallet-id") String walletId) throws PlutoCartServiceApiException {
        GenericResponse result = transactionService.getTransactionByAccountIdAndWalletId(accountId, walletId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/account/{account-id}/wallet/{wallet-id}/transaction/{transaction-id}")
    private ResponseEntity<GenericResponse> getTransactionByAccountIdAndWalletIdAndTransactionId(@PathVariable("account-id") String accountId,
                                                                                                 @PathVariable("wallet-id") String walletId,
                                                                                                 @PathVariable("transaction-id") String transactionId) throws PlutoCartServiceApiException {
        GenericResponse result = transactionService.getTransactionByAccountIdAndWalletIdAndTransactionId(accountId, walletId, transactionId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

//    @GetMapping("/transaction/{transaction-id}")
//    private ResponseEntity<GenericResponse> getTransactionByTransactionId(@PathVariable("transaction-id") Integer transactionId) {
//        GenericResponse result = transactionService.getTransactionByTransactionId(transactionId);
//        return ResponseEntity.status(HttpStatus.OK).body(result);
//    }
//
//    @GetMapping("/account/{account-id}/wallet/{wallet-id}/transaction/daily-income")
//    private ResponseEntity<GenericResponse> getTodayIncome(@PathVariable("account-id") Integer accountId, @PathVariable("wallet-id") Integer walletId) {
//        GenericResponse result = transactionService.getTodayIncome(accountId, walletId);
//        return ResponseEntity.status(HttpStatus.OK).body(result);
//    }
//
//    @GetMapping("/account/{account-id}/wallet/{wallet-id}/transaction/daily-expense")
//    private ResponseEntity<GenericResponse> getTodayExpense(@PathVariable("account-id") Integer accountId, @PathVariable("wallet-id") Integer walletId) {
//        GenericResponse result = transactionService.getTodayExpense(accountId, walletId);
//        return ResponseEntity.status(HttpStatus.OK).body(result);
//    }

    @GetMapping("/account/{account-id}/wallet/transaction/daily-income-and-expense")
    private ResponseEntity<GenericResponse> getTodayIncomeAndExpense(@PathVariable("account-id") String accountId) throws PlutoCartServiceApiException {
        GenericResponse result = transactionService.getTodayIncomeAndExpense(accountId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PostMapping("/account/{account-id}/wallet/{wallet-id}/transaction")
    private ResponseEntity<GenericResponse> createTransaction(
//            @RequestHeader("Authorization") String token,
            @RequestParam(name = "file", required = false) MultipartFile file,
            @RequestParam("stmTransaction") String stmTransaction,
            @RequestParam("statementType") String statementType,
            @RequestParam(name = "dateTransaction", required = false)
            @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime dateTransaction,
            @RequestParam(name = "transactionCategoryId") String transactionCategoryId,
            @RequestParam(name = "description", required = false, defaultValue = "null") String description,
            @RequestParam(name = "debtIdDebt", required = false) String debtIdDebt,
            @RequestParam(name = "goalIdGoal", required = false) String goalIdGoal,
            @PathVariable("account-id") String accountId,
            @PathVariable("wallet-id") String walletId) throws IOException, PlutoCartServiceApiException {

        LocalDateTime actualDateTransaction = (dateTransaction != null) ? dateTransaction : LocalDateTime.now();

//        Integer actualDebtId = debtIdDebt.orElse(null);
//        Integer actualGoalId = goalIdGoal.orElse(null);
        GenericResponse result = transactionService.createTransaction(accountId, walletId, file, stmTransaction, statementType, actualDateTransaction, transactionCategoryId, description, goalIdGoal, debtIdDebt
//                , token
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/transaction/{transaction-id}")
    private ResponseEntity<GenericResponse> updateTransaction(@RequestParam(name = "file", required = false) MultipartFile file,
                                                              @RequestParam("stmTransaction") String stmTransaction,
                                                              @RequestParam("statementType") String statementType,
                                                              @RequestParam(name = "dateTransaction", required = false)
                                                              @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime dateTransaction,
                                                              @RequestParam(name = "transactionCategoryId") String transactionCategoryId,
                                                              @RequestParam(name = "description", required = false, defaultValue = "null") String description,
                                                              @RequestParam(name = "debtIdDebt", required = false) String debtIdDebt,
                                                              @RequestParam(name = "goalIdGoal", required = false) String goalIdGoal,
                                                              @PathVariable("account-id") String accountId,
                                                              @PathVariable("wallet-id") String walletId,
                                                              @PathVariable("transaction-id") String transactionId) throws Exception {

        LocalDateTime actualDateTransaction = (dateTransaction != null) ? dateTransaction : LocalDateTime.now();
//        Integer actualDebtId = debtIdDebt.orElse(null);
//        Integer actualGoalId = goalIdGoal.orElse(null);
        GenericResponse result = transactionService.updateTransaction(accountId, walletId, transactionId, file, stmTransaction, statementType, actualDateTransaction, transactionCategoryId, description, goalIdGoal, debtIdDebt);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @DeleteMapping("/account/{account-id}/wallet/{wallet-id}/transaction/{transaction-id}")
    private ResponseEntity<GenericResponse> deleteTransaction(@PathVariable("account-id") String accountId,
                                                              @PathVariable("wallet-id") String walletId,
                                                              @PathVariable("transaction-id") String transactionId) throws Exception {
        GenericResponse result = transactionService.deleteTransaction(accountId, walletId, transactionId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
