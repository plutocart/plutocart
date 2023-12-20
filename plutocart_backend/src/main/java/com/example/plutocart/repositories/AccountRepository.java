package com.example.plutocart.repositories;

import com.example.plutocart.dtos.account.AccountDTO;
import com.example.plutocart.entities.Account;
import com.example.plutocart.entities.Wallet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {


    @Transactional
    @Modifying
    @Procedure(procedureName = "createAccountByImei")
    void CreateAccountByImei(String userName , String imei);

    @Query(value = "select * from account where  imei = :imei and account_role = 1" , nativeQuery = true)
    Account getAccountByImeiAndRole(String imei);

}