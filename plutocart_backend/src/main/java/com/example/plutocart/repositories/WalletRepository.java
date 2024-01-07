package com.example.plutocart.repositories;

import com.example.plutocart.entities.Wallet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface WalletRepository extends JpaRepository<Wallet, Integer> {

//    Get

    @Transactional
    @Query(value = "select * from wallet where id_wallet = :walletId ", nativeQuery = true)
    Wallet viewWalletByWalletId(int walletId);

    @Transactional
    @Query(value = "select * from wallet where account_id_account = :accountId ", nativeQuery = true)
    List<Wallet> viewWalletByAccountId(int accountId);

    @Transactional
    @Query(value = "select * from wallet where account_id_account = :accountId and status_wallet = 1 limit 6 ", nativeQuery = true)
    List<Wallet> viewWalletByAccountIdStatusOn(int accountId);

    @Transactional
    @Query(value = "select  * from wallet where  account_id_account = :accountId and id_wallet = :walletId", nativeQuery = true)
    Wallet viewWalletByAccountIdAndWalletId(int accountId, int walletId);

    //    Post
    @Transactional
    @Modifying
    @Procedure(procedureName = "InsertIntoWallet")
    void insertWalletByAccountId(String walletName, BigDecimal balanceWallet, Integer accountId);

    //    Put
    @Modifying
    @Query(value = "update wallet set name_wallet = :walletName, balance_wallet = :balanceWallet ,update_wallet_on = now()" +
            " where account_id_account = :accountId and id_wallet = :walletId", nativeQuery = true)
    @Transactional
    void updateWallet(String walletName, BigDecimal balanceWallet, Integer accountId, int walletId);


    @Transactional
    @Modifying
    @Query(value = "update wallet  set status_wallet = :walletStatus where account_id_account = :accountId and id_wallet = :walletId ", nativeQuery = true)
    void updateStatusWallet(byte walletStatus, int accountId, int walletId);

    // Delete
    @Transactional
    @Modifying
    @Procedure(procedureName = "deleteWalletBYWalletId")
    void deleteWalletByAccountIdAndWalletId(int accountId, int walletId);
}
