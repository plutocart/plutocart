package com.example.plutocart.services;

import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.constants.ErrorMessage;
import com.example.plutocart.dtos.wallet.WalletDTO;
import com.example.plutocart.dtos.wallet.WalletPostDTO;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.repositories.WalletRepository;
import com.example.plutocart.utils.HelperMethod;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.math.BigDecimal;
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
    TransactionRepository transactionRepository;
    @Autowired
    TransactionService transactionService;
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    WalletDTO walletDto;


    // Get
    public ResponseEntity<List<WalletDTO>> getWalletByIdAccount(Integer accountId, String token) {
        String userId = JwtUtil.extractUsername(token);
        if (Integer.parseInt(userId) == accountId) {
            List<Wallet> walletList = walletRepository.viewWalletByAccountId(accountRepository.findById(accountId).orElseThrow().getAccountId());
            return ResponseEntity.status(HttpStatus.OK).body(walletList.stream().map(e -> modelMapper.map(e, WalletDTO.class)).collect(Collectors.toList()));
        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }

    }

    public ResponseEntity<List<WalletDTO>> getWalletByIdAccountStatusOn(Integer accountId, String token) {
        String userId = JwtUtil.extractUsername(token);
        if (Integer.parseInt(userId) == accountId) {
            List<Wallet> walletList = walletRepository.viewWalletByAccountIdStatusOn(accountRepository.findById(accountId).orElseThrow().getAccountId());
            return ResponseEntity.status(HttpStatus.OK).body(walletList.stream().map(e -> modelMapper.map(e, WalletDTO.class)).collect(Collectors.toList()));
        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }
    }


    public ResponseEntity<?> getWalletByIdAccountAndByWalletId(String accountId, String walletId, String token) {
        String userId = JwtUtil.extractUsername(token);
        if (userId.equals(accountId)) {
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
        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }

    }


    //    Post
    public ResponseEntity<WalletPostDTO> crateWallet(Wallet wallet, Integer accountId, String token) {
        String userId = JwtUtil.extractUsername(token);
        if (Integer.parseInt(userId) == accountId) {
            walletRepository.insertWalletByAccountId(wallet.getWalletName(), wallet.getWalletBalance(), accountRepository.findById(accountId).get().getAccountId());
            Wallet wallet1 = walletRepository.viewWalletByAccountId(accountId).get(walletRepository.viewWalletByAccountId(accountId).toArray().length - 1);
            wallet.setWalletId(wallet1.getWalletId());
            return ResponseEntity.status(HttpStatus.CREATED).body(modelMapper.map(wallet, WalletPostDTO.class));
        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }
    }

    //    Update
    public void updateWallet(String walletName, BigDecimal balanceWallet, String accountId, String walletId, String token) {
        String userId = JwtUtil.extractUsername(token);
        if (accountId.equals(userId)) {
            try {
                int acId = Integer.parseInt(accountId);
                int wId = Integer.parseInt(walletId);
                walletRepository.updateWallet(walletName, balanceWallet, acId, wId);
            } catch (Exception ex) {
                handleAccountIdAndWalletIdExceptions(accountId, walletId);
            }
        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }
    }

    public void updateStatusWallet(String accountId, String walletId, String token) {
        String userId = JwtUtil.extractUsername(token);
        if (accountId.equals(userId)) {
            try {
                int acId = Integer.parseInt(accountId);
                int wId = Integer.parseInt(walletId);
                walletRepository.updateStatusWallet((byte) (walletRepository.findById(wId).get().getStatusWallet() == 1 ? 0 : 1), accountRepository.findById(acId).get().getAccountId(), wId);
            } catch (Exception ex) {
                handleAccountIdAndWalletIdExceptions(accountId, walletId);
            }
        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
        }


    }

    // Delete
    public void deleteWalletByAccountIdAndWalletId(String accountId, String walletId, String token) {
        String userId = JwtUtil.extractUsername(token);
        if (userId.equals(accountId)) {
            try {
                int acId = Integer.parseInt(accountId);
                int wId = Integer.parseInt(walletId);

                List<Transaction> transactionList = transactionRepository.viewTransactionByWalletId(wId);
                if (transactionList != null && !transactionList.isEmpty())
                    for (Transaction transaction : transactionList) {
                        String tranId = String.valueOf(transaction.getId());
                        transactionService.deleteTransaction(accountId, walletId, tranId, token);
//                        transactionService.deleteTransaction(accountId , wId, transaction.getId() , token);
                    }
                walletRepository.deleteWalletByAccountIdAndWalletId(acId, wId);
            } catch (Exception ex) {
                handleAccountIdAndWalletIdExceptions(accountId, walletId);
            }
        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN);
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

