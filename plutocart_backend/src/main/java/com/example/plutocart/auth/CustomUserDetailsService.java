package com.example.plutocart.auth;

import com.example.plutocart.entities.Account;
import com.example.plutocart.repositories.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    AccountRepository accountRepository;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
            Account account = accountRepository.getAccountById(Integer.parseInt(username));
        return org.springframework.security.core.userdetails.User
                .withUsername(String.valueOf(account.getAccountId()))
                .password("password") // Replace with hashed password in a real scenario
                .build();
    }
}