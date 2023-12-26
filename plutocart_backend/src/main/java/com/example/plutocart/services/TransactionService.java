package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.transaction.TResPostDTO;
import com.example.plutocart.dtos.transaction.TResStmNowDTO;
import com.example.plutocart.dtos.transaction.TransactionResponseGetDTO;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.entities.TransactionCategory;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.TransactionCategoryRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.repositories.WalletRepository;
import com.example.plutocart.utils.GenericResponse;
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

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountRepository.findById(accountId).orElseThrow().getAccountId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    @Transactional
    public GenericResponse getTransactionByAccountIdLimitThree(Integer accountId) {
        GenericResponse response = new GenericResponse();

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountIdLimitThree(accountRepository.findById(accountId).orElseThrow().getAccountId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public GenericResponse getTransactionByWalletId(Integer walletId) {
        GenericResponse response = new GenericResponse();

        List<Transaction> transactionList = transactionRepository.viewTransactionByWalletId(walletRepository.findById(walletId).orElseThrow().getWalletId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public GenericResponse getTransactionByWalletIdAndTransactionId(Integer walletId, Integer transactionId) {
        GenericResponse response = new GenericResponse();

//        List<Transaction> transactionList = transactionRepository.viewTransactionByWalletIdAndTransactionId(walletId,transactionId);
//        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        Transaction transaction = transactionRepository.viewTransactionByWalletIdAndTransactionId(walletRepository.findById(walletId).orElseThrow().getWalletId(), transactionRepository.findById(transactionId).orElseThrow().getId());
        TransactionResponseGetDTO transactionResponse = modelMapper.map(transaction, TransactionResponseGetDTO.class);

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public GenericResponse getTransactionByTransactionId(Integer transactionId) {
        GenericResponse response = new GenericResponse();

        Transaction transaction = transactionRepository.viewTransactionByTransactionId(transactionRepository.findById(transactionId).orElseThrow().getId());
        TransactionResponseGetDTO transactionResponse = modelMapper.map(transaction, TransactionResponseGetDTO.class);

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    @Transactional
    public GenericResponse getTodayIncome(Integer accountId, Integer walletId) {
        GenericResponse response = new GenericResponse();
        TResStmNowDTO tRes = new TResStmNowDTO();

        List<BigDecimal> todayIncome = transactionRepository.viewTodayIncome(accountRepository.findById(accountId).orElseThrow().getAccountId(), walletRepository.findById(walletId).orElseThrow().getWalletId());

        tRes.setIncome(todayIncome.get(0));
        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse getTodayExpense(Integer accountId, Integer walletId) {
        GenericResponse response = new GenericResponse();
        TResStmNowDTO tRes = new TResStmNowDTO();

        List<BigDecimal> todayIncome = transactionRepository.viewTodayExpense(accountRepository.findById(accountId).orElseThrow().getAccountId(), walletRepository.findById(walletId).orElseThrow().getWalletId());

        tRes.setExpense(todayIncome.get(0));
        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse createTransaction(Integer walletId, MultipartFile file, BigDecimal stmTransaction, Integer statementType, LocalDateTime dateTransaction, Integer transactionCategoryId, String description, Integer debtIdDebt, Integer goalIdGoal) throws IOException {
        GenericResponse response = new GenericResponse();
        TResPostDTO tRes = new TResPostDTO();
        String imageUrl = null;

        if (!file.isEmpty()) {
            imageUrl = cloudinaryService.uploadImageInTransaction(file);
        }

        TransactionCategory transactionCategory = transactionCategoryRepository.viewTransactionCategoryById(transactionCategoryRepository.findById(transactionCategoryId).orElseThrow().getId());

        transactionRepository.InsertIntoTransactionByWalletId(walletId, stmTransaction, statementType, dateTransaction,transactionCategory.getId(), description, imageUrl, debtIdDebt, goalIdGoal);
        Transaction currentTransaction = transactionRepository.viewTransactionByWalletId(walletId).get(transactionRepository.viewTransactionByWalletId(walletId).toArray().length - 1);

        if (statementType == 1) {
            tRes.setStatementType("income");
        } else {
            tRes.setStatementType("expense");
        }

        tRes.setTransactionId(currentTransaction.getId());
        tRes.setStmTransaction(stmTransaction);
//        tRes.setStatementType(statementType);
        tRes.setWId(walletId);
        tRes.setDescription("Create Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse updateTransaction(Integer walletId, Integer transactionId, MultipartFile file, BigDecimal stmTransaction, Integer statementType, LocalDateTime dateTransaction, Integer transactionCategoryId, String description, Integer debtIdDebt, Integer goalIdGoal) throws Exception {
        GenericResponse response = new GenericResponse();
        String imageUrl = null;

        TransactionCategory transactionCategory = transactionCategoryRepository.viewTransactionCategoryById(transactionCategoryRepository.findById(transactionCategoryId).orElseThrow().getId());
        Transaction transaction = transactionRepository.viewTransactionByTransactionId(transactionId);
        TResPostDTO transactionResponse = modelMapper.map(transaction, TResPostDTO.class);

        if (transaction.getWalletIdWallet().getWalletId() == walletId && transaction.getId() == transactionId) {
            if (transaction.getImageUrl() != null && !transaction.getImageUrl().isEmpty()) {
                cloudinaryService.deleteImageOnCloudInTransaction(transactionId);
            }

            if (!file.isEmpty()) {
                imageUrl = cloudinaryService.uploadImageInTransaction(file);
            }

            transactionRepository.updateTransaction(walletId, transactionId, stmTransaction, statementType, dateTransaction, transactionCategory.getId(), description, imageUrl, debtIdDebt, goalIdGoal);
        } else {
            throw new Exception();
        }

        transactionResponse.setTransactionId(transaction.getId());
        transactionResponse.setWId(transaction.getWalletIdWallet().getWalletId());
        transactionResponse.setDescription("Update Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    @Transactional
    public GenericResponse deleteTransaction(Integer walletId, Integer transactionId) throws Exception {
        GenericResponse response = new GenericResponse();

        Transaction transaction = transactionRepository.viewTransactionByTransactionId(transactionId);
        TResPostDTO transactionResponse = modelMapper.map(transaction, TResPostDTO.class);

        if (transaction.getWalletIdWallet().getWalletId() == walletId && transaction.getId() == transactionId) {
            cloudinaryService.deleteImageOnCloudInTransaction(transactionId);
            transactionRepository.deleteTransactionByTransactionId(transaction.getId(), transaction.getStmTransaction(), transaction.getStatementType(), transaction.getWalletIdWallet().getWalletId());
        } else {
            throw new Exception();
        }

        transactionResponse.setTransactionId(transaction.getId());
        transactionResponse.setWId(transaction.getWalletIdWallet().getWalletId());
        transactionResponse.setDescription("Delete Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
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