package com.example.plutocart.services;

import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.debt.DReqDelDTO;
import com.example.plutocart.dtos.debt.DReqPostDTO;
import com.example.plutocart.dtos.debt.DResPostDTO;
import com.example.plutocart.dtos.goal.GResDelDTO;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiForbidden;
import com.example.plutocart.repositories.DebtRepository;
import com.example.plutocart.utils.GenericResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class DebtService {
    @Autowired
    DebtRepository debtRepository;

    @Autowired
    DebtValidationService debtValidationService;


    @Transactional
    public GenericResponse insertDebtByAccountId(String accountId, String nameDebt, String amountDebt, String payPeriod, String numOfPaidPeriod, String paidDebtPerPeriod, String totalPaidDebt, String moneyLender, LocalDateTime latestPayDate, String token) throws PlutoCartServiceApiException {

        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        DResPostDTO dResPostDTO = new DResPostDTO();

        DReqPostDTO dReqPostDTO = debtValidationService.validationCreateDebt(accountId, nameDebt, amountDebt, payPeriod, numOfPaidPeriod, paidDebtPerPeriod, totalPaidDebt, moneyLender, latestPayDate);
        debtRepository.insertDebtByAccountId(dReqPostDTO.getNameDebt(), dReqPostDTO.getAmountDebt(), dReqPostDTO.getPayPeriod(), dReqPostDTO.getNumOfPaidPeriod(), dReqPostDTO.getPaidDebtPerPeriod(), dReqPostDTO.getTotalPaidDebt(), dReqPostDTO.getMoneyLender(), dReqPostDTO.getLatestPayDate(), dReqPostDTO.getAccountId());

        dResPostDTO.setAccountId(dReqPostDTO.getAccountId());
        dResPostDTO.setNameDebt(dReqPostDTO.getNameDebt());
        dResPostDTO.setAmountDebt(dReqPostDTO.getAmountDebt());
        dResPostDTO.setPayPeriod(dReqPostDTO.getPayPeriod());
        dResPostDTO.setNumOfPaidPeriod(dReqPostDTO.getNumOfPaidPeriod());
        dResPostDTO.setPaidDebtPerPeriod(dReqPostDTO.getPaidDebtPerPeriod());
        dResPostDTO.setTotalPaidDebt(dReqPostDTO.getTotalPaidDebt());
        dResPostDTO.setMoneyLender(dReqPostDTO.getMoneyLender());
        dResPostDTO.setLatestPayDate(dReqPostDTO.getLatestPayDate());
        dResPostDTO.setDescription("Create Success.");

        response.setData(dResPostDTO);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }

    @Transactional
    public GenericResponse deleteDebtByAccountId(String accountId, String debtId, String token) throws Exception {

        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        GResDelDTO gResDelDTO = new GResDelDTO();

        DReqDelDTO dReqDelDTO = debtValidationService.validationDeleteDebt(accountId, debtId, token);
        debtRepository.deleteDebtByDebtId(dReqDelDTO.getDebtId());

        gResDelDTO.setAccountId(dReqDelDTO.getAccountId());
        gResDelDTO.setGoalId(dReqDelDTO.getDebtId());
        gResDelDTO.setDescription("Delete Success");

        response.setData(gResDelDTO);
        response.setStatus(ResultCode.SUCCESS);

        return response;

    }
}