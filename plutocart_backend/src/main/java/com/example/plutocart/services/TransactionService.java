package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.transaction.*;
import com.example.plutocart.entities.Account;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.entities.TransactionCategory;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.TransactionCategoryRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.repositories.WalletRepository;
import com.example.plutocart.utils.GenericResponse;
import com.example.plutocart.utils.HelperMethod;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
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
    public GenericResponse getTransactionByAccountId(String accountId) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        Integer acId = validationAccountId(accountId);

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountRepository.findById(acId).orElseThrow().getAccountId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    @Transactional
    public GenericResponse getTransactionByAccountIdLimitThree(String accountId) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        Integer acId = validationAccountId(accountId);

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountIdLimitThree(accountRepository.findById(acId).orElseThrow().getAccountId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public Integer validationAccountId(String accountId) throws PlutoCartServiceApiException {
        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        int acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account Id " + accountId + " is not created. ");

        return acId;
    }

    @Transactional
    public GenericResponse getTransactionByAccountIdAndWalletId(String accountId, String walletId) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        TReqGetByAcIdWalId id = validationAccountIdAndWalletId(accountId, walletId);

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountIdAndWalletId(
                accountRepository.findById(id.getAccountId()).orElseThrow().getAccountId(),
                walletRepository.findById(id.getWalletId()).orElseThrow().getWalletId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction ->
                modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public TReqGetByAcIdWalId validationAccountIdAndWalletId(String accountId, String walletId) throws PlutoCartServiceApiException {
        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account Id " + accountId + " is not created. ");

        if (!HelperMethod.isInteger(walletId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "wallet id must be number. ");

        Integer walId = Integer.parseInt(walletId);
        Wallet wallet = walletRepository.viewWalletByWalletId(walId);
        if (wallet == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + walletId + " is not created. ");

        TReqGetByAcIdWalId id = new TReqGetByAcIdWalId();
        id.setAccountId(acId);
        id.setWalletId(walId);
        return id;
    }

    @Transactional
    public GenericResponse getTransactionByAccountIdAndWalletIdAndTransactionId(String accountId, String walletId, String transactionId) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        TReqGetByAcIdWalIdTranId id = validationAccountIdAndWalletIdAndTransactionId(accountId, walletId, transactionId);
//        List<Transaction> transactionList = transactionRepository.viewTransactionByWalletIdAndTransactionId(walletId,transactionId);
//        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountIdAndWalletIdAndTransactionId(
                accountRepository.findById(id.getAccountId()).orElseThrow().getAccountId(),
                walletRepository.findById(id.getWalletId()).orElseThrow().getWalletId(),
                transactionRepository.findById(id.getTransactionId()).orElseThrow().getId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction ->
                modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    public TReqGetByAcIdWalIdTranId validationAccountIdAndWalletIdAndTransactionId(String accountId, String walletId, String transactionId) throws PlutoCartServiceApiException {
        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account Id " + accountId + " is not created. ");

        if (!HelperMethod.isInteger(walletId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "wallet id must be number. ");

        Integer walId = Integer.parseInt(walletId);
        Wallet wallet = walletRepository.viewWalletByWalletId(walId);
        if (wallet == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + walletId + " is not created. ");

        if (!HelperMethod.isInteger(transactionId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction id must be number. ");

        Integer tranId = Integer.parseInt(transactionId);
        Transaction transaction = transactionRepository.viewTransactionByTransactionId(tranId);
        if (transaction == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction Id " + transactionId + " is not created. ");

        TReqGetByAcIdWalIdTranId id = new TReqGetByAcIdWalIdTranId();
        id.setAccountId(acId);
        id.setWalletId(walId);
        id.setTransactionId(tranId);
        return id;
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

        BigDecimal todayIncome = transactionRepository.viewTodayIncome(accountRepository.findById(accountId).orElseThrow().getAccountId(), walletRepository.findById(walletId).orElseThrow().getWalletId());

        tRes.setTodayIncome(todayIncome);
        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse getTodayExpense(Integer accountId, Integer walletId) {
        GenericResponse response = new GenericResponse();
        TResStmNowDTO tRes = new TResStmNowDTO();

        BigDecimal todayExpense = transactionRepository.viewTodayExpense(accountRepository.findById(accountId).orElseThrow().getAccountId(), walletRepository.findById(walletId).orElseThrow().getWalletId());

        tRes.setTodayExpense(todayExpense);
        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse getTodayIncomeAndExpense(String accountId) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        List<TResStmNowDTO> tResList = new ArrayList<>();
        Integer acId = validationAccountId(accountId);

        List<Wallet> walletList = walletRepository.viewWalletByAccountId(acId);
        if (walletList.isEmpty())
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "No wallet has been created for this account.");

        for (Wallet wallet : walletList) {
            TResStmNowDTO tRes = new TResStmNowDTO();

            BigDecimal todayIncome = transactionRepository.viewTodayIncome(acId, wallet.getWalletId());
            BigDecimal todayExpense = transactionRepository.viewTodayExpense(acId, wallet.getWalletId());
            tRes.setWalletId(wallet.getWalletId());
            tRes.setTodayIncome(todayIncome);
            tRes.setTodayExpense(todayExpense);

            tResList.add(tRes);
        }

        response.setStatus(ResultCode.SUCCESS);
        response.setData(tResList);
        return response;
    }

    @Transactional
    public GenericResponse createTransaction(Integer walletId, MultipartFile file, BigDecimal stmTransaction, Integer statementType, LocalDateTime dateTransaction, Integer transactionCategoryId, String description, Integer debtIdDebt, Integer goalIdGoal) throws IOException {
        GenericResponse response = new GenericResponse();
        TResPostDTO tRes = new TResPostDTO();
        String imageUrl = null;

        if (file != null && !file.isEmpty()) {
            imageUrl = cloudinaryService.uploadImageInTransaction(file);
        }

        TransactionCategory transactionCategory = transactionCategoryRepository.viewTransactionCategoryById(transactionCategoryRepository.findById(transactionCategoryId).orElseThrow().getId());

        transactionRepository.InsertIntoTransactionByWalletId(walletId, stmTransaction, statementType, dateTransaction, transactionCategory.getId(), description, imageUrl, debtIdDebt, goalIdGoal);
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

            if (file != null && !file.isEmpty()) {
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