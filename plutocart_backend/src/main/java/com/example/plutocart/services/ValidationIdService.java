package com.example.plutocart.services;

import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.transaction.TReqGetByAcIdWalId;
import com.example.plutocart.entities.Account;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.repositories.WalletRepository;
import com.example.plutocart.utils.HelperMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ValidationIdService {

    @Autowired
    AccountRepository accountRepository;
    @Autowired
    WalletRepository walletRepository;
    @Autowired
    TransactionRepository transactionRepository;

    public Integer validationAccountId(String accountId) throws PlutoCartServiceApiException {
        accountId = accountId.trim();
        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        int acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account Id " + accountId + " is not created. ");

        return acId;
    }

    public TReqGetByAcIdWalId validationAccountIdAndWalletId(String accountId, String walletId) throws PlutoCartServiceApiException {
        accountId = accountId.trim();
        walletId = walletId.trim();

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

}
