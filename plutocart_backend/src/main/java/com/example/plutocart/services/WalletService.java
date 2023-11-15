package com.example.plutocart.services;

import com.example.plutocart.dtos.WalletDto;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.WalletRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class WalletService {

    @Autowired
    AccountRepository accountRepository;
    @Autowired
    WalletRepository walletRepository;
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    WalletDto walletDto;


    // Get
    public ResponseEntity getWalletByIdAccount(Integer account_id) {
        try {
            List<Wallet> walletList = walletRepository.viewWalletByAccountId(accountRepository.findById(account_id).get().getId());
            return  ResponseEntity.status(HttpStatus.OK).body(walletList.stream().map(e -> modelMapper.map(e, WalletDto.class)).collect(Collectors.toList()));
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Id account  not found !");
        }

    }

    public WalletDto getWalletByIdAccountAndByWalletId(Integer account_id, int wallet_id) {
        try {
            Wallet wallet = walletRepository.viewWalletByAccountIdAndWalletId(accountRepository.findById(account_id).get().getId(), walletRepository.findById(wallet_id).get().getId());
            return modelMapper.map(wallet, WalletDto.class);
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Id account or id wallet not found !");
        }

    }

    //    Post
    public ResponseEntity crateWallet(Wallet wallet, Integer account_id) {
        try {
            walletRepository.insertWalletByAccountID(wallet.getNameWallet(), wallet.getBalanceWallet(), accountRepository.findById(account_id).get().getId(), LocalDateTime.now(), LocalDateTime.now()); // account guest
            return ResponseEntity.status(201).body("success");
        } catch (Exception ex) {
            System.out.println("test");
            return ResponseEntity.status(400).body("");
        }

    }

    //    Update
    public ResponseEntity updateNameWallet(String wallet_name, Integer account_id, int wallet_id) {
       try{
           if (wallet_name.equals(walletRepository.viewWalletByAccountIdAndWalletId(account_id, wallet_id).getNameWallet())) {
               return ResponseEntity.status(200).body("data up to date");
           } else {
               walletRepository.updateNameWallet(wallet_name, account_id, wallet_id);
               return ResponseEntity.status(200).body("update wallet name is : " + " " + wallet_name);
           }
       }
       catch (Exception ex){
           return  ResponseEntity.status(400).body("account id invalid");
       }
    }

    public ResponseEntity updateStatusWallet(Integer account_id, int wallet_id) {
        try {
            walletRepository.updateStatusWallet((byte) (walletRepository.findById(wallet_id).get().getStatusWallet() == 1 ? 0 : 1), accountRepository.findById(account_id).get().getId(), wallet_id);
            return ResponseEntity.status(200).body("update status wallet" + " " + ":" + (byte) (walletRepository.findById(wallet_id).get().getStatusWallet() == 1 ? 0 : 1));
        } catch (Exception ex) {
            return ResponseEntity.status(400).body("account id or wallet id not found or data invalid");
        }
    }

    // Delete
    public ResponseEntity deleteWalletByAccountIdAndWalletId(Integer account_id, int wallet_id) {
        if (walletRepository.findById(wallet_id).isPresent()) {
            walletRepository.deleteWalletByAccountIdAndWalletId(account_id, wallet_id);
            return ResponseEntity.ok().body("delete wallet number " + " " + wallet_id + " " + "account id" + " " + account_id);
        } else {
            return ResponseEntity.status(400).body("can't delete because account id or wallet id invalid !");
        }

    }
}

