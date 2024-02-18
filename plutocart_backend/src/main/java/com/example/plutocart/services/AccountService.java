package com.example.plutocart.services;

import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.constants.RegularExpression;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.exceptions.PlutoCartServiceApiForbidden;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.repositories.AccountRepository;
import com.example.plutocart.security.IMEIEncryption;
import com.example.plutocart.utils.GenericResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class AccountService {
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    AccountRepository accountRepository;

    public GenericResponse CreateAccountByImei(AccountDTO accountDTO) throws PlutoCartServiceApiInvalidParamException {
        IMEIEncryption imeiEncryption = new IMEIEncryption();
        GenericResponse response = new GenericResponse();
        try {
            String imE = imeiEncryption.encryptIMEI(accountDTO.getImei());
            accountRepository.CreateAccountByImei(imE);
            Account account = accountRepository.getAccountByImeiAndRole(imE, 1);
            accountDTO.setImei(imE);
            accountDTO.setAccountRole(account.getAccountRole());
            accountDTO.setAccountId(account.getAccountId());
            response.setStatus(ResultCode.SUCCESS);
            response.setData(accountDTO);
            String acId = String.valueOf(accountDTO.getAccountId());
            String token = JwtUtil.generateToken(acId);
            response.setAuthentication(token);
            return response;
        } catch (Exception ex) {
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.BAD_REQUEST, "invalid body request.");
        }
    }

    public GenericResponse CreateAccountByGoogle(AccountDTO accountDTO) throws PlutoCartServiceApiInvalidParamException {
        IMEIEncryption imeiEncryption = new IMEIEncryption();
        GenericResponse response = new GenericResponse();
        try {
            if (!StringUtils.isEmpty(accountDTO.getEmail())) {
                String imE = imeiEncryption.encryptIMEI(accountDTO.getImei());
                accountRepository.CreateAccountByGoogle(imE, accountDTO.getEmail());
                Account account = accountRepository.getAccountByGoogleAndRole(accountDTO.getEmail(), 2);
                accountDTO.setImei(imE);
                accountDTO.setEmail(accountDTO.getEmail());
                accountDTO.setAccountRole(account.getAccountRole());
                accountDTO.setAccountId(account.getAccountId());
                response.setStatus(ResultCode.SUCCESS);
                response.setData(accountDTO);
                String acId = String.valueOf(accountDTO.getAccountId());
                String token = JwtUtil.generateToken(acId);
                response.setAuthentication(token);

            }
            return response;

        } catch (Exception ex) {
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.BAD_REQUEST, "invalid body request.");
        }
    }

    public GenericResponse UpdateAccountToMember(String email, Integer accountId, String token) throws PlutoCartServiceApiForbidden, PlutoCartServiceApiInvalidParamException {
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);
        if (Integer.parseInt(userId) != accountId)
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        if (!RegularExpression.isValidEmail(email))
            throw new PlutoCartServiceApiForbidden(ResultCode.INVALID_PARAM, "email is invalid format. ");

        try {
            accountRepository.updateAccountToMember(email, accountId);
            response.setStatus(ResultCode.SUCCESS);
            Account account = accountRepository.findById(accountId).get();
            account.setAccountRole("Member");
            account.setEmail(email);
            response.setData(account);
            return response;
        } catch (Exception ex) {
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.BAD_REQUEST, "invalid body request.");
        }

    }

    public GenericResponse DeleteAccount(Integer accountId, String token) throws PlutoCartServiceApiInvalidParamException, PlutoCartServiceApiForbidden {
        GenericResponse response = new GenericResponse();
        String userId = JwtUtil.extractUsername(token);
        System.out.println("using DeleteAccount Service");

        if (Integer.parseInt(userId) != accountId)
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        try {
            accountRepository.deleteAccount(accountId);
            response.setStatus(ResultCode.SUCCESS);
            return response;
        } catch (Exception ex) {
            throw new PlutoCartServiceApiInvalidParamException(ResultCode.BAD_REQUEST, "invalid body request.");
        }

    }

}
