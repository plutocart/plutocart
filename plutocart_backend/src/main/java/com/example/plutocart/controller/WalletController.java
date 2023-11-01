package com.example.plutocart.controller;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.services.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*" , allowedHeaders = "*")
public class WalletController {

    @Autowired
    WalletService walletService;

    @GetMapping("")
    private String getTest(){
        return "test";
    }

    @PostMapping("/account/wallet")
    private ResponseEntity createWalletService(@RequestBody Wallet wallet) throws Exception {
        walletService.crateWallet(wallet);
        return ResponseEntity.status(201).build();
    }
}
