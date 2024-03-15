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

    @Transactional
    public GenericResponse getDebtByAccountId(String accountId, Integer status, String token) throws PlutoCartServiceApiException {
        globalValidationService.validationToken(accountId, token);
        Integer acId = globalValidationService.validationAccountId(accountId);

        if (status != null && status != 1 && status != 2)
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "invalid status for check debt. ");

        GenericResponse response = new GenericResponse();
        List<Debt> debtList = null;

        if (status == null)
            debtList = debtRepository.viewDebtByAccountId(acId);
        else if (status == 1)
            debtList = debtRepository.viewDebtStatusInProgress(acId);
        else if (status == 2)
            debtList = debtRepository.viewDebtStatusSuccess(acId);

        List<DebtDTO> debtResponse = debtList.stream().map(debt -> modelMapper.map(debt, DebtDTO.class)).collect(Collectors.toList());

        response.setData(debtResponse);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }

    @Transactional
    public GenericResponse insertDebtByAccountId(String accountId, String nameDebt, String totalDebt, String totalPeriod, String paidPeriod, String monthlyPayment, String debtPaid, String moneyLender, LocalDateTime latestPayDate, String token) throws PlutoCartServiceApiException {

        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        DReqPostDTO dReqPostDTO = debtValidationService.validationCreateDebt(accountId, nameDebt, totalDebt, totalPeriod, paidPeriod, monthlyPayment, debtPaid, moneyLender, latestPayDate);
        debtRepository.insertDebtByAccountId(dReqPostDTO.getNameDebt(), dReqPostDTO.getTotalDebt(), dReqPostDTO.getTotalPeriod(), dReqPostDTO.getPaidPeriod(), dReqPostDTO.getMonthlyPayment(), dReqPostDTO.getDebtPaid(), dReqPostDTO.getMoneyLender(), dReqPostDTO.getLatestPayDate(), dReqPostDTO.getAccountId());

        GenericResponse response = new GenericResponse();
        DResPostDTO dResPostDTO = new DResPostDTO();

        dResPostDTO.setAccountId(dReqPostDTO.getAccountId());
        dResPostDTO.setNameDebt(dReqPostDTO.getNameDebt());
        dResPostDTO.setTotalDebt(dReqPostDTO.getTotalDebt());
        dResPostDTO.setTotalPeriod(dReqPostDTO.getTotalPeriod());
        dResPostDTO.setPaidPeriod(dReqPostDTO.getPaidPeriod());
        dResPostDTO.setMonthlyPayment(dReqPostDTO.getMonthlyPayment());
        dResPostDTO.setDebtPaid(dReqPostDTO.getDebtPaid());
        dResPostDTO.setMoneyLender(dReqPostDTO.getMoneyLender());
        dResPostDTO.setLatestPayDate(dReqPostDTO.getLatestPayDate());
        dResPostDTO.setDescription("Create Success.");

        response.setData(dResPostDTO);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }

    @Transactional
    public GenericResponse updateDebtByAccountId(String accountId, String debtId, String nameDebt, String totalDebt, String totalPeriod, String paidPeriod, String monthlyPayment, String debtPaid, String moneyLender, LocalDateTime latestPayDate, String token) throws PlutoCartServiceApiForbidden, PlutoCartServiceApiInvalidParamException, PlutoCartServiceApiDataNotFound {
        globalValidationService.validationToken(accountId, token);
        DReqPutDTO dReqPutDTO = debtValidationService.validationUpdateDebt(accountId, debtId, nameDebt, totalDebt, totalPeriod, paidPeriod, monthlyPayment, debtPaid, moneyLender, latestPayDate);
        debtRepository.updateDebtByAccountId(dReqPutDTO.getNameDebt(), dReqPutDTO.getTotalDebt(), dReqPutDTO.getTotalPeriod(), dReqPutDTO.getPaidPeriod(), dReqPutDTO.getMonthlyPayment(), dReqPutDTO.getDebtPaid(), dReqPutDTO.getMoneyLender(), dReqPutDTO.getLatestPayDate(), dReqPutDTO.getDebtId());

        GenericResponse response = new GenericResponse();
        DResPutDTO dResPutDTO = new DResPutDTO();

        dResPutDTO.setAccountId(dReqPutDTO.getAccountId());
        dResPutDTO.setDebtId(dReqPutDTO.getDebtId());
        dResPutDTO.setNameDebt(dReqPutDTO.getNameDebt());
        dResPutDTO.setTotalDebt(dReqPutDTO.getTotalDebt());
        dResPutDTO.setTotalPeriod(dReqPutDTO.getTotalPeriod());
        dResPutDTO.setPaidPeriod(dReqPutDTO.getPaidPeriod());
        dResPutDTO.setMonthlyPayment(dReqPutDTO.getMonthlyPayment());
        dResPutDTO.setDebtPaid(dReqPutDTO.getDebtPaid());
        dResPutDTO.setMoneyLender(dReqPutDTO.getMoneyLender());
        dResPutDTO.setLatestPayDate(dReqPutDTO.getLatestPayDate());
        dResPutDTO.setDescription("Create Success.");

        response.setData(dResPutDTO);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }

    @Transactional
    public GenericResponse updateDebtToComplete(String accountId, String debtId, String token) throws PlutoCartServiceApiException {
        globalValidationService.validationToken(accountId, token);
        DReqPutDTO dReqPutDTO = debtValidationService.validationUpdateDebtToComplete(accountId, debtId);

        DResPutDTO dResPutDTO = new DResPutDTO();
        debtRepository.updateDebtToComplete(dReqPutDTO.getAccountId(), dReqPutDTO.getDebtId());

        GenericResponse response = new GenericResponse();

        dResPutDTO.setAccountId(dReqPutDTO.getAccountId());
        dResPutDTO.setDebtId(dReqPutDTO.getDebtId());
        dResPutDTO.setDescription("Update Success");

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