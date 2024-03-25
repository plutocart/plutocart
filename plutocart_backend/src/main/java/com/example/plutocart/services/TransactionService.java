package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.transaction.*;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiForbidden;
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
    @Autowired
    TransactionValidationService transactionValidationService;
    @Autowired
    GlobalValidationService globalValidationService;


    @Transactional
    public GenericResponse getTransactionByAccountId(String accountId, String walletId, String month, String year, String token) throws PlutoCartServiceApiException {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
//        Integer acId = globalValidationService.validationAccountId(accountId);
        TReqGetByFilterDTO tReqGetByFilterDTO = transactionValidationService.validationFilterTransaction(accountId, walletId, month, year);

//        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountRepository.findById(acId).orElseThrow().getAccountId());
        List<Transaction> transactionList = transactionRepository.viewTransactionByFilter(tReqGetByFilterDTO.getAccountId(), tReqGetByFilterDTO.getWalletId(), tReqGetByFilterDTO.getMonth(), tReqGetByFilterDTO.getYear());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    @Transactional
    public GenericResponse getTransactionByAccountIdLimitThree(String accountId, String token) throws PlutoCartServiceApiException {

        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        Integer acId = globalValidationService.validationAccountId(accountId);

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountIdLimitThree(accountRepository.findById(acId).orElseThrow().getAccountId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    @Transactional
    public GenericResponse getTransactionByAccountIdAndWalletId(String accountId, String walletId, String token) throws PlutoCartServiceApiException {

        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        TReqGetByAcIdWalId id = globalValidationService.validationAccountIdAndWalletId(accountId, walletId);

        List<Transaction> transactionList = transactionRepository.viewTransactionByAccountIdAndWalletId(
                accountRepository.findById(id.getAccountId()).orElseThrow().getAccountId(),
                walletRepository.findById(id.getWalletId()).orElseThrow().getWalletId());
        List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction ->
                modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

    @Transactional
    public GenericResponse getTransactionByAccountIdAndWalletIdAndTransactionId(String accountId, String walletId, String transactionId, String token) throws PlutoCartServiceApiException {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        TReqGetByAcIdWalIdTranId id = globalValidationService.validationAccountIdAndWalletIdAndTransactionId(accountId, walletId, transactionId);
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
    public GenericResponse getTodayIncomeAndExpense(String accountId, String token) throws PlutoCartServiceApiException {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        List<TResStmNowDTO> tResList = new ArrayList<>();
        Integer acId = globalValidationService.validationAccountId(accountId);

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
    public GenericResponse createTransaction(String accountId, String walletId, MultipartFile file, String
            stmTransaction, String statementType, LocalDateTime dateTransaction, String transactionCategoryId, String
                                                     description, String goalIdGoal, String debtIdDebt, String token) throws IOException, PlutoCartServiceApiException {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId)) {
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");
        }

        GenericResponse response = new GenericResponse();
        TResPostDTO tRes = new TResPostDTO();

        TReqPostTran tReqPostTran = transactionValidationService.validationCreateTransaction(accountId, walletId, file, stmTransaction, statementType, transactionCategoryId, description, goalIdGoal, debtIdDebt);

        transactionRepository.InsertIntoTransactionByWalletId(tReqPostTran.getAccountId(), tReqPostTran.getWalletId(), tReqPostTran.getStmTransaction(), tReqPostTran.getStmType(), dateTransaction,
                tReqPostTran.getTransactionCategoryId(), description, tReqPostTran.getImageUrl(), tReqPostTran.getDebtId(), tReqPostTran.getGoalId());
        Transaction currentTransaction = transactionRepository.viewTransactionByWalletId(tReqPostTran.getWalletId()).get(transactionRepository.viewTransactionByWalletId(tReqPostTran.getWalletId()).toArray().length - 1);

        tRes.setWalletId(tReqPostTran.getWalletId());
        tRes.setTransactionId(currentTransaction.getId());
        tRes.setTransactionCategoryId(tReqPostTran.getTransactionCategoryId());
        tRes.setGoalId(tReqPostTran.getGoalId());
        tRes.setDebtId(tReqPostTran.getDebtId());
        tRes.setStatementType(currentTransaction.getStatementType());
        tRes.setStmTransaction(currentTransaction.getStmTransaction());
        tRes.setDescription("Create Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse updateTransaction(String accountId, String walletId, String transactionId, MultipartFile
            file, String stmTransaction, String statementType, LocalDateTime dateTransaction, String
                                                     transactionCategoryId, String description, String goalIdGoal, String debtIdDebt, String token) throws Exception {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        TResPostDTO tRes = new TResPostDTO();
        TReqPostTran tReqPostTran = transactionValidationService.validationUpdateTransaction(accountId, walletId, transactionId, file, stmTransaction, statementType, transactionCategoryId, description, goalIdGoal, debtIdDebt);

        transactionRepository.updateTransaction(tReqPostTran.getAccountId(), tReqPostTran.getWalletId(), tReqPostTran.getTransactionId(), tReqPostTran.getStmTransaction(), tReqPostTran.getStmType(), dateTransaction, tReqPostTran.getTransactionCategoryId(), description, tReqPostTran.getImageUrl(), tReqPostTran.getDebtId(), tReqPostTran.getGoalId());

        tRes.setWalletId(tReqPostTran.getWalletId());
        tRes.setTransactionId(tReqPostTran.getTransactionId());
        tRes.setTransactionCategoryId(tReqPostTran.getTransactionCategoryId());
        tRes.setGoalId(tReqPostTran.getGoalId());
        tRes.setDebtId(tReqPostTran.getDebtId());
        tRes.setStatementType(tReqPostTran.getStmTypeString());
        tRes.setStmTransaction(tReqPostTran.getStmTransaction());
        tRes.setDescription("Update Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(tRes);
        return response;
    }

    @Transactional
    public GenericResponse deleteTransaction(String accountId, String walletId, String transactionId, String token) throws Exception {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        TResDelDTO transactionResponse = new TResDelDTO();

        TReqDelTran tReqDelTran = transactionValidationService.validationDeleteTransaction(accountId, walletId, transactionId);

        transactionRepository.deleteTransactionByTransactionId(tReqDelTran.getAccountId(), tReqDelTran.getTransactionId(), tReqDelTran.getStmTransaction(),
                tReqDelTran.getStmType(), tReqDelTran.getWalletId(), tReqDelTran.getGoalId(), tReqDelTran.getDebtId(), tReqDelTran.getTransactionDate());

        transactionResponse.setTransactionId(tReqDelTran.getTransactionId());
        transactionResponse.setWalId(tReqDelTran.getWalletId());
        transactionResponse.setDescription("Delete Success");

        response.setStatus(ResultCode.SUCCESS);
        response.setData(transactionResponse);
        return response;
    }

}