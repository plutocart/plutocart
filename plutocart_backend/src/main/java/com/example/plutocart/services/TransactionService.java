package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.example.plutocart.dtos.transaction.TResDelDTO;
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
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
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
    @Autowired
    CloudinaryService cloudinaryService;


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
    public GenericResponse createTransaction(Integer walletId, MultipartFile file, BigDecimal stmTransaction, Integer statementType, LocalDateTime dateTransaction, String description, Integer debtIdDebt, Integer goalIdGoal) throws IOException {
        GenericResponse response = new GenericResponse();
        TResPostDTO tRes = new TResPostDTO();
        String imageUrl = null;

        if (!file.isEmpty()) {
            imageUrl = cloudinaryService.uploadImageInTransaction(file, transactionRepository::updateImageUrlInTransactionToCloud);
        }

        transactionRepository.InsertIntoTransactionByWalletId(walletId, stmTransaction, statementType, dateTransaction, description, imageUrl, debtIdDebt, goalIdGoal);
        Transaction currentTransaction = transactionRepository.viewTransactionByWalletId(walletId).get(transactionRepository.viewTransactionByWalletId(walletId).toArray().length - 1);


        tRes.setTransactionId(currentTransaction.getId());
        tRes.setStmTransaction(stmTransaction);
        tRes.setStatementType(statementType);
        tRes.setWalletId(walletId);
        tRes.setDescription("Create Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse updateTransaction(Integer walletId, Integer transactionId, MultipartFile file, BigDecimal stmTransaction, Integer statementType,LocalDateTime dateTransaction, String description, Integer debtIdDebt, Integer goalIdGoal) throws Exception {
        GenericResponse response = new GenericResponse();
        TResPostDTO tRes = new TResPostDTO();
        String imageUrl = null;

        Transaction transaction = transactionRepository.viewTransactionByTransactionId(transactionId);

        if (transaction.getWalletIdWallet().getWalletId() == walletId && transaction.getId() == transactionId) {
            if (transaction.getImageUrl() != null && !transaction.getImageUrl().isEmpty()) {
                cloudinaryService.deleteImageOnCloudInTransaction(transactionId);
            }

            if (!file.isEmpty()) {
                imageUrl = cloudinaryService.uploadImageInTransaction(file, transactionRepository::updateImageUrlInTransactionToCloud);
            }

            transactionRepository.updateTransaction(walletId, transactionId, stmTransaction, statementType, dateTransaction, description, imageUrl, debtIdDebt, goalIdGoal);
        }

        tRes.setTransactionId(transactionId);
        tRes.setWalletId(walletId);
        tRes.setDescription("Delete Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse deleteTransaction(Integer walletId, Integer transactionId) throws Exception {
        GenericResponse response = new GenericResponse();
        TResDelDTO tRes = new TResDelDTO();

        Transaction transaction = transactionRepository.viewTransactionByTransactionId(transactionId);

        if (transaction.getWalletIdWallet().getWalletId() == walletId && transaction.getId() == transactionId) {
            cloudinaryService.deleteImageOnCloudInTransaction(transactionId);
            transactionRepository.deleteTransactionByTransactionId(transaction.getId(), transaction.getStmTransaction(), transaction.getStatementType(), transaction.getWalletIdWallet().getWalletId());
        }

        tRes.setId(transaction.getId());
        tRes.setDescription("Delete Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
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