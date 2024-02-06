package com.example.plutocart.services;


import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.goal.*;
import com.example.plutocart.entities.Goal;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiForbidden;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.repositories.GoalRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.utils.GenericResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    TransactionRepository transactionRepository;
    @Autowired
    GlobalValidationService globalValidationService;
    @Autowired
    TransactionService transactionService;
    @Autowired
    GoalValidationService goalValidationService;
    @Autowired
    ModelMapper modelMapper;

    @Transactional
    public GenericResponse getGoalByAccountId(String accountId, String token) throws PlutoCartServiceApiException {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        Integer acId = globalValidationService.validationAccountId(accountId);

        List<Goal> goalList = goalRepository.viewGoalByAccountId(acId);
        List<GoalDTO> goalResponse = goalList.stream().map(goal -> modelMapper.map(goal, GoalDTO.class)).collect(Collectors.toList());

        response.setData(goalResponse);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }

    @Transactional
    public GenericResponse insertGoalByAccountId(String accountId, String nameGoal, String amountGoal, String deficit, LocalDateTime endDateGoal, String token) throws PlutoCartServiceApiException {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        GoalResPostDTO goalResPostDTO = new GoalResPostDTO();

        GReqPostDTO gReqPostDTO = goalValidationService.validationCreateGoal(accountId, nameGoal, amountGoal, deficit);

        goalRepository.insertGoalByAccountId(gReqPostDTO.getNameGoal(), gReqPostDTO.getAmountGoal(), gReqPostDTO.getDeficit(), endDateGoal, gReqPostDTO.getAccountId());

        goalResPostDTO.setAcId(gReqPostDTO.getAccountId());
        goalResPostDTO.setNameGoal(gReqPostDTO.getNameGoal());
        goalResPostDTO.setAmountGoal(gReqPostDTO.getAmountGoal());
        goalResPostDTO.setDeficit(gReqPostDTO.getDeficit());
        goalResPostDTO.setEndDateGoal(endDateGoal);
        goalResPostDTO.setDescription("Create Success.");
        response.setStatus(ResultCode.SUCCESS);
        response.setData(goalResPostDTO);
        return response;
    }

    @Transactional
    public GenericResponse updateGoalByGoalId(String accountId, String goalId, String nameGoal, String amountGoal, String deficit, LocalDateTime endDateGoal, String token) throws PlutoCartServiceApiException {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        GoalResPostDTO goalResPostDTO = new GoalResPostDTO();
        GReqPostDTO gReqPostDTO = goalValidationService.validationUpdateGoal(accountId, goalId, nameGoal, amountGoal, deficit);

        goalRepository.updateGoalByGoalId(gReqPostDTO.getNameGoal(), gReqPostDTO.getAmountGoal(), gReqPostDTO.getDeficit(), endDateGoal, gReqPostDTO.getGoalId());

        goalResPostDTO.setAcId(gReqPostDTO.getAccountId());
        goalResPostDTO.setNameGoal(gReqPostDTO.getNameGoal());
        goalResPostDTO.setAmountGoal(gReqPostDTO.getAmountGoal());
        goalResPostDTO.setDeficit(gReqPostDTO.getDeficit());
        goalResPostDTO.setEndDateGoal(endDateGoal);
        goalResPostDTO.setDescription("Update Success");

        response.setData(goalResPostDTO);
        response.setStatus(ResultCode.SUCCESS);

        return response;
    }


    @Transactional
    public GenericResponse deleteGoalByGoalId(String accountId, String goalId, String token) throws Exception {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        GResDelDTO gResDelDTO = new GResDelDTO();

        GReqDelDTO gReqDelDTO = goalValidationService.validationDeleteGoal(accountId, goalId, token);
        goalRepository.deleteGoalByGoalId(gReqDelDTO.getGoalId());

        gResDelDTO.setAccountId(gReqDelDTO.getAccountId());
        gResDelDTO.setGoalId(gReqDelDTO.getGoalId());
        gResDelDTO.setDescription("Delete Success");

        response.setData(gResDelDTO);
        response.setStatus(ResultCode.SUCCESS);
        return response;
    }


}