package com.example.plutocart.controller;


import com.example.plutocart.services.TransactionCategoryService;
import com.example.plutocart.utils.GenericResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class TransactionCategoryController {

    @Autowired
    TransactionCategoryService transactionCategoryService;

    @GetMapping("/transaction-category/income")
    private ResponseEntity<GenericResponse> getAllTranCaTypeIncome() {
        GenericResponse result = transactionCategoryService.getAllTransactionCategoryType(1);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
    @GetMapping("/transaction-category/expense")
    private ResponseEntity<GenericResponse> getAllTranCaTypeExpense() {
        GenericResponse result = transactionCategoryService.getAllTransactionCategoryType(2);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
