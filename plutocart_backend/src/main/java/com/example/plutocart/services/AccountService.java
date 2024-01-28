package com.example.plutocart.services;

import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.security.IMEIEncryption;
import com.example.plutocart.utils.GenericResponse;
import com.example.plutocart.constants.ResultCode;
import io.jsonwebtoken.Jwts;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Service
public class AccountService {
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    AccountRepository accountRepository;

    public GenericResponse CreateAccountByImei(AccountDTO accountDTO){
        IMEIEncryption imeiEncryption = new IMEIEncryption();
        GenericResponse response = new GenericResponse();
       try {
           String imE = imeiEncryption.encryptIMEI(accountDTO.getImei());
           accountRepository.CreateAccountByImei(imE);
           Account account = accountRepository.getAccountByImeiAndRole(imE , 1);
           accountDTO.setImei(imE);
           accountDTO.setAccountRole(account.getAccountRole());
           accountDTO.setAccountId(account.getAccountId());
           response.setStatus(ResultCode.SUCCESS);
           response.setData(accountDTO);
           String acId = String.valueOf(accountDTO.getAccountId());
           String token = JwtUtil.generateToken(acId);
           response.setAuthentication(token);
           return response;
       }
       catch (Exception ex){
           response.setStatus(ResultCode.BAD_REQUEST);
       }
       return response;
    }

    public GenericResponse CreateAccountByGoogle(AccountDTO accountDTO){
        IMEIEncryption imeiEncryption = new IMEIEncryption();
        GenericResponse response = new GenericResponse();
        try {
            if(accountDTO.getEmail() != null){
                String imE = imeiEncryption.encryptIMEI(accountDTO.getImei());
                accountRepository.CreateAccountByGoogle(imE , accountDTO.getEmail());
                Account account = accountRepository.getAccountByGoogleAndRole(accountDTO.getEmail() , 2);
                accountDTO.setImei(imE);
                accountDTO.setEmail(accountDTO.getEmail());
                accountDTO.setAccountRole(account.getAccountRole());
                accountDTO.setAccountId(account.getAccountId());
                response.setStatus(ResultCode.SUCCESS);
                response.setData(accountDTO);
                String acId = String.valueOf(accountDTO.getAccountId());
                String token = JwtUtil.generateToken(acId);
                response.setAuthentication(token);
                return response;
            }

        }
        catch (Exception ex){
            response.setStatus(ResultCode.BAD_REQUEST);
        }
        return response;
    }

    public GenericResponse UpdateAccountToMember(String email , Integer accountId , String token){
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);
        if(Integer.parseInt(userId) == accountId){
            try {
                accountRepository.updateAccountToMember(email , accountId);
                response.setStatus(ResultCode.SUCCESS);
                Account account = accountRepository.findById(accountId).get();
                account.setAccountRole("Member");
                account.setEmail(email);
                response.setData(account);
                return response;
            }
            catch (Exception ex){
                response.setStatus(ResultCode.BAD_REQUEST);
                response.setData(null);
                return response;
            }
        }
        else {
            response.setStatus(ResultCode.FORBIDDEN);
            response.setData(null);
            return response;
        }

    }

    public GenericResponse DeleteAccount(Integer accountId , String token){
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);
        System.out.println("using DeleteAccount Service");
        if(Integer.parseInt(userId) == accountId){
            try {
                accountRepository.deleteAccount(accountId);
                response.setStatus(ResultCode.SUCCESS);
                return response;
            }
            catch (Exception ex){
                response.setStatus(ResultCode.BAD_REQUEST);
                response.setData(null);
                return response;
            }
        }
       else {
           response.setStatus(ResultCode.FORBIDDEN);
           response.setData(null);
           return  response;
        }
    }




}
