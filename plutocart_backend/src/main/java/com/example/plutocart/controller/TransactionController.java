package com.example.plutocart.controller;

import com.example.plutocart.dtos.wallet.WalletPostDTO;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.entities.Wallet;
import com.example.plutocart.services.TransactionService;
import com.example.plutocart.utils.GenericResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/api")
public class TransactionController {
    //    @Autowired
    //    Cloudinary cloudinary;
    @Autowired
    TransactionService transactionService;


//    @PostMapping("/test")
//    private void postImage(@Validated MultipartFile file) throws IOException {
//        Map<String, Object> uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
//        imageRepository.insertImage(uploadResult.get("secure_url").toString() , "KIM");
////            imageRepository.insertImage("KIMMIETEST", "KIM");
//        System.out.println("HELLO");
//
//    }
//
//    @GetMapping("/{id}")
//    private String getImageById(@Validated @PathVariable int id)  {
//        return  cloudinary.url()
//                .transformation(new Transformation()).generate(imageRepository.getImageById(id));
//    }

    @GetMapping("/account/{account-id}/transaction")
    private ResponseEntity<?> getTransactions(@Valid @PathVariable("account-id") String accountId) {
        try {
            int acId = Integer.parseInt(accountId);
            Object result = transactionService.getTransactionByAccountId(acId);
            return ResponseEntity.status(HttpStatus.OK).body(result);
        } catch (Exception e) {
            throw new NoSuchElementException(e.getMessage());
        }
    }

//    @PostMapping("/account/{account-id}/transaction")
//    private ResponseEntity<?> createTransactions(@Valid @PathVariable("account-id") String accountId) {
//        try {
//            int acId = Integer.parseInt(accountId);
//            Object result = transactionService.getTransactionByAccountId(acId);
//            return ResponseEntity.status(HttpStatus.OK).body(result);
//        } catch (Exception e) {
//            throw new NoSuchElementException(e.getMessage());
//        }
//    }

    @PostMapping("/wallet/{wallet-id}/transaction")
    private ResponseEntity<GenericResponse> createTransactions(@Valid @RequestBody Transaction transaction, @PathVariable("wallet-id") Integer walletId) {
        try {
            GenericResponse result = transactionService.createTransaction(transaction, walletId);
            return ResponseEntity.status(HttpStatus.CREATED).body(result);
//            return transactionService.createTransaction(transaction, walletId);
        }
        catch (Exception e){
            throw new NoSuchElementException(e.getMessage());
        }

    }


}
