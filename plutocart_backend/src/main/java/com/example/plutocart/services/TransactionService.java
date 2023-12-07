package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.example.plutocart.constants.ErrorMessage;
import com.example.plutocart.dtos.transaction.TResPostDTO;
import com.example.plutocart.dtos.transaction.TransactionResponseGetDTO;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.TransactionCategoryRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.repositories.WalletRepository;
import com.example.plutocart.utils.GenericResponse;
import com.example.plutocart.utils.ResultCode;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TransactionService {
    @Autowired
    Cloudinary cloudinary;
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    WalletRepository walletRepository;
    @Autowired
    TransactionRepository transactionRepository;
    @Autowired
    TransactionCategoryRepository transactionCategoryRepository;


    @Transactional
    public GenericResponse getTransactionByAccountId(Integer accountId) {
        GenericResponse response = new GenericResponse();

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountId);
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public GenericResponse getTransactionByWalletId(Integer walletId) {
        GenericResponse response = new GenericResponse();

        List<Transaction> transactionList = transactionRepository.viewTransactionByWalletId(walletId);
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public GenericResponse getTransactionByWalletIdAndTransactionId(Integer walletId, Integer transactionId) {
        GenericResponse response = new GenericResponse();

//        List<Transaction> transactionList = transactionRepository.viewTransactionByWalletIdAndTransactionId(walletId,transactionId);
//        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        Transaction transaction = transactionRepository.viewTransactionByWalletIdAndTransactionId(walletId, transactionId);
        TransactionResponseGetDTO transactionResponse = modelMapper.map(transaction, TransactionResponseGetDTO.class);

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public GenericResponse getTransactionByTransactionId(Integer transactionId) {
        GenericResponse response = new GenericResponse();

        Transaction transaction = transactionRepository.viewTransactionByTransactionId(transactionId);
        TransactionResponseGetDTO transactionResponse = modelMapper.map(transaction, TransactionResponseGetDTO.class);

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    @Transactional
    public GenericResponse createTransaction(TResPostDTO transactionReq, Integer walletId) {
        GenericResponse response = new GenericResponse();

        transactionRepository.InsertIntoTransactionByWalletId(transactionReq.getStmTransaction(),transactionReq.getStatementType(), walletId);
        transactionReq.setWalletId(walletId);
        transactionReq.setDescription("Create Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionReq);
        return response;
    }

//    public List<Transaction> getTransactionByAccountId(int accountId) {
//        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountRepository.findById(accountId).orElseThrow().getAccountId());
////        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountId);
////        Object response = transactionList.stream().map(e -> modelMapper.map(e, Transaction.class)).collect(Collectors.toList());
////        Transformation transformation = new Transformation().width(300).height(200).crop("fill");
////        cloudinary.url().transformation(new Transformation()).generate(imageRepository.getImageById(id));
//        System.out.println(transactionList);
//        return transactionList;
//    }
}