package com.example.plutocart.controller;
import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.dtos.wallet.WalletDTO;
import com.example.plutocart.dtos.wallet.WalletPostDTO;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.services.WalletService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.math.BigDecimal;
import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/api")
public class WalletController {

    @Autowired
    WalletService walletService;
    @GetMapping("/account/{account-id}/wallet")
    private ResponseEntity<List<WalletDTO>> getWalletService(@Valid @PathVariable("account-id") String accountId , @RequestHeader("Authorization") String token) {
          try {
              int acId = Integer.parseInt(accountId);
              return walletService.getWalletByIdAccount(acId , token);
          }
          catch (Exception e){
              throw new NoSuchElementException(e.getMessage());
          }
      }
    @GetMapping("/account/{account-id}/wallet/status-on")
    private ResponseEntity<List<WalletDTO>> getAllWalletStatusOn(@Valid @PathVariable("account-id") String accountId , @RequestHeader("Authorization") String token) {
        try {
            int acId = Integer.parseInt(accountId);
            return walletService.getWalletByIdAccountStatusOn(acId , token);
        }
        catch (Exception e){
            throw new NoSuchElementException(e.getMessage());
        }

    }

    @GetMapping("/account/{account-id}/wallet/{wallet-id}")
    private ResponseEntity<?> getWalletByWalletIdService(@Valid @PathVariable("account-id") String accountId, @PathVariable("wallet-id") String walletId , @RequestHeader("Authorization") String token) {
            return walletService.getWalletByIdAccountAndByWalletId(accountId, walletId , token);
    }

    @PostMapping("/account/{account-id}/wallet")
    private ResponseEntity<WalletPostDTO> createWalletService(@Valid @RequestBody Wallet wallet, @PathVariable("account-id") String accountId , @RequestHeader("Authorization") String token) {
        try {
            int acId = Integer.parseInt(accountId);
            return walletService.crateWallet(wallet, acId , token);
        }
        catch (Exception e){
            throw new NoSuchElementException(e.getMessage());
        }

    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/wallet-name")
    private void updateNameWalletService(@Valid @RequestParam(name = "wallet-name" , defaultValue = "Unknown Wallet") String walletName, @RequestParam(name = "balance-wallet") BigDecimal balanceWallet ,
                                         @PathVariable("account-id") String accountId , @PathVariable("wallet-id") String walletId , @RequestHeader("Authorization") String token){
         walletService.updateWallet(walletName, balanceWallet ,accountId, walletId , token );
    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/wallet-status")
    private void updateStatusWalletService(@Valid @PathVariable("account-id") String accountId , @PathVariable("wallet-id") String walletId , @RequestHeader("Authorization") String token){
          walletService.updateStatusWallet(accountId , walletId , token);
    }

    @DeleteMapping("/account/{account-id}/wallet/{wallet-id}")
    private void deleteWalletByAccountIdAndWalletId( @PathVariable("account-id") String accountId , @PathVariable("wallet-id") String walletId , @RequestHeader("Authorization") String token){
          walletService.deleteWalletByAccountIdAndWalletId(accountId , walletId , token);
    }

}
