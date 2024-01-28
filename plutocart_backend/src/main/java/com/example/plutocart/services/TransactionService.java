package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.example.plutocart.auth.JwtUtil;
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
import org.springframework.util.StringUtils;
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
    public GenericResponse getTransactionByAccountId(String accountId , String token) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);
        Integer acId = validationAccountId(accountId);
        if(userId.equals(accountId)){
            List<Transaction> transactionList = transactionRepository.viewTransactionByAccountId(accountRepository.findById(acId).orElseThrow().getAccountId());
            List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

            response.setStatus(ResultCode.SUCCESS);
            response.setData(transactionResponse);
            return response;
        }
        else{
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }

    }

    @Transactional
    public GenericResponse getTransactionByAccountIdLimitThree(String accountId , String token) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        Integer acId = validationAccountId(accountId);
        String userId = JwtUtil.extractUsername(token);
        if(userId.equals(accountId)){
            List<Transaction> transactionList = transactionRepository.viewTransactionByAccountIdLimitThree(accountRepository.findById(acId).orElseThrow().getAccountId());
            List<TransactionResponseGetDTO> transactionResponse = transactionList.stream().map(transaction -> modelMapper.map(transaction, TransactionResponseGetDTO.class)).collect(Collectors.toList());

            response.setStatus(ResultCode.SUCCESS);
            response.setData(transactionResponse);
            return response;
        }
        else {
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }

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
    public GenericResponse getTransactionByAccountIdAndWalletId(String accountId, String walletId , String token) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);

        if(userId.equals(accountId)){
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
        else {
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }

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
    public GenericResponse getTransactionByAccountIdAndWalletIdAndTransactionId(String accountId, String walletId, String transactionId , String token) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);
        if(userId.equals(accountId)){
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
        else {
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }
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

    public GenericResponse getTransactionByTransactionId(String accountId , Integer transactionId , String token) {
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);
        if(accountId.equals(userId)){
            Transaction transaction = transactionRepository.viewTransactionByTransactionId(transactionRepository.findById(transactionId).orElseThrow().getId());
            TransactionResponseGetDTO transactionResponse = modelMapper.map(transaction, TransactionResponseGetDTO.class);

            response.setStatus(ResultCode.SUCCESS);
            response.setData(transactionResponse);
            return response;
        }
        else {
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }
    }

    @Transactional
    public GenericResponse getTodayIncome(Integer accountId, Integer walletId , String token) {
        GenericResponse response = new GenericResponse();
        TResStmNowDTO tRes = new TResStmNowDTO();
        String userId = JwtUtil.extractUsername(token);
        if(Integer.parseInt(userId) == accountId){
            BigDecimal todayIncome = transactionRepository.viewTodayIncome(accountRepository.findById(accountId).orElseThrow().getAccountId(), walletRepository.findById(walletId).orElseThrow().getWalletId());

            tRes.setTodayIncome(todayIncome);
            response.setStatus(ResultCode.SUCCESS);
            response.setData(tRes);
            return response;
        }
        else {
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }


    }

    @Transactional
    public GenericResponse getTodayExpense(Integer accountId, Integer walletId , String token) {
        GenericResponse response = new GenericResponse();
        TResStmNowDTO tRes = new TResStmNowDTO();
        String userId = JwtUtil.extractUsername(token);
        if(Integer.parseInt(userId) == accountId){
            BigDecimal todayExpense = transactionRepository.viewTodayExpense(accountRepository.findById(accountId).orElseThrow().getAccountId(), walletRepository.findById(walletId).orElseThrow().getWalletId());

            tRes.setTodayExpense(todayExpense);
            response.setStatus(ResultCode.SUCCESS);
            response.setData(tRes);
            return response;
        }
        else {
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }

    }

    @Transactional
    public GenericResponse getTodayIncomeAndExpense(String accountId , String token) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        List<TResStmNowDTO> tResList = new ArrayList<>();
        String userId = JwtUtil.extractUsername(token);
        if(accountId.equals(userId)){
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
        else {
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }

    }

    @Transactional
    public GenericResponse createTransaction(String accountId , String walletId, MultipartFile file, String stmTransaction, String statementType, LocalDateTime dateTransaction, String transactionCategoryId, String description, Integer debtIdDebt, Integer goalIdGoal , String token) throws IOException, PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        TResPostDTO tRes = new TResPostDTO();
