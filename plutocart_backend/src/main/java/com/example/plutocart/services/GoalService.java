package com.example.plutocart.services;


import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.goal.GoalDTO;
import com.example.plutocart.repositories.GoalRepository;
import com.example.plutocart.utils.GenericResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class GoalService {

    @Autowired
    GoalRepository goalRepository;


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
