package com.example.plutocart.services;

import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.debt.*;
import com.example.plutocart.dtos.goal.GResDelDTO;
import com.example.plutocart.entities.Debt;
import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiForbidden;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.repositories.DebtRepository;
import com.example.plutocart.utils.GenericResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DebtService {
    @Autowired
    DebtRepository debtRepository;

    @Autowired
    DebtValidationService debtValidationService;
    @Autowired
    GlobalValidationService globalValidationService;
    @Autowired
    ModelMapper modelMapper;


    public GenericResponse getDebtByAccountId(String accountId, String token) throws PlutoCartServiceApiException {
        globalValidationService.validationToken(accountId, token);
        Integer acId = globalValidationService.validationAccountId(accountId);

        GenericResponse response = new GenericResponse();
        List<Debt> debtList = debtRepository.viewDebtByAccountId(acId);
        List<DebtDTO> debtResponse = debtList.stream().map(debt -> modelMapper.map(debt, DebtDTO.class)).collect(Collectors.toList());

        response.setData(debtResponse);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }

    @Transactional
    public GenericResponse insertDebtByAccountId(String accountId, String nameDebt, String amountDebt, String payPeriod, String numOfPaidPeriod, String paidDebtPerPeriod, String totalPaidDebt, String moneyLender, LocalDateTime latestPayDate, String token) throws PlutoCartServiceApiException {

        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        DReqPostDTO dReqPostDTO = debtValidationService.validationCreateDebt(accountId, nameDebt, amountDebt, payPeriod, numOfPaidPeriod, paidDebtPerPeriod, totalPaidDebt, moneyLender, latestPayDate);
        debtRepository.insertDebtByAccountId(dReqPostDTO.getNameDebt(), dReqPostDTO.getAmountDebt(), dReqPostDTO.getPayPeriod(), dReqPostDTO.getNumOfPaidPeriod(), dReqPostDTO.getPaidDebtPerPeriod(), dReqPostDTO.getTotalPaidDebt(), dReqPostDTO.getMoneyLender(), dReqPostDTO.getLatestPayDate(), dReqPostDTO.getAccountId());

        GenericResponse response = new GenericResponse();
        DResPostDTO dResPostDTO = new DResPostDTO();

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
    public GenericResponse updateDebtByAccountId(String accountId, String debtId, String nameDebt, String amountDebt, String payPeriod, String numOfPaidPeriod, String paidDebtPerPeriod, String totalPaidDebt, String moneyLender, LocalDateTime latestPayDate, String token) throws PlutoCartServiceApiForbidden, PlutoCartServiceApiInvalidParamException, PlutoCartServiceApiDataNotFound {
        globalValidationService.validationToken(accountId, token);
        DReqPutDTO dReqPutDTO = debtValidationService.validationUpdateDebt(accountId, debtId, nameDebt, amountDebt, payPeriod, numOfPaidPeriod, paidDebtPerPeriod, totalPaidDebt, moneyLender, latestPayDate);
        debtRepository.updateDebtByAccountId(dReqPutDTO.getNameDebt(), dReqPutDTO.getAmountDebt(), dReqPutDTO.getPayPeriod(), dReqPutDTO.getNumOfPaidPeriod(), dReqPutDTO.getPaidDebtPerPeriod(), dReqPutDTO.getTotalPaidDebt(), dReqPutDTO.getMoneyLender(), dReqPutDTO.getLatestPayDate(), dReqPutDTO.getDebtId());

        GenericResponse response = new GenericResponse();
        DResPutDTO dResPutDTO = new DResPutDTO();

        dResPutDTO.setAccountId(dReqPutDTO.getAccountId());
        dResPutDTO.setDebtId(dReqPutDTO.getDebtId());
        dResPutDTO.setNameDebt(dReqPutDTO.getNameDebt());
        dResPutDTO.setAmountDebt(dReqPutDTO.getAmountDebt());
        dResPutDTO.setPayPeriod(dReqPutDTO.getPayPeriod());
        dResPutDTO.setNumOfPaidPeriod(dReqPutDTO.getNumOfPaidPeriod());
        dResPutDTO.setPaidDebtPerPeriod(dReqPutDTO.getPaidDebtPerPeriod());
        dResPutDTO.setTotalPaidDebt(dReqPutDTO.getTotalPaidDebt());
        dResPutDTO.setMoneyLender(dReqPutDTO.getMoneyLender());
        dResPutDTO.setLatestPayDate(dReqPutDTO.getLatestPayDate());
        dResPutDTO.setDescription("Create Success.");

        response.setData(dResPutDTO);
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