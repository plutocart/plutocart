package com.example.plutocart.services;

import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.utils.GenericResponse;
import com.example.plutocart.utils.ResultCode;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountService {
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    AccountRepository accountRepository;


    public GenericResponse CreateAccountByImei(AccountDTO accountDTO){
        GenericResponse response = new GenericResponse();
        accountRepository.CreateAccountByImei(accountDTO.getUserName() , accountDTO.getImei());
        response.setStatus(ResultCode.SUCCESS);
        response.setData(accountDTO);
        return response;
    }

}
