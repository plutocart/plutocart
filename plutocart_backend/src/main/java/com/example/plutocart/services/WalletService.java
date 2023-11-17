package com.example.plutocart.services;
import com.example.plutocart.dtos.WalletDto;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.WalletRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
    public List<WalletDto> getWalletByIdAccount(Integer accountId) {
        try {
            List<Wallet> walletList = walletRepository.viewWalletByAccountId(accountRepository.findById(accountId).get().getAccountId());
            return walletList.stream().map(e -> modelMapper.map(e, WalletDto.class)).collect(Collectors.toList());
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Id account  not found !");
        }
    }

    public WalletDto getWalletByIdAccountAndByWalletId(Integer idAccount, int walletId) {
        try {
            Wallet wallet = walletRepository.viewWalletByAccountIdAndWalletId(accountRepository.findById(idAccount).get().getAccountId(), walletRepository.findById(walletId).get().getWalletId());
            return modelMapper.map(wallet, WalletDto.class);
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Id account or id wallet not found !");
        }
    }

    //    Post
    public void crateWallet(Wallet wallet, Integer idAccount) {
        try {
            walletRepository.insertWalletByAccountID(wallet.getWalletName(), wallet.getWalletBalance(), accountRepository.findById(idAccount).get().getAccountId(), LocalDateTime.now(), LocalDateTime.now()); // account guest
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }

    //    Update
    public void updateNameWallet(String wallet_name, Integer idAccount, int walletId) {
        try {
            walletRepository.updateNameWallet(wallet_name, idAccount, walletId);
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }

    public void updateStatusWallet(Integer idAccount, int walletId) {
        try {
            walletRepository.updateStatusWallet((byte) (walletRepository.findById(walletId).get().getStatusWallet() == 1 ? 0 : 1), accountRepository.findById(idAccount).get().getAccountId(), walletId);
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
    }

    // Delete
    public void deleteWalletByAccountIdAndWalletId(Integer idAccount, int walletId) {
        if (walletRepository.findById(walletId).isPresent()) {
            walletRepository.deleteWalletByAccountIdAndWalletId(idAccount, walletId);
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }

    }
}

