package com.example.plutocart.services;

import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.debt.DReqPostDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.utils.HelperMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;

@Service
public class DebtValidationService {

    @Autowired
    AccountRepository accountRepository;

    public DReqPostDTO validationCreateDebt(String accountId, String nameDebt, String amountDebt, String installmentDebt, String numOfInstallmentPay, String totalPaidDebt, String description) throws PlutoCartServiceApiException {

        if (!HelperMethod.isInteger(accountId))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(accountId);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account Id " + accountId + " is not created. ");

        if (StringUtils.isEmpty(nameDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "name of debt must be not empty. ");

        if (nameDebt.length() > 45)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "name of debt is over of limit character. ");

        if (StringUtils.isEmpty(amountDebt) || !HelperMethod.isDecimal(amountDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "amount of debt must be number. ");

        BigDecimal amountD = new BigDecimal(amountDebt);

        if (StringUtils.isEmpty(installmentDebt) || !HelperMethod.isInteger(installmentDebt) || Integer.parseInt(installmentDebt) <= 0 || Integer.parseInt(installmentDebt) > 360)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "installment of debt must be number and minimum is 1 maximum is 360. ");

        Integer installmentD = Integer.parseInt(installmentDebt);

        if (StringUtils.isEmpty(numOfInstallmentPay) || !HelperMethod.isInteger(numOfInstallmentPay) || Integer.parseInt(numOfInstallmentPay) < 0)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "number of installment pay of debt must be number minimum is 0. ");

        Integer numOfInstallmentP = Integer.parseInt(numOfInstallmentPay);

        if (numOfInstallmentP > installmentD)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "number of installment pay of debt must not over of installment debt. ");

        if (StringUtils.isEmpty(totalPaidDebt) || !HelperMethod.isDecimal(totalPaidDebt))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "total paid of debt must be number. ");

        BigDecimal totalPaidD = new BigDecimal(totalPaidDebt);

        if (description.length() > 100)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "description is over of limit character. ");


        DReqPostDTO dReqPostDTO = new DReqPostDTO();
        dReqPostDTO.setAccountId(acId);
        dReqPostDTO.setNameDebt(nameDebt);
        dReqPostDTO.setAmountDebt(amountD);
        dReqPostDTO.setInstallmentDebt(installmentD);
        dReqPostDTO.setNumOfInstallmentPay(numOfInstallmentP);
        dReqPostDTO.setTotalPaidDebt(totalPaidD);
        dReqPostDTO.setDescription(description);
        return dReqPostDTO;
    }
}
