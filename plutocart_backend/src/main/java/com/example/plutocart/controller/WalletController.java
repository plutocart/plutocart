package com.example.plutocart.controller;
import com.example.plutocart.dtos.WalletDto;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.services.WalletService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class WalletController {

    @Autowired
    WalletService walletService;

    @GetMapping("/account/{account-id}/wallet")
    private List<WalletDto> getWalletService(@Valid @PathVariable("account-id") Integer accountId) {
        return walletService.getWalletByIdAccount(accountId);
    }

    @GetMapping("/account/{account-id}/wallet/{wallet-id}")
    private WalletDto getWalletByWalletIdService(@Valid @PathVariable("account-id") Integer accountId, @PathVariable("wallet-id") int walletId) {
        return walletService.getWalletByIdAccountAndByWalletId(accountId, walletId);
    }

    @PostMapping("/account/{account-id}/wallet")
    private void createWalletService(@Valid @RequestBody Wallet wallet, @PathVariable("account-id") Integer accountId) {
          walletService.crateWallet(wallet, accountId);
    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/wallet-name")
    private  void updateNameWalletService(@Valid @RequestParam("wallet-name") String walletName, @PathVariable("account-id") Integer accountId , @PathVariable("wallet-id") int walletId ){
         walletService.updateNameWallet(walletName,accountId, walletId );
    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/wallet-status")
    private void updateStatusWalletService(@Valid @PathVariable("account-id") int accountId , @PathVariable("wallet-id") int walletId){
          walletService.updateStatusWallet(accountId , walletId);
    }

    @DeleteMapping("/account/{account-id}/wallet/{wallet-id}")
    private void deleteWalletByAccountIdAndWalletId(@Valid @PathVariable("account-id") Integer accountId , @PathVariable("wallet-id") int walletId){
          walletService.deleteWalletByAccountIdAndWalletId(accountId , walletId);
    }

}
