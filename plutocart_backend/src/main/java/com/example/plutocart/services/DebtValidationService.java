package com.example.plutocart.services;

import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.debt.DReqDelDTO;
import com.example.plutocart.dtos.debt.DReqPostDTO;
import com.example.plutocart.dtos.debt.DReqPutDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.entities.Debt;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.DebtRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.utils.HelperMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class DebtValidationService {

    @Autowired
    AccountRepository accountRepository;
    @Autowired
    DebtRepository debtRepository;
    @Autowired
    TransactionRepository transactionRepository;
    @Autowired
    TransactionService transactionService;

    public DReqPostDTO validationCreateDebt(String accountId, String nameDebt, String amountDebt, String payPeriod, String numOfPaidPeriod, String paidDebtPerPeriod, String totalPaidDebt, String moneyLender, LocalDateTime latestPayDate) throws PlutoCartServiceApiException {

        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account id is not found. ");

        if (StringUtils.isEmpty(nameDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "name of debt must be not empty. ");

        if (nameDebt.length() > 45)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "name of debt is over maximum length is 45. ");

        if (StringUtils.isEmpty(amountDebt) || !HelperMethod.isDecimal(amountDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "amount of debt must be number. ");

        BigDecimal amountD = new BigDecimal(amountDebt);
//        Double amountDebtDouble = Double.valueOf(amountDebt);

        if (StringUtils.isEmpty(payPeriod) || !HelperMethod.isInteger(payPeriod) || Integer.parseInt(payPeriod) <= 0 || Integer.parseInt(payPeriod) > 360)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "pay period of debt must be number and minimum is 1 maximum is 360. ");

        Integer payP = Integer.parseInt(payPeriod);

        if (StringUtils.isEmpty(numOfPaidPeriod) || !HelperMethod.isInteger(numOfPaidPeriod) || Integer.parseInt(numOfPaidPeriod) < 0)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "number of paid period of debt must be number minimum is 0. ");

        Integer numOfPaidP = Integer.parseInt(numOfPaidPeriod);

        if ((numOfPaidP == 0 && latestPayDate != null) || (numOfPaidP > 0 && latestPayDate == null))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "you must have paid your debt at least 1 time for define your latest date of pay. ");

        if (numOfPaidP > payP)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "number of paid period of debt must not over of pay period debt. ");

        if (StringUtils.isEmpty(paidDebtPerPeriod) || !HelperMethod.isDecimal(paidDebtPerPeriod))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "paid debt per period must be number. ");

        BigDecimal paidDebtPerP = new BigDecimal(paidDebtPerPeriod);
//        Double paidDebtPerPeriodDouble = Double.valueOf(paidDebtPerPeriod);

//        if ((amountDebtDouble / payP) != paidDebtPerPeriodDouble)
//            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "invalid paid debt per period for this debt. ");

        if (StringUtils.isEmpty(totalPaidDebt) || !HelperMethod.isDecimal(totalPaidDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "total paid of debt must be number. ");

        BigDecimal totalPaidD = new BigDecimal(totalPaidDebt);

        if (moneyLender.length() > 15)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "money lender is over maximum length is 15. ");

        DReqPostDTO dReqPostDTO = new DReqPostDTO();
        dReqPostDTO.setAccountId(acId);
        dReqPostDTO.setNameDebt(nameDebt);
        dReqPostDTO.setAmountDebt(amountD);
        dReqPostDTO.setPayPeriod(payP);
        dReqPostDTO.setNumOfPaidPeriod(numOfPaidP);
        dReqPostDTO.setPaidDebtPerPeriod(paidDebtPerP);
        dReqPostDTO.setTotalPaidDebt(totalPaidD);
        dReqPostDTO.setMoneyLender(moneyLender);
        dReqPostDTO.setLatestPayDate(latestPayDate);
        return dReqPostDTO;
    }

    public DReqPutDTO validationUpdateDebt(String accountId, String debtId, String nameDebt, String amountDebt, String payPeriod, String numOfPaidPeriod, String paidDebtPerPeriod, String totalPaidDebt, String moneyLender, LocalDateTime latestPayDate) throws PlutoCartServiceApiInvalidParamException, PlutoCartServiceApiDataNotFound {

        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account id is not found. ");

        if (!HelperMethod.isInteger(debtId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "debt id must be number. ");

        Integer deId = Integer.parseInt(debtId);
        Debt debt = debtRepository.viewDebtByDebtId(deId);
        if (debt == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "debt id is not found. ");

        if (StringUtils.isEmpty(nameDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "name of debt must be not empty. ");

        if (nameDebt.length() > 45)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "name of debt is over maximum length is 45. ");

        if (StringUtils.isEmpty(amountDebt) || !HelperMethod.isDecimal(amountDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "amount of debt must be number. ");

        BigDecimal amountD = new BigDecimal(amountDebt);
//        Double amountDebtDouble = Double.valueOf(amountDebt);

        if (StringUtils.isEmpty(payPeriod) || !HelperMethod.isInteger(payPeriod) || Integer.parseInt(payPeriod) <= 0 || Integer.parseInt(payPeriod) > 360)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "pay period of debt must be number and minimum is 1 maximum is 360. ");

        Integer payP = Integer.parseInt(payPeriod);

        if (StringUtils.isEmpty(numOfPaidPeriod) || !HelperMethod.isInteger(numOfPaidPeriod) || Integer.parseInt(numOfPaidPeriod) < 0)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "number of paid period of debt must be number minimum is 0. ");

        Integer numOfPaidP = Integer.parseInt(numOfPaidPeriod);

        if ((numOfPaidP == 0 && latestPayDate != null) || (numOfPaidP > 0 && latestPayDate == null))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "you must have paid your debt at least 1 time for define your latest date of pay. ");

