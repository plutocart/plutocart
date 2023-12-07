package com.example.plutocart.controller;

import com.example.plutocart.dtos.transaction.TResPostDTO;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.repositories.WalletRepository;
import com.example.plutocart.services.TransactionService;
import com.example.plutocart.utils.GenericResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
        GenericResponse result = transactionService.getTransactionByWalletIdAndTransactionId(walletId,transactionId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/transaction/{transaction-id}")
    private ResponseEntity<GenericResponse> getTransactionByTransactionId(@PathVariable("transaction-id") Integer transactionId) {
        GenericResponse result = transactionService.getTransactionByTransactionId(transactionId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

        @PostMapping("/wallet/{wallet-id}/transaction")
    private ResponseEntity<GenericResponse> createTransactions(@RequestBody TResPostDTO transactionReq, @PathVariable("wallet-id") Integer walletId) {
            GenericResponse result = transactionService.createTransaction(transactionReq, walletId);
            return ResponseEntity.status(HttpStatus.OK).body(result);
    }

}
