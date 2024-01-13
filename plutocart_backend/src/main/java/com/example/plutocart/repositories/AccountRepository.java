package com.example.plutocart.repositories;

import com.example.plutocart.entities.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {

    @Transactional
    @Modifying
    @Procedure(procedureName = "createAccountByImei")
    void CreateAccountByImei(String imei);

    @Query(value = "select * from account where  imei = :imei and account_role = :accountRole", nativeQuery = true)
    Account getAccountByImeiAndRole(String imei, int accountRole);

    @Transactional
    @Modifying
    @Procedure(procedureName = "createAccountByGoogle")
    void CreateAccountByGoogle(String imei, String email);

    @Query(value = "select * from account where  email = :email and account_role = :accountRole", nativeQuery = true)
    Account getAccountByGoogleAndRole(String email, int accountRole);

    @Transactional
    @Query(value = "SELECT * FROM account where id_account = :accountId", nativeQuery = true)
    Account getAccountById(Integer accountId);

    @Transactional
    @Modifying
    @Procedure(procedureName = "deleteAccount")
    void deleteAccount(int accountId);

    @Transactional
    @Modifying
    @Procedure(procedureName = "updateAccountToMember")
    void updateAccountToMember(String email  , int accountId);


}