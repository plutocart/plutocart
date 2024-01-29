package com.example.plutocart.controller;


import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.services.AccountService;
import com.example.plutocart.utils.GenericResponse;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api")
@RestController
public class AccountController {
    @Autowired
    AccountService accountService;

    @PostMapping("/account/register/guest")
    public ResponseEntity<GenericResponse> createAccountByImei(@Valid @RequestBody AccountDTO accountDTO  ){
        GenericResponse result = accountService.CreateAccountByImei(accountDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }
    @PostMapping("/account/register/member")
    public ResponseEntity<GenericResponse> createAccountByGoogle(@Valid @RequestBody AccountDTO accountDTO){
        GenericResponse result = accountService.CreateAccountByGoogle(accountDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }
    @DeleteMapping("/account/{account-id}/delete-account")
    public ResponseEntity<GenericResponse> deleteAccount(@Valid @PathVariable(value = "account-id") Integer accountId , @RequestHeader("Authorization") String token){
        System.out.println(token);
        GenericResponse result = accountService.DeleteAccount(accountId , token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PatchMapping("/account/{account-id}/upgrade-role-member")
    public ResponseEntity<GenericResponse> updateAccountToMember(@Valid @PathVariable(value = "account-id") Integer accountId , @RequestParam(name = "email") String email , @RequestHeader("Authorization") String token){
        GenericResponse result = accountService.UpdateAccountToMember(email , accountId , token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
