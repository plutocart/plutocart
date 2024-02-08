package com.example.plutocart.services;

import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.debt.DReqPostDTO;
import com.example.plutocart.dtos.debt.DResPostDTO;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.repositories.DebtRepository;
import com.example.plutocart.utils.GenericResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DebtService {
    @Autowired
    DebtRepository debtRepository;

    @Autowired
    DebtValidationService debtValidationService;

    @Transactional
    public GenericResponse insertDebtByAccountId(String accountId, String nameDebt, String amountDebt, String installmentDebt, String numOfInstallmentPay, String totalPaidDebt, String description) throws PlutoCartServiceApiException {

        DReqPostDTO dReqPostDTO = debtValidationService.validationCreateDebt(accountId, nameDebt, amountDebt, installmentDebt, numOfInstallmentPay, totalPaidDebt, description);
        debtRepository.insertDebtByAccountId(dReqPostDTO.getNameDebt(), dReqPostDTO.getAmountDebt(), dReqPostDTO.getInstallmentDebt(), dReqPostDTO.getNumOfInstallmentPay(), dReqPostDTO.getTotalPaidDebt(), dReqPostDTO.getDescription(), dReqPostDTO.getAccountId());

        GenericResponse response = new GenericResponse();
        DResPostDTO dResPostDTO = new DResPostDTO();

        dResPostDTO.setAccountId(dReqPostDTO.getAccountId());
        dResPostDTO.setNameDebt(dReqPostDTO.getNameDebt());
        dResPostDTO.setAmountDebt(dReqPostDTO.getAmountDebt());
        dResPostDTO.setInstallmentDebt(dReqPostDTO.getInstallmentDebt());
        dResPostDTO.setNumOfInstallmentPay(dReqPostDTO.getNumOfInstallmentPay());
        dResPostDTO.setTotalPaidDebt(dReqPostDTO.getTotalPaidDebt());
        dResPostDTO.setDescription(dReqPostDTO.getDescription());
        dResPostDTO.setAlert("Create Success.");

        response.setData(dResPostDTO);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }
}