//        if (numOfPaidP > payP)
//            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "number of paid period of debt must not over of pay period debt. ");

        if (StringUtils.isEmpty(paidDebtPerPeriod) || !HelperMethod.isDecimal(paidDebtPerPeriod))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "paid debt per period must be number. ");

        BigDecimal paidDebtPerP = new BigDecimal(paidDebtPerPeriod);
//        Double paidDebtPerPeriodDouble = Double.valueOf(paidDebtPerPeriod);

//        if ((amountDebtDouble / payP) != paidDebtPerPeriodDouble)
//            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "invalid paid debt per period for this debt. ");

        if (StringUtils.isEmpty(totalPaidDebt) || !HelperMethod.isDecimal(totalPaidDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "total paid of debt must be number. ");

        BigDecimal totalPaidD = new BigDecimal(totalPaidDebt);

        if (moneyLender.length() > 15)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "money lender is over maximum length is 15. ");

        DReqPutDTO dReqPutDTO = new DReqPutDTO();
        dReqPutDTO.setAccountId(acId);
        dReqPutDTO.setDebtId(deId);
        dReqPutDTO.setNameDebt(nameDebt);
        dReqPutDTO.setAmountDebt(amountD);
        dReqPutDTO.setPayPeriod(payP);
        dReqPutDTO.setNumOfPaidPeriod(numOfPaidP);
        dReqPutDTO.setPaidDebtPerPeriod(paidDebtPerP);
        dReqPutDTO.setTotalPaidDebt(totalPaidD);
        dReqPutDTO.setMoneyLender(moneyLender);
        dReqPutDTO.setLatestPayDate(latestPayDate);
        return dReqPutDTO;
    }


    public DReqDelDTO validationDeleteDebt(String accountId, String debtId, String token) throws Exception {
        String transactionId = null;
        String walletId = null;

        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account id is not found. ");

        if (!HelperMethod.isInteger(debtId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "debt id must be number. ");

        Integer deId = Integer.parseInt(debtId);
        Debt debt = debtRepository.viewDebtByDebtId(deId);
        if (debt == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "debt id is not found. ");

        List<Transaction> transactionList = transactionRepository.viewTransactionByDebtId(deId);
        if (!transactionList.isEmpty()) {
            for (Transaction transaction : transactionList) {
                transactionId = String.valueOf(transaction.getId());
                walletId = String.valueOf(transaction.getWalletIdWallet().getWalletId());
                transactionService.deleteTransaction(accountId, walletId, transactionId, token);
            }
        }

        DReqDelDTO dReqDelDTO = new DReqDelDTO();
        dReqDelDTO.setAccountId(acId);
        dReqDelDTO.setDebtId(deId);
        return dReqDelDTO;
    }

}
