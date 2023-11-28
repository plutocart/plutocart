package com.example.plutocart.services;

import com.example.plutocart.constants.ErrorMessage;
import com.example.plutocart.dtos.wallet.WalletDTO;
import com.example.plutocart.dtos.wallet.WalletPostDTO;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.helper.HelperMethod;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.WalletRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;
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
    WalletDTO walletDto;


    // Get
    public ResponseEntity<List<WalletDTO>> getWalletByIdAccount(Integer accountId) {
        List<Wallet> walletList = walletRepository.viewWalletByAccountId(accountRepository.findById(accountId).orElseThrow().getAccountId());
        return ResponseEntity.status(HttpStatus.OK).body(walletList.stream().map(e -> modelMapper.map(e, WalletDTO.class)).collect(Collectors.toList()));
    }


    public ResponseEntity<?> getWalletByIdAccountAndByWalletId(String accountId, String walletId) {
        try {
            try {
                int acId = Integer.parseInt(accountId);
                int wId = Integer.parseInt(walletId);
                Wallet wallet = walletRepository.viewWalletByAccountIdAndWalletId(accountRepository.findById(acId).get().getAccountId(), wId);
                return ResponseEntity.status(HttpStatus.OK).body(modelMapper.map(wallet, WalletDTO.class));
            } catch (Exception ex) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(handleAccountIdAndWalletIdExceptions(accountId, walletId));
            }
        } catch (NoSuchElementException noSuchElementException) {
            throw new NoSuchElementException(noSuchElementException.getMessage());
        }
    }


    //    Post
    public ResponseEntity<WalletPostDTO> crateWallet(Wallet wallet, Integer accountId) {
        walletRepository.insertWalletByAccountID(wallet.getWalletName(), wallet.getWalletBalance(), accountRepository.findById(accountId).get().getAccountId(), LocalDateTime.now(), LocalDateTime.now());
        return ResponseEntity.status(HttpStatus.CREATED).body(modelMapper.map(wallet, WalletPostDTO.class));
    }

    //    Update
    public void updateWallet(String walletName , BigDecimal balanceWallet, String accountId, String walletId) {
        try {
            int acId = Integer.parseInt(accountId);
            int wId = Integer.parseInt(walletId);
            walletRepository.updateWallet(walletName, balanceWallet , acId, wId);
        } catch (Exception ex) {
            handleAccountIdAndWalletIdExceptions(accountId, walletId);
        }
    }

    public void updateStatusWallet(String accountId, String walletId) {
        try {
            int acId = Integer.parseInt(accountId);
            int wId = Integer.parseInt(walletId);
            walletRepository.updateStatusWallet((byte) (walletRepository.findById(wId).get().getStatusWallet() == 1 ? 0 : 1), accountRepository.findById(acId).get().getAccountId(), wId);
        } catch (Exception ex) {
            handleAccountIdAndWalletIdExceptions(accountId, walletId);
        }

    }

    // Delete
    public void deleteWalletByAccountIdAndWalletId(String accountId, String walletId) {
        try {
            int acId = Integer.parseInt(accountId);
            int wId = Integer.parseInt(walletId);
            walletRepository.deleteWalletByAccountIdAndWalletId(acId, wId);
        } catch (Exception ex) {
            handleAccountIdAndWalletIdExceptions(accountId, walletId);
        }

    }


    private ResponseEntity<?> handleAccountIdAndWalletIdExceptions(String accountId, String walletId) {
        if (!HelperMethod.isInteger(accountId)) {
            throw new NoSuchElementException(ErrorMessage.NOTFOUND + " account Id " + accountId);
        } else if ((!HelperMethod.isInteger(accountId) && !HelperMethod.isInteger(walletId))
                || (!HelperMethod.isInteger(accountId) && walletRepository.findById(HelperMethod.changeStringToInteger(walletId)).isEmpty())
                || (!HelperMethod.isInteger(walletId) && walletRepository.findById(HelperMethod.changeStringToInteger(accountId)).isEmpty())
//                || (!HelperMethod.isInteger(accountId))
                || (accountRepository.findById(HelperMethod.changeStringToInteger(accountId)).isEmpty() && walletRepository.findById(HelperMethod.changeStringToInteger(walletId)).isEmpty())) {
            throw new NoSuchElementException(ErrorMessage.NOTFOUND + " account Id " + accountId + " and wallet Id " + walletId);
        } else {
            throw new NoSuchElementException(ErrorMessage.NOTFOUND + " wallet Id " + walletId);
        }

    }
}

