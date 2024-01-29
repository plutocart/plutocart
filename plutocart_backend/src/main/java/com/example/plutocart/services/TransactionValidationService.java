package com.example.plutocart.services;

import com.example.plutocart.constants.ResultCode;
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
        String acIdTrim = accountId.trim();
        String walIdTrim = walletId.trim();
        String stmTranTrim = stmTransaction.trim();
        String stmTyTrim = stmType.trim();
        String tranCatTrim = transactionCategoryId.trim();
        //for check not empty & null
        String goIdTrim = null;
        String deIdTrim = null;
        //for change type to be integer
        Integer goId = null;
        Integer deId = null;

        if (!StringUtils.isEmpty(goalId))
            goIdTrim = goalId.trim();
        if (!StringUtils.isEmpty(debtId))
            deIdTrim = debtId.trim();

        if (!HelperMethod.isInteger(acIdTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(acIdTrim);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + acId + " is not created. ");

        if (!HelperMethod.isInteger(walIdTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "wallet id must be number. ");

        Integer walId = Integer.parseInt(walIdTrim);
        Wallet wallet = walletRepository.viewWalletByWalletId(walId);
        if (wallet == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + walletId + " is not created. ");

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
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction category Id " + tranCatId + " is not created. ");

        if (!transactionCategory.getTypeCategory().equals(sTypeString))
            throw new PlutoCartServiceApiException(ResultCode.INVALID_PARAM, "category type is not match in transaction category. ");

        if (StringUtils.isEmpty(stmTranTrim) || !HelperMethod.isDecimal(stmTranTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm transaction must be decimal. ");

        BigDecimal stmTran = new BigDecimal(stmTranTrim);

        if (!StringUtils.isEmpty(goIdTrim) && !StringUtils.isEmpty(deIdTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "invalid form params can't sent goal & debt id");

        if ((!StringUtils.isEmpty(goIdTrim) || !StringUtils.isEmpty(deIdTrim)) && sTypeString.equals("income"))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type not match for create transaction. ");

        if (!StringUtils.isEmpty(goIdTrim)) {
            goId = Integer.parseInt(goIdTrim);
            Goal goal = goalRepository.viewGoalByGoalId(goId);

            if (goal == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "goal id " + goIdTrim + " is not created. ");
        }

        if (!StringUtils.isEmpty(deIdTrim)) {
            deId = Integer.parseInt(deIdTrim);
//            Debt debt = debtRepository.viewDebtByDebtId(deId);

//            if (debt == null)
//                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "debt id " + deIdTrim + " is not created. ");
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
        String acIdTrim = accountId.trim();
        String walIdTrim = walletId.trim();
        String tranIdTrim = transactionId.trim();
        String stmTranTrim = stmTransaction.trim();
        String stmTyTrim = stmType.trim();
        String tranCatTrim = transactionCategoryId.trim();
        //for check not empty & null
        String goIdTrim = null;
        String deIdTrim = null;
        //for change type to be integer
        Integer goId = null;
        Integer deId = null;

        if (!StringUtils.isEmpty(goalId))
            goIdTrim = goalId.trim();
        if (!StringUtils.isEmpty(debtId))
            deIdTrim = debtId.trim();

        if (!HelperMethod.isInteger(acIdTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(acIdTrim);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + acId + " is not created. ");

        if (!HelperMethod.isInteger(walIdTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "wallet id must be number. ");

        Integer walId = Integer.parseInt(walIdTrim);
        Wallet wallet = walletRepository.viewWalletByWalletId(walId);
        if (wallet == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "wallet Id " + walId + " is not created. ");

        if (account.getAccountId() != wallet.getAccountIdAccount().getAccountId())
            throw new PlutoCartServiceApiException(ResultCode.BAD_REQUEST, "this account don't have this wallet. ");

        if (!HelperMethod.isInteger(tranIdTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction id must be number. ");

        Integer tranId = Integer.parseInt(tranIdTrim);
        Transaction transaction = transactionRepository.viewTransactionByTransactionId(tranId);

        if (transaction == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction Id " + tranId + " is not created. ");

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
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "transaction category Id " + tranCatId + " is not created. ");

        if (!transactionCategory.getTypeCategory().equals(sTypeString))
            throw new PlutoCartServiceApiException(ResultCode.INVALID_PARAM, "category type is not match in transaction category. ");

        if (StringUtils.isEmpty(stmTranTrim) || !HelperMethod.isDecimal(stmTranTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm transaction must be decimal. ");

        BigDecimal stmTran = new BigDecimal(stmTranTrim);


        // case ที่
        if (StringUtils.isEmpty(goIdTrim) && StringUtils.isEmpty(deIdTrim) && (tranCatId == 32 || tranCatId == 33))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "invalid form params can't sent goal & debt id");

        if (!StringUtils.isEmpty(goIdTrim) && !StringUtils.isEmpty(deIdTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "invalid form params can't sent goal & debt id");

        if ((!StringUtils.isEmpty(goIdTrim) || !StringUtils.isEmpty(deIdTrim)) && sTypeString.equals("income"))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "stm type not match for create transaction. ");

        if ((transaction.getGoalIdGoal() != null && deIdTrim != null) || (transaction.getDebtIdDebt() != null && goIdTrim != null))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "invalid form create transaction.");

        // กูงง ใน db มี goal id แต่ในนี้ไม่มี แต่เหมือนจะเจอละ case น่าจะอันเดียวกันกับ wallet ที่ทำ infinity loop
        if (transaction.getGoalIdGoal() != null || !StringUtils.isEmpty(goIdTrim)) {

            if (transactionCategory.getId() != 32)
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id is invalid. ");

            goId = Integer.parseInt(goIdTrim);
            Goal goal = goalRepository.viewGoalByGoalId(goId);
            if (goal == null)
                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "goal id " + goIdTrim + " is not created. ");

            if (transaction.getGoalIdGoal() == null)
                throw new PlutoCartServiceApiException(ResultCode.NOT_FOUND, "update failed because this transaction don't have goal id before. ");

            if (transaction.getGoalIdGoal().getId() != goId)
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "goal id is invalid for this transaction");
        }

        if (!StringUtils.isEmpty(deIdTrim)) {

            if (transactionCategory.getId() != 33)
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "transaction category id is invalid. ");

            deId = Integer.parseInt(deIdTrim);
//            Debt debt = debtRepository.viewDebtByDebtId(deId);

//            if (debt == null)
//                throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "debt id " + deIdTrim + " is not created. ");

            if (transaction.getDebtIdDebt() == null)
                throw new PlutoCartServiceApiException(ResultCode.NOT_FOUND, "update failed because this transaction don't have debt id before. ");

            if (transaction.getDebtIdDebt().getId() != deId)
                throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "goal id is invalid for this transaction");
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

}

// 1. goal, debt = null
// 2. goal check goal != goal_req
// 3. debt check debt != debt_req
// 4.

//check 4 cases
// case goal & debt id is null
// create common transaction
//
//

// update common transaction
// get the old stm transaction & stm type
// update wallet balance ( reset wallet balance is back before got this transaction )
// update transaction by transaction id
// create new balance based on stm transaction by check stm type
// update wallet balance by new balance that get from new transaction stm transaction

// cast goal id is not null
// create goal transaction

// cast debt id is not null
// create debt transaction

// cast goal & debt id is not null
// error


// if goal & debt id is not null throw ex
// check goal is real
// check debt is real

// procedure if
// 1 = balanceAdjustment
// 2, 3, 4 = -balanceAdjustment
// stmType = 1 = root 1 (create transaction),
// stmType = 2 = root 2 (create transaction),
// stmType = 3 = root 3 (create transaction & update goal amount or deficit),
// stmType = 4 = root 4 (create transaction & update debt amount or deficit)
// then update wallet balance