package com.example.plutocart.services;

import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.transaction.TReqDelTran;
import com.example.plutocart.dtos.transaction.TReqPostTran;
import com.example.plutocart.entities.*;
import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.repositories.*;
import com.example.plutocart.utils.HelperMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@Service
public class TransactionValidationService {

    @Autowired
    CloudinaryService cloudinaryService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    WalletRepository walletRepository;
    @Autowired
    TransactionRepository transactionRepository;
    @Autowired
    TransactionCategoryRepository transactionCategoryRepository;
    @Autowired
    GoalRepository goalRepository;
    @Autowired
    DebtRepository debtRepository;

    public TReqPostTran validationCreateTransaction(String accountId, String walletId, MultipartFile file, String stmTransaction, String stmType, String transactionCategoryId, String goalId, String debtId) throws PlutoCartServiceApiException, IOException {
        String imageUrl = null;
        String stmTranTrim = stmTransaction.trim();
        String stmTyTrim = stmType.trim();
        String tranCatTrim = transactionCategoryId.trim();
        //for check not empty & null
//        String goIdTrim = null;
//        String deIdTrim = null;
        //for change type to be integer
        Integer goId = null;
        Integer deId = null;

        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + acId + " is not create. ");

        if (!HelperMethod.isInteger(walletId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "wallet id must be number. ");

        Integer walId = Integer.parseInt(walletId);
        Wallet wallet = walletRepository.viewWalletByWalletId(walId);
        if (wallet == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + walletId + " is not create. ");

        if (account.getAccountId() != wallet.getAccountIdAccount().getAccountId())
            throw new PlutoCartServiceApiException(ResultCode.BAD_REQUEST, "this account don't have this wallet. ");

        if (StringUtils.isEmpty(stmTyTrim) || !HelperMethod.isInteger(stmTyTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type must be 1 or 2. ");

        Integer sType = Integer.parseInt(stmTyTrim);
        if (sType < 1 && sType > 2)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type must be 1 or 2. ");

        String sTypeString = "";
        if (sType == 1) {
            sTypeString = "income";
        } else if (sType == 2) {
            sTypeString = "expense";
        }

        if (StringUtils.isEmpty(tranCatTrim) || !HelperMethod.isInteger(tranCatTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id must be number. ");

        Integer tranCatId = Integer.parseInt(tranCatTrim);
        TransactionCategory transactionCategory = transactionCategoryRepository.viewTransactionCategoryById(tranCatId);
        if (transactionCategory == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction category Id " + tranCatId + " is not create. ");

        if (tranCatId > 33 || tranCatId < 1)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id " + tranCatId + " is not create.");

        if (!transactionCategory.getTypeCategory().equals(sTypeString))
            throw new PlutoCartServiceApiException(ResultCode.INVALID_PARAM, "statement type of this transaction is not match in transaction category type. ");

        if (StringUtils.isEmpty(stmTranTrim) || !HelperMethod.isDecimal(stmTranTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm transaction must be number. ");

        BigDecimal stmTran = new BigDecimal(stmTranTrim);

        if (!StringUtils.isEmpty(goalId) && !StringUtils.isEmpty(debtId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "create transaction can not send goal id & debt id both.");

        if ((!StringUtils.isEmpty(goalId) || !StringUtils.isEmpty(debtId)) && sTypeString.equals("income"))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type not match for create transaction. ");

        if (StringUtils.isEmpty(goalId) && StringUtils.isEmpty(debtId) && (tranCatId == 32 || tranCatId == 33))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id not match for create transaction. ");

        if (goalId != null && !HelperMethod.isInteger(goalId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "goal id must be number or null.");

        if (goalId != null) {
            if (tranCatId != 32)
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "statement of transaction in goal is not match. ");

            goId = Integer.parseInt(goalId);
            Goal goal = goalRepository.viewGoalByGoalId(goId);

            if (goal == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "goal id " + goId + " is not create. ");
        }

        if (debtId != null && !HelperMethod.isInteger(debtId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "debt id must be number or null.");

        if (debtId != null) {
            if (tranCatId != 33)
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "statement of transaction in debt is not match. ");

            deId = Integer.parseInt(debtId);
            Debt debt = debtRepository.viewDebtByDebtId(deId);

            if (debt == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "debt id " + deId + " is not create. ");
        }

//        if (transactionCategory.getId() != tranCatId)
//            throw new PlutoCartServiceApiException(ResultCode.INVALID_PARAM, "transaction id not match in transaction category.");

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
        tReqPostTran.setGoalId(goId);
        tReqPostTran.setDebtId(deId);
        return tReqPostTran;
    }

    public TReqPostTran validationUpdateTransaction(String accountId, String walletId, String transactionId, MultipartFile file, String stmTransaction, String stmType, String transactionCategoryId, String goalId, String debtId) throws Exception {
        String imageUrl = null;
        String stmTranTrim = stmTransaction.trim();
        String stmTyTrim = stmType.trim();
        String tranCatTrim = transactionCategoryId.trim();
        Integer goId = null;
        Integer deId = null;

        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + acId + " is not create. ");

        if (!HelperMethod.isInteger(walletId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "wallet id must be number. ");

        Integer walId = Integer.parseInt(walletId);
        Wallet wallet = walletRepository.viewWalletByWalletId(walId);
        if (wallet == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + walletId + " is not create. ");

        if (account.getAccountId() != wallet.getAccountIdAccount().getAccountId())
            throw new PlutoCartServiceApiException(ResultCode.BAD_REQUEST, "this account don't have this wallet. ");

        if (!HelperMethod.isInteger(transactionId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction id must be number. ");

        Integer tranId = Integer.parseInt(transactionId);
        Transaction transaction = transactionRepository.viewTransactionByTransactionId(tranId);

        if (transaction == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction Id " + tranId + " is not create. ");

        if (transaction.getWalletIdWallet().getWalletId() != wallet.getWalletId())
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "this wallet don't have this transaction. ");

//        if (transaction.getId() != tranId)
//            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction id must be number. ");


        if (StringUtils.isEmpty(stmTyTrim) || !HelperMethod.isInteger(stmTyTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type must be 1 or 2. ");

        Integer sType = Integer.parseInt(stmTyTrim);
        if (sType < 1 && sType > 2)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type must be 1 or 2. ");

        String sTypeString = "";
        if (sType == 1) {
            sTypeString = "income";
        } else if (sType == 2) {
            sTypeString = "expense";
        }

        if (StringUtils.isEmpty(tranCatTrim) || !HelperMethod.isInteger(tranCatTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id must be number. ");

        Integer tranCatId = Integer.parseInt(tranCatTrim);
        TransactionCategory transactionCategory = transactionCategoryRepository.viewTransactionCategoryById(tranCatId);
        if (transactionCategory == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction category Id " + tranCatId + " is not create. ");

        if (tranCatId > 33 || tranCatId < 1)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id " + tranCatId + " is not create.");

        if (!transactionCategory.getTypeCategory().equals(sTypeString))
            throw new PlutoCartServiceApiException(ResultCode.INVALID_PARAM, "statement type of this transaction is not match in transaction category type. ");

        if (StringUtils.isEmpty(stmTranTrim) || !HelperMethod.isDecimal(stmTranTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm transaction must be number. ");

        BigDecimal stmTran = new BigDecimal(stmTranTrim);

        if (goalId != null && transaction.getGoalIdGoal() == null || goalId == null && transaction.getGoalIdGoal() != null
                || debtId != null && transaction.getDebtIdDebt() == null || debtId == null && transaction.getDebtIdDebt() != null)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction form for update is invalid. ");

        if (!StringUtils.isEmpty(goalId) && !StringUtils.isEmpty(debtId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "create transaction can not send goal id & debt id both.");

        if ((!StringUtils.isEmpty(goalId) || !StringUtils.isEmpty(debtId)) && sTypeString.equals("income"))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type not match for create transaction. ");

        if (StringUtils.isEmpty(goalId) && StringUtils.isEmpty(debtId) && (tranCatId == 32 || tranCatId == 33))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id not match for create transaction. ");

        if (goalId != null && !HelperMethod.isInteger(goalId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "goal id must be number or null.");

        if (goalId != null && transaction.getGoalIdGoal().getId() != null) {
            if (tranCatId != 32)
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "statement of transaction in goal is not match. ");

            goId = Integer.parseInt(goalId);

            if (goId != transaction.getGoalIdGoal().getId())
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "goal id is not match .");

            Goal goal = goalRepository.viewGoalByGoalId(goId);

            if (goal == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "goal id " + goId + " is not create. ");
        }

        if (debtId != null && !HelperMethod.isInteger(debtId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "debt id must be number or null.");

        if (debtId != null && transaction.getDebtIdDebt().getId() != null) {
            if (tranCatId != 33)
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "statement of transaction in debt is not match. ");

            deId = Integer.parseInt(debtId);

            if (deId != transaction.getDebtIdDebt().getId())
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "debt id is not match .");

            Debt debt = debtRepository.viewDebtByDebtId(deId);

            if (debt == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "debt id " + deId + " is not create. ");
        }

//        if (transactionCategory.getId() != tranCatId)
//            throw new PlutoCartServiceApiException(ResultCode.INVALID_PARAM, "transaction id not match in transaction category.");

        if (transaction.getImageUrl() != null && !transaction.getImageUrl().isEmpty()) {
            cloudinaryService.deleteImageOnCloudInTransaction(tranId);
        }

        if (file != null && !file.isEmpty()) {
            imageUrl = cloudinaryService.uploadImageInTransaction(file);
        }

        TReqPostTran tReqPostTran = new TReqPostTran();
        tReqPostTran.setWalletId(walId);
        tReqPostTran.setTransactionId(tranId);
        tReqPostTran.setImageUrl(imageUrl);
        tReqPostTran.setStmTransaction(stmTran);
        tReqPostTran.setStmType(sType);
        tReqPostTran.setStmTypeString(sTypeString);
        tReqPostTran.setTransactionCategoryId(tranCatId);
        tReqPostTran.setGoalId(goId);
        tReqPostTran.setDebtId(deId);
        return tReqPostTran;
    }

    public TReqDelTran validationDeleteTransaction(String accountId, String walletId, String transactionId) throws Exception {
        Integer goId = null;
        Integer deId = null;

        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + acId + " is not create. ");

        if (!HelperMethod.isInteger(walletId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "wallet id must be number. ");

        Integer walId = Integer.parseInt(walletId);
        Wallet wallet = walletRepository.viewWalletByWalletId(walId);
        if (wallet == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + walletId + " is not create. ");

        if (account.getAccountId() != wallet.getAccountIdAccount().getAccountId())
            throw new PlutoCartServiceApiException(ResultCode.BAD_REQUEST, "this account don't have this wallet. ");

        if (!HelperMethod.isInteger(transactionId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction id must be number. ");

        Integer tranId = Integer.parseInt(transactionId);
        Transaction transaction = transactionRepository.viewTransactionByTransactionId(tranId);

        if (transaction == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction Id " + tranId + " is not create. ");

        if (transaction.getWalletIdWallet().getWalletId() != wallet.getWalletId())
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "this wallet don't have this transaction. ");

        if (transaction.getGoalIdGoal() != null) {
            goId = transaction.getGoalIdGoal().getId();
            Goal goal = goalRepository.viewGoalByGoalId(goId);

            if (goal == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "goal id " + goId + " is not create. ");
        }

        if (transaction.getDebtIdDebt() != null) {
            deId = transaction.getDebtIdDebt().getId();
            Debt debt = debtRepository.viewDebtByDebtId(deId);

            if (debt == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "debt id " + deId + " is not create. ");

//            List<Transaction> transactionList = transactionRepository.viewTransactionByDebtId(deId);
//            if (transactionList.size() > 1) {
//                for (Transaction transactionInList : transactionList) {
//                    transactionId = String.valueOf(transactionInList.getId());
//                    walletId = String.valueOf(transactionInList.getWalletIdWallet().getWalletId());
//                    transactionService.deleteTransaction(accountId, walletId, transactionId, token);
//                }
//            }

        }

        cloudinaryService.deleteImageOnCloudInTransaction(tranId);

        TReqDelTran tReqDelTran = new TReqDelTran();
        tReqDelTran.setWalletId(walId);
        tReqDelTran.setTransactionId(tranId);
        tReqDelTran.setStmTransaction(transaction.getStmTransaction());
        tReqDelTran.setStmType(transaction.getStatementType());
        tReqDelTran.setGoalId(goId);
        tReqDelTran.setDebtId(deId);
        return tReqDelTran;
    }

}