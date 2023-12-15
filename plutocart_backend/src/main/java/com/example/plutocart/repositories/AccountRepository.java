package com.example.plutocart.repositories;

import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {

    @Transactional
    @Modifying
    @Query(value = "insert into account (user_name , imei , email , password , account_role) values(:userName , :imei , null , null , default)" , nativeQuery = true)
    void CreateAccountByImei(String userName , String imei);
}