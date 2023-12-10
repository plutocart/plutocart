package com.example.plutocart.controller;

import com.example.plutocart.services.TransactionService;
import com.example.plutocart.utils.GenericResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class TransactionController {
    @Autowired
    TransactionService transactionService;

    @GetMapping("/account/{account-id}/transaction")
    private ResponseEntity<GenericResponse> getTransactionByAccountId(@PathVariable("account-id") Integer accountId) {
        GenericResponse result = transactionService.getTransactionByAccountId(accountId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/wallet/{wallet-id}/transaction")
    private ResponseEntity<GenericResponse> getTransactionByWalletId(@PathVariable("wallet-id") Integer walletId) {
        GenericResponse result = transactionService.getTransactionByWalletId(walletId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/wallet/{wallet-id}/transaction/{transaction-id}")
    private ResponseEntity<GenericResponse> getTransactionByWalletId(@PathVariable("wallet-id") Integer walletId, @PathVariable("transaction-id") Integer transactionId) {
        GenericResponse result = transactionService.getTransactionByWalletIdAndTransactionId(walletId, transactionId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/transaction/{transaction-id}")
    private ResponseEntity<GenericResponse> getTransactionByTransactionId(@PathVariable("transaction-id") Integer transactionId) {
        GenericResponse result = transactionService.getTransactionByTransactionId(transactionId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PostMapping("/wallet/{wallet-id}/transaction")
    private ResponseEntity<GenericResponse> createTransactions(@RequestParam(name = "file", required = false) MultipartFile file,
                                                               @RequestParam("stmTransaction") BigDecimal stmTransaction,
                                                               @RequestParam("statementType") Integer statementType,
                                                               @RequestParam(name = "dateTransaction", required = false)
                                                               @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime dateTransaction,
                                                               @RequestParam(name = "description", required = false, defaultValue = "null") String description,
                                                               @RequestParam(name = "debtIdDebt", required = false) Optional<Integer> debtIdDebt,
                                                               @RequestParam(name = "goalIdGoal", required = false) Optional<Integer> goalIdGoal,
                                                               @PathVariable("wallet-id") Integer walletId) throws IOException {

        LocalDateTime actualDateTransaction = (dateTransaction != null) ? dateTransaction : LocalDateTime.now();

        Integer actualDebtId = debtIdDebt.orElse(null);
        Integer actualGoalId = goalIdGoal.orElse(null);
        GenericResponse result = transactionService.createTransaction(walletId, file, stmTransaction, statementType, actualDateTransaction, description, actualDebtId, actualGoalId);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @PatchMapping("wallet/{wallet-id}/transaction/{transaction-id}")
    private ResponseEntity<GenericResponse> updateTransaction(@RequestParam(name = "file", required = false) MultipartFile file,
                                                              @RequestParam("stmTransaction") BigDecimal stmTransaction,
                                                              @RequestParam("statementType") Integer statementType,
                                                              @RequestParam(name = "dateTransaction", required = false)
                                                              @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime dateTransaction,
                                                              @RequestParam(name = "description", required = false, defaultValue = "null") String description,
                                                              @RequestParam(name = "debtIdDebt", required = false) Optional<Integer> debtIdDebt,
                                                              @RequestParam(name = "goalIdGoal", required = false) Optional<Integer> goalIdGoal,
                                                              @PathVariable("wallet-id") Integer walletId,
                                                              @PathVariable("transaction-id") Integer transactionId) throws Exception {

        LocalDateTime actualDateTransaction = (dateTransaction != null) ? dateTransaction : LocalDateTime.now();
        Integer actualDebtId = debtIdDebt.orElse(null);
        Integer actualGoalId = goalIdGoal.orElse(null);
        GenericResponse result = transactionService.updateTransaction(walletId, transactionId, file, stmTransaction, statementType, actualDateTransaction, description, actualDebtId, actualGoalId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @DeleteMapping("wallet/{wallet-id}/transaction/{transaction-id}")
    private ResponseEntity<GenericResponse> deleteTransactions(@PathVariable("wallet-id") Integer walletId, @PathVariable("transaction-id") Integer transactionId) throws Exception {
        GenericResponse result = transactionService.deleteTransaction(walletId, transactionId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
