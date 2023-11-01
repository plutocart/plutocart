package com.example.plutocart.services;

import com.example.plutocart.entities.Wallet;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.WalletRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.time.LocalDateTime;

@Service
public class WalletService {

    @Autowired
    AccountRepository accountRepository;
    @Autowired
    WalletRepository walletRepository;
    @Autowired
    ModelMapper modelMapper;

     public void crateWallet(@RequestBody Wallet wallet) throws Exception {
//            UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); // wait login
         //        walletRepository.insertWalletByAccountID(wallet.getNameWallet(), wallet.getBalanceWallet(), accountRepository.findById(2).get().getId(), LocalDateTime.now(), LocalDateTime.now()); // account customer
        walletRepository.insertWalletByAccountID(wallet.getNameWallet(), wallet.getBalanceWallet(), accountRepository.findById(1).get().getId(), LocalDateTime.now(), LocalDateTime.now()); // account guest

    }


}
