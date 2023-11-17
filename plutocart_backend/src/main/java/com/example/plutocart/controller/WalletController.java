package com.example.plutocart.controller;

import com.example.plutocart.entities.Wallet;
import com.example.plutocart.services.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class WalletController {

    @Autowired
    WalletService walletService;

    @GetMapping("/account/{account-id}/wallet")
    private ResponseEntity<?> getWalletService(@PathVariable("account-id") Integer account_id) {
        return ResponseEntity.status(200).body(walletService.getWalletByIdAccount(account_id));
    }

    @GetMapping("/account/{account-id}/wallet/{wallet-id}")
    private ResponseEntity<?> getWalletByWalletIdService(@PathVariable("account-id") Integer account_id, @PathVariable("wallet-id") int wallet_id) {
        return ResponseEntity.status(200).body(walletService.getWalletByIdAccountAndByWalletId(account_id, wallet_id));
    }

    @PostMapping("/account/{account-id}/wallet")
    private ResponseEntity<?> createWalletService(@RequestBody Wallet wallet, @PathVariable("account-id") Integer account_id) {
         return walletService.crateWallet(wallet, account_id);
    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/wallet-name")
    private ResponseEntity<?> updateNameWalletService(@RequestParam("name-wallet") String name_wallet, @PathVariable("account-id") Integer account_id , @PathVariable("wallet-id") int wallet_id ){
        return walletService.updateNameWallet(name_wallet ,account_id, wallet_id );
    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/wallet-status")
    private ResponseEntity<?> updateStatusWalletService(@PathVariable("account-id") int account_id , @PathVariable("wallet-id") int wallet_id){
         return walletService.updateStatusWallet(account_id , wallet_id);
    }

    @DeleteMapping("/account/{account-id}/wallet/{wallet-id}")
    private ResponseEntity<?> deleteWalletByAccountIdAndWalletId(@PathVariable("account-id") Integer account_id , @PathVariable("wallet-id") int wallet_id){
        return  walletService.deleteWalletByAccountIdAndWalletId(account_id , wallet_id);
    }

}
