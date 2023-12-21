package com.example.plutocart.controller;

import com.example.plutocart.services.LoginService;
import com.example.plutocart.utils.GenericResponse;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class LoginController {
    @Autowired
    LoginService  loginService;

    @GetMapping("/login/guest")
    public ResponseEntity<GenericResponse> loginGuest( @RequestParam(name = "imei") String imei){
        GenericResponse result =  loginService.loginGuestByImei(imei , 1);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
    @GetMapping("/login/customer")
    public ResponseEntity<GenericResponse> loginCustomer( @RequestParam(name = "email") String email ){
        GenericResponse result =  loginService.loginGoogle(email , 2);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
