package com.example.plutocart.services;


import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.goal.GoalDTO;
import com.example.plutocart.entities.Goal;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.repositories.GoalRepository;
import com.example.plutocart.utils.GenericResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class GoalService {

    @Autowired
    GoalRepository goalRepository;

    @Autowired
    ValidationIdService validationIdService;

    public GenericResponse getGoalByAccountId(String accountId) throws PlutoCartServiceApiException {
        GenericResponse response = new GenericResponse();
        Integer acId = validationIdService.validationAccountId(accountId);

        //wait for dto model

        List<Goal> goalList = goalRepository.viewGoalByAccountId(acId);
//        goalRepository.

        return response;
    }

    public GenericResponse insertGoalByAccountId(String nameGoal , BigDecimal amountGoal , BigDecimal deficit , LocalDateTime endDateGoal , Integer accountId){
            GenericResponse response = new GenericResponse();
            try {
                goalRepository.insertGoalByAccountId(nameGoal, amountGoal, deficit, endDateGoal, accountId);
                response.setStatus(ResultCode.SUCCESS);
                GoalDTO goalDTO = new GoalDTO();
                goalDTO.setNameGoal(nameGoal);
                goalDTO.setAmountGoal(amountGoal);
                goalDTO.setDeficit(deficit);
                goalDTO.setEndDateGoal(endDateGoal);
                goalDTO.setAccountId(accountId);
                response.setData(goalDTO);
                return  response;
            }
            catch (Exception exception){
                response.setStatus(ResultCode.BAD_REQUEST);
                response.setData(null);
                return response;
            }
    }

}
