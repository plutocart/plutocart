package com.example.plutocart.controller;

import com.example.plutocart.repositories.TransactionCategoryRepository;
import com.example.plutocart.services.CloudinaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/api")
public class CloudinaryController {
    @Autowired
    CloudinaryService cloudinaryService;
    @Autowired
    TransactionCategoryRepository transactionCategoryRepository;

    @PostMapping("/upload-image/{entity-id}")
    public String uploadImage(@RequestParam("file") MultipartFile file, @RequestParam("folderName") String folderName, @PathVariable("entity-id") int entityId) throws IOException {
//        return cloudinaryService.uploadImage(file, folderName, entityId, transactionCategoryRepository::updateTransactionCategoryImageIconUrl, transactionCategoryRepository);
        return cloudinaryService.uploadImage(file, folderName, entityId, transactionCategoryRepository::updateTransactionCategoryImageIconUrl);
    }
}