//        String imageUrl = null;
//
//        if (file != null && !file.isEmpty()) {
//            imageUrl = cloudinaryService.uploadImageInTransaction(file);
//        }

//        TransactionCategory transactionCategory = transactionCategoryRepository.viewTransactionCategoryById(transactionCategoryRepository.findById(transactionCategoryId).orElseThrow().getId());

        String userId = JwtUtil.extractUsername(token);
        if(userId != null && userId.equals(accountId)){
            TReqPostTran tReqPostTran = validationCreateAndUpdateTransaction(walletId, file, stmTransaction, statementType, transactionCategoryId);

            transactionRepository.InsertIntoTransactionByWalletId(tReqPostTran.getWalletId(), tReqPostTran.getStmTransaction(), tReqPostTran.getStmType(), dateTransaction,
                    tReqPostTran.getTransactionCategoryId(), description, tReqPostTran.getImageUrl(), debtIdDebt, goalIdGoal);
            Transaction currentTransaction = transactionRepository.viewTransactionByWalletId(tReqPostTran.getWalletId()).get(transactionRepository.viewTransactionByWalletId(tReqPostTran.getWalletId()).toArray().length - 1);

//        if (statementType == 1) {
//            tRes.setStatementType("income");
//        } else if (statementType == 2) {
//            tRes.setStatementType("expense");
//        }

            tRes.setWalletId(tReqPostTran.getWalletId());
            tRes.setTransactionId(currentTransaction.getId());
            tRes.setTransactionCategoryId(tReqPostTran.getTransactionCategoryId());
            tRes.setStatementType(currentTransaction.getStatementType());
            tRes.setStmTransaction(currentTransaction.getStmTransaction());
            tRes.setDescription("Create Success");

            response.setStatus(ResultCode.SUCCESS);
            response.setData(tRes);
            return response;
        }
        else{
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }


    }

    @Transactional
    public GenericResponse updateTransaction(String accountId , String walletId, String transactionId, MultipartFile file, String stmTransaction, String statementType, LocalDateTime dateTransaction, String transactionCategoryId, String description, Integer debtIdDebt, Integer goalIdGoal , String token) throws Exception {
        GenericResponse response = new GenericResponse();
        TResPostDTO tRes = new TResPostDTO();
        String imageUrl = null;
        String userId = JwtUtil.extractUsername(token);
        if(accountId.equals(userId)){
            TReqPostTran tReqPostTran = validationCreateAndUpdateTransaction(walletId, file, stmTransaction, statementType, transactionCategoryId);

            if (!HelperMethod.isInteger(transactionId))
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction id must be number. ");

            Integer tranId = Integer.parseInt(transactionId);
            Transaction transaction = transactionRepository.viewTransactionByTransactionId(tranId);
            if (transaction == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction Id " + transactionId + " is not created. ");

            if (transaction.getWalletIdWallet().getWalletId() == tReqPostTran.getWalletId() && transaction.getId() == tranId) {
                if (transaction.getImageUrl() != null && !transaction.getImageUrl().isEmpty()) {
                    cloudinaryService.deleteImageOnCloudInTransaction(tranId);
                }

                if (file != null && !file.isEmpty()) {
                    imageUrl = cloudinaryService.uploadImageInTransaction(file);
                }

                transactionRepository.updateTransaction(tReqPostTran.getWalletId(), tranId, tReqPostTran.getStmTransaction(), tReqPostTran.getStmType(), dateTransaction, tReqPostTran.getTransactionCategoryId(), description, imageUrl, debtIdDebt, goalIdGoal);
            } else {
                throw new Exception();
            }

//        Transaction transactionUpdate = transactionRepository.viewTransactionByTransactionId(transactionId);
//        TResPostDTO transactionResponse = modelMapper.map(transactionUpdate, TResPostDTO.class);

            tRes.setWalletId(tReqPostTran.getWalletId());
            tRes.setTransactionId(tranId);
            tRes.setTransactionCategoryId(tReqPostTran.getTransactionCategoryId());
            tRes.setStatementType(tReqPostTran.getStmTypeString());
            tRes.setStmTransaction(tReqPostTran.getStmTransaction());
            tRes.setDescription("Update Success");

            response.setStatus(ResultCode.SUCCESS);
            response.setData(tRes);
            return response;
        }
        else{
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }

    }

    public TReqPostTran validationCreateAndUpdateTransaction(String walletId, MultipartFile file, String stmTransaction, String stmType, String transactionCategoryId) throws PlutoCartServiceApiException, IOException {
        String imageUrl = null;

        if (!HelperMethod.isInteger(walletId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "wallet id must be number. ");

        Integer walId = Integer.parseInt(walletId);
        Wallet wallet = walletRepository.viewWalletByWalletId(walId);
        if (wallet == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + walletId + " is not created. ");

        if (StringUtils.isEmpty(stmTransaction.trim()) || !HelperMethod.isDecimal(stmTransaction))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm transaction must be decimal. ");

        BigDecimal stmTran = new BigDecimal(stmTransaction);

        if (StringUtils.isEmpty(stmType.trim()) || !HelperMethod.isInteger(stmType))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type must be 1 & 2. ");

        Integer sType = Integer.parseInt(stmType);
        if (sType != 1 && sType != 2)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type must be 1 & 2. ");

        String sTypeString = null;
        if (sType == 1) {
            sTypeString = "income";
        } else if (sType == 2) {
            sTypeString = "expense";
        }

        if (StringUtils.isEmpty(transactionCategoryId.trim()) || !HelperMethod.isInteger(transactionCategoryId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id must be number. ");

        Integer tranCatId = Integer.parseInt(transactionCategoryId);
        TransactionCategory transactionCategory = transactionCategoryRepository.viewTransactionCategoryById(tranCatId);
        if (transactionCategory == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction category Id " + tranCatId + " is not created. ");

        if (!transactionCategory.getTypeCategory().equals(sTypeString))
            throw new PlutoCartServiceApiException(ResultCode.INVALID_PARAM, "category type is not match in transaction category. ");

        if (file != null && !file.isEmpty()) {
            imageUrl = cloudinaryService.uploadImageInTransaction(file);
        }

        TReqPostTran tReqPostTran = new TReqPostTran();
        tReqPostTran.setWalletId(walId);
        tReqPostTran.setImageUrl(imageUrl);
        tReqPostTran.setStmTransaction(stmTran);
        tReqPostTran.setStmType(sType);
        tReqPostTran.setStmTypeString(sTypeString);
        tReqPostTran.setTransactionCategoryId(tranCatId);
        return tReqPostTran;
    }

    @Transactional
    public GenericResponse deleteTransaction(String accountId , Integer walletId, Integer transactionId , String token) throws Exception {
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);
        if(userId.equals(accountId)){
            Transaction transaction = transactionRepository.viewTransactionByTransactionId(transactionId);
            TResDelDTO transactionResponse = new TResDelDTO();
//        TResDelDTO transactionResponse = modelMapper.map(transaction, TResDelDTO.class);

            if (transaction.getWalletIdWallet().getWalletId() == walletId && transaction.getId() == transactionId) {
                cloudinaryService.deleteImageOnCloudInTransaction(transactionId);
                transactionRepository.deleteTransactionByTransactionId(transaction.getId(), transaction.getStmTransaction(), transaction.getStatementType(), transaction.getWalletIdWallet().getWalletId());
            } else {
                throw new Exception();
            }

            transactionResponse.setTransactionId(transaction.getId());
            transactionResponse.setWalletId(transaction.getWalletIdWallet().getWalletId());
            transactionResponse.setDescription("Delete Success");

            response.setStatus(ResultCode.SUCCESS);
            response.setData(transactionResponse);
            return response;
        }
        else{
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }

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