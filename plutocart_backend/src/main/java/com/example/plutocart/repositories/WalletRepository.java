package com.example.plutocart.repositories;
import com.example.plutocart.entities.Account;
import com.example.plutocart.entities.Wallet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface WalletRepository extends JpaRepository<Wallet, Integer> {

//    Get

    @Transactional
    @Query(value = "select * from wallet where account_id_account = :id_account " , nativeQuery = true)
    List<Wallet> viewWalletByAccountId(int id_account);

    @Transactional
    @Query(value = "select  * from wallet where  account_id_account = :id_account and id_wallet = :id_wallet" , nativeQuery = true)
    Wallet viewWalletByAccountIdAndWalletId(int id_account , int id_wallet);

//    Post
    @Transactional
    @Modifying
    @Query(value = "insert into  wallet (name_wallet , balance_wallet , account_id_account , create_wallet_on , update_wallet_on)" +
            " values(:name_wallet , :balance_wallet , :account_id_account , :create_wallet_on , :update_wallet_on)" , nativeQuery = true)
    void insertWalletByAccountID(String name_wallet , BigDecimal balance_wallet  , Integer account_id_account , LocalDateTime create_wallet_on , LocalDateTime update_wallet_on);

//    Put

    @Modifying
    @Query(value = "update wallet set name_wallet = :name_wallet, update_wallet_on = now() where account_id_account = :account_id and id_wallet = :id_wallet", nativeQuery = true)
    @Transactional
    void updateNameWallet( String name_wallet, Integer account_id,  int id_wallet);


    @Transactional
    @Modifying
    @Query(value = "update wallet  set status_wallet = :status_wallet where account_id_account = :account_id and id_wallet = :id_wallet " , nativeQuery = true)
    void updateStatusWallet(byte status_wallet , int account_id ,int id_wallet);

 // Delete

    @Transactional
    @Modifying
    @Query(value = "delete from wallet where id_wallet = :id_wallet and account_id_account = :account_id" , nativeQuery = true)
    void deleteWalletByAccountIdAndWalletId(int account_id ,int id_wallet);
}
