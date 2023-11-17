package com.example.plutocart.controller;

import com.example.plutocart.dtos.WalletDto;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.services.WalletService;
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
    private List<WalletDto> getWalletService(@PathVariable("account-id") Integer account_id) {
        return walletService.getWalletByIdAccount(account_id);
    }

    @GetMapping("/account/{account-id}/wallet/{wallet-id}")
    private WalletDto getWalletByWalletIdService(@PathVariable("account-id") Integer account_id, @PathVariable("wallet-id") int wallet_id) {
        return walletService.getWalletByIdAccountAndByWalletId(account_id, wallet_id);
    }

    @PostMapping("/account/{account-id}/wallet")
    private Wallet createWalletService(@RequestBody Wallet wallet, @PathVariable("account-id") Integer account_id) {
         return walletService.crateWallet(wallet, account_id);
    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/wallet-name")
    private  void updateNameWalletService(@RequestParam("name-wallet") String name_wallet, @PathVariable("account-id") Integer account_id , @PathVariable("wallet-id") int wallet_id ){
         walletService.updateNameWallet(name_wallet ,account_id, wallet_id );
    }

    @PatchMapping("/account/{account-id}/wallet/{wallet-id}/wallet-status")
    private void updateStatusWalletService(@PathVariable("account-id") int account_id , @PathVariable("wallet-id") int wallet_id){
          walletService.updateStatusWallet(account_id , wallet_id);
    }

    @DeleteMapping("/account/{account-id}/wallet/{wallet-id}")
    private void deleteWalletByAccountIdAndWalletId(@PathVariable("account-id") Integer account_id , @PathVariable("wallet-id") int wallet_id){
          walletService.deleteWalletByAccountIdAndWalletId(account_id , wallet_id);
    }

}
