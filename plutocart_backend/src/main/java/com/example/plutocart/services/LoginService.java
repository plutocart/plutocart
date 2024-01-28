package com.example.plutocart.services;

import com.example.plutocart.auth.JwtUtil;
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

    public GenericResponse loginGuestByImei(String imei , int accountRole){
        GenericResponse response = new GenericResponse();
        IMEIEncryption imeiEncryption = new IMEIEncryption();
        try {
            Account account = accountRepository.getAccountByImeiAndRole(imeiEncryption.encryptIMEI(imei) , accountRole);
            response.setData( modelMapper.map(account , AccountDTO.class));
            response.setStatus(ResultCode.SUCCESS);
            String acId = String.valueOf(account.getAccountId());
            String token = JwtUtil.generateToken(acId);
            response.setAuthentication(token);
            return response;
        }
        catch (Exception ex){
            response.setStatus(ResultCode.NOT_FOUND);
            return response;
        }
    }

    public GenericResponse loginGoogle(String email , int accountRole){
        GenericResponse response = new GenericResponse();
        try {
            Account account = accountRepository.getAccountByGoogleAndRole(email , accountRole);
            response.setData( modelMapper.map(account , AccountDTO.class));
            response.setStatus(ResultCode.SUCCESS);
            String acId = String.valueOf(account.getAccountId());
            String token = JwtUtil.generateToken(acId);
            response.setAuthentication(token);
            return response;
        }
        catch (Exception ex){
            response.setStatus(ResultCode.NOT_FOUND);
            return response;
        }
    }


}
