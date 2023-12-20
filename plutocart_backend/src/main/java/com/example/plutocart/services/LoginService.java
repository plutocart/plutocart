package com.example.plutocart.services;

import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.security.IMEIEncryption;
import com.example.plutocart.utils.GenericResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    AccountRepository accountRepository;
    @Autowired
    ModelMapper modelMapper;

    public GenericResponse loginGuestByImei(String imei){
        GenericResponse response = new GenericResponse();
        IMEIEncryption imeiEncryption = new IMEIEncryption();
        try {
            Account account = accountRepository.getAccountByImeiAndRole(imeiEncryption.encryptIMEI(imei));
            response.setData( modelMapper.map(account , AccountDTO.class));
            response.setStatus(ResultCode.SUCCESS);
            return response;
        }
        catch (Exception ex){
            response.setStatus(ResultCode.NOT_FOUND);
            return response;
        }
    }
}
