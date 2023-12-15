package com.example.plutocart.controller;


import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.services.AccountService;
import com.example.plutocart.utils.GenericResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api")
@RestController
public class AccountController {
    @Autowired
    AccountService accountService;

    @PostMapping("/account/imei")
    public ResponseEntity<GenericResponse> createAccountByImei(@Valid @RequestBody AccountDTO accountDTO){
        GenericResponse result = accountService.CreateAccountByImei(accountDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }
}
