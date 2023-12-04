package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.Transformation;
import com.cloudinary.utils.ObjectUtils;
import com.example.plutocart.dtos.transaction.TransactionPostDTO;
import com.example.plutocart.dtos.wallet.WalletDTO;
import com.example.plutocart.dtos.wallet.WalletPostDTO;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.utils.GenericResponse;
import com.example.plutocart.utils.ResultCode;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class TransactionService {
    @Autowired
    Cloudinary  cloudinary;
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    TransactionRepository transactionRepository;


    public Object getTransactionByAccountId(int accountId) {
        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountRepository.findById(accountId).orElseThrow().getAccountId());
//        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountId);
        Object response = transactionList.stream().map(e -> modelMapper.map(e, Transaction.class)).collect(Collectors.toList());
        Transformation transformation = new Transformation().width(300).height(200).crop("fill");
//        cloudinary.url().transformation(new Transformation()).generate(imageRepository.getImageById(id));
        System.out.println(transformation);
        return response;
    }

    public GenericResponse createTransaction(Transaction transaction, Integer walletId) {
        GenericResponse response = new GenericResponse();
        transactionRepository.insertTransactionByAccountID(transaction.getStmTransaction(),transaction.getStatementType(), LocalDateTime.now(),1,"test","img.path",null,null,LocalDateTime.now(),LocalDateTime.now(),walletId);
//        return ResponseEntity.status(HttpStatus.CREATED).body(modelMapper.map(transaction,Transaction.class));
//         ResponseEntity.status(HttpStatus.CREATED).body(modelMapper.map(transaction,Transaction.class));

//        Transaction transactionEntity = new Transaction();
//        transactionEntity.setStmTransaction(transaction.getStmTransaction());
//        transactionEntity.setStatementType(transaction.getStatementType());
//        transactionEntity.setCreateTransactionOn(Instant.from(LocalDateTime.now()));

        TransactionPostDTO transactionRes = modelMapper.map(transaction, TransactionPostDTO.class);
        transactionRes.setWalletId(walletId);

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionRes);
        return  response;
    }
}
















