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
    public List<WalletDto> getWalletByIdAccount(Integer account_id) {
        try {
            List<Wallet> walletList = walletRepository.viewWalletByAccountId(accountRepository.findById(account_id).get().getId());
            return walletList.stream().map(e -> modelMapper.map(e, WalletDto.class)).collect(Collectors.toList());
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
    public Wallet crateWallet(Wallet wallet, Integer account_id) {
        try {
            walletRepository.insertWalletByAccountID(wallet.getNameWallet(), wallet.getBalanceWallet(), accountRepository.findById(account_id).get().getId(), LocalDateTime.now(), LocalDateTime.now()); // account guest
            return wallet;
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }

    }

    //    Update
    public void updateNameWallet(String wallet_name, Integer account_id, int wallet_id) {
        try {
            walletRepository.updateNameWallet(wallet_name, account_id, wallet_id);
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }

    public void updateStatusWallet(Integer account_id, int wallet_id) {
        try {
            walletRepository.updateStatusWallet((byte) (walletRepository.findById(wallet_id).get().getStatusWallet() == 1 ? 0 : 1), accountRepository.findById(account_id).get().getId(), wallet_id);
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }

    // Delete
    public void deleteWalletByAccountIdAndWalletId(Integer account_id, int wallet_id) {
        if (walletRepository.findById(wallet_id).isPresent()) {
            walletRepository.deleteWalletByAccountIdAndWalletId(account_id, wallet_id);

        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }

    }
}

