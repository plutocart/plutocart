package com.example.plutocart.services;


import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.goal.GReqPostDTO;
import com.example.plutocart.dtos.goal.GoalDTO;
import com.example.plutocart.dtos.goal.GoalResPostDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.entities.Goal;
import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.GoalRepository;
import com.example.plutocart.utils.GenericResponse;
import com.example.plutocart.utils.HelperMethod;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class GoalService {

    @Autowired
    GoalRepository goalRepository;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    ValidationIdService validationIdService;
    @Autowired
    ModelMapper modelMapper;

    public GenericResponse getGoalByAccountId(String accountId) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        Integer acId = validationIdService.validationAccountId(accountId);

        List<Goal> goalList = goalRepository.viewGoalByAccountId(acId);
        List<GoalDTO> goalResponse = goalList.stream().map(goal -> modelMapper.map(goal, GoalDTO.class)).collect(Collectors.toList());

        response.setData(goalResponse);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }

    @Transactional
    public GenericResponse insertGoalByAccountId(String accountId, String nameGoal, String amountGoal, String deficit, LocalDateTime endDateGoal) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        GoalResPostDTO goalResPostDTO = new GoalResPostDTO();
        GReqPostDTO gReqPostDTO = validationCreateGoal(accountId, nameGoal, amountGoal, deficit);

        goalRepository.insertGoalByAccountId(gReqPostDTO.getNameGoal(), gReqPostDTO.getAmountGoal(), gReqPostDTO.getDeficit(), endDateGoal, gReqPostDTO.getAccountId());

        goalResPostDTO.setAcId(gReqPostDTO.getAccountId());
        goalResPostDTO.setNameGoal(gReqPostDTO.getNameGoal());
        goalResPostDTO.setAmountGoal(gReqPostDTO.getAmountGoal());
        goalResPostDTO.setDeficit(gReqPostDTO.getDeficit());
        goalResPostDTO.setEndDateGoal(endDateGoal);
        response.setStatus(ResultCode.SUCCESS);
        response.setData(goalResPostDTO);
        return response;
    }

    public GReqPostDTO validationCreateGoal(String accountId, String nameGoal, String amountGoal, String deficit) throws PlutoCartServiceApiException {
        String acIdTrim = accountId.trim();
        String nGoalTrim = nameGoal.trim();
        String aGoalTrim = amountGoal.trim();
        String defTrim = deficit.trim();

        if (!HelperMethod.isInteger(acIdTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "account id must be number. ");

        Integer acId = Integer.parseInt(acIdTrim);
        Account account = accountRepository.getAccountById(acId);
        if (account == null)
            throw new PlutoCartServiceApiDataNotFound(ResultCode.DATA_NOT_FOUND, "account Id " + acIdTrim + " is not created. ");

        if (StringUtils.isEmpty(nGoalTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "name goal must be string. ");

        if (StringUtils.isEmpty(aGoalTrim) || !HelperMethod.isDecimal(aGoalTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "amount goal must be decimal. ");

        BigDecimal aGoal = new BigDecimal(aGoalTrim);

        if (StringUtils.isEmpty(defTrim) || !HelperMethod.isDecimal(defTrim))
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.INVALID_PARAM, "deficit must be decimal. ");

        BigDecimal def = new BigDecimal(defTrim);

        GReqPostDTO gReqPostDTO = new GReqPostDTO();
        gReqPostDTO.setAccountId(acId);
        gReqPostDTO.setNameGoal(nGoalTrim);
        gReqPostDTO.setAmountGoal(aGoal);
        gReqPostDTO.setDeficit(def);
        return gReqPostDTO;
    }
}
