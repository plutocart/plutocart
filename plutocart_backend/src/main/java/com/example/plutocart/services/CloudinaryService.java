package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.example.plutocart.entities.Transaction;
import com.example.plutocart.entities.TransactionCategory;
import com.example.plutocart.repositories.TransactionCategoryRepository;
import com.example.plutocart.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Arrays;
import java.util.Map;
import java.util.UUID;
import java.util.function.BiConsumer;

@Service
public class CloudinaryService {
    @Autowired
    Cloudinary cloudinary;
    @Autowired
    TransactionCategoryRepository transactionCategoryRepository;
    @Autowired
    TransactionRepository transactionRepository;

    public <T> String uploadImage(
            MultipartFile file,
            String folderName,
            int entityId,
            BiConsumer<String, Integer> updateEntityImage
    ) throws IOException {
        // Generate a random UUID to use as part of the image name
        String randomString = UUID.randomUUID().toString();

        // Extract the original filename
        String originalFilename = file.getOriginalFilename();

        // Strip the file extension from the original filename
        String imageName = StringUtils.stripFilenameExtension(originalFilename);

        // Include the folder name, entity ID, and random string as part of the 'public_id'
        String publicId = folderName + "/" + imageName + "_" + randomString;

        // You can include additional parameters if needed
        Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap("public_id", publicId));
        String imageUrl = (String) uploadResult.get("secure_url");

        // Call the provided BiConsumer to update the entity image URL
        updateEntityImage.accept(imageUrl, entityId);

        return imageUrl;
    }

    public <T> String uploadImageInTransaction(
            MultipartFile file
//            int entityId,
//            BiConsumer<String, Integer> updateEntityImage
    ) throws IOException {
        // Extract the original filename
        String originalFilename = file.getOriginalFilename();
        String imageUrl;
        if (originalFilename.isEmpty()) {
            imageUrl = null;
        } else {
            String randomString = UUID.randomUUID().toString();
            String imageName = StringUtils.stripFilenameExtension(originalFilename);
            String publicId = "transaction/" + imageName + "_" + randomString;
            Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap("public_id", publicId));
            imageUrl = (String) uploadResult.get("secure_url");
            // Call the provided BiConsumer to update the entity image URL
//            updateEntityImage.accept(imageUrl, entityId);
        }

        System.out.println("Image URL length: " + imageUrl.length());

        return imageUrl;
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteImageOnCloudInTransaction(Integer transactionId) throws Exception {
        // Retrieve the entity from the database
        Transaction transaction = transactionRepository.findById(transactionId).orElse(null);

        if (transaction != null && transaction.getImageUrl() != null) {
            String publicId = getPublicIdFromUrl(transaction.getImageUrl());
            cloudinary.api().deleteResources(Arrays.asList(publicId), ObjectUtils.emptyMap());
//            transactionCategoryRepository.updateTransactionCategoryImageIconUrl("", transactionId);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteImageAndUpdateDatabaseTranCat(int transactionCategoryId) throws Exception {
        // Retrieve the entity from the database
        TransactionCategory transactionCategory = transactionCategoryRepository.findById(transactionCategoryId).orElse(null);

        if (transactionCategory != null && transactionCategory.getImageIconUrl() != null) {
            // Extract publicId from the Cloudinary URL
            String publicId = getPublicIdFromUrl(transactionCategory.getImageIconUrl());

            // Log relevant information
            System.out.println("Cloudinary URL: " + transactionCategory.getImageIconUrl());
            System.out.println("Public ID: " + publicId);

            // Delete image in Cloudinary
            Map deletionResult = cloudinary.api().deleteResources(Arrays.asList(publicId), ObjectUtils.emptyMap());

            // Log deletion result
            System.out.println("Deletion Result: " + deletionResult);

            // Check if deletion was successful
            // Reset image URL in the database
            transactionCategoryRepository.updateTransactionCategoryImageIconUrl("", transactionCategoryId);
        }
    }

    public static String getPublicIdFromUrl(String imageUrl) {
        // Extract the folder name and file name (including extension)
        String folderAndFileName = imageUrl.substring(imageUrl.indexOf("upload/") + "upload/".length());

        // Split the folder and file
        String[] folderAndFileParts = folderAndFileName.split("/", 3);

        String version = folderAndFileParts.length > 0 ? folderAndFileParts[0] : "";
        String folderName = folderAndFileParts.length > 1 ? folderAndFileParts[1] : "";
        String fullFileName = folderAndFileParts.length > 2 ? folderAndFileParts[2] : folderAndFileParts[0];

        // Remove the file extension from the full file name
        String fileName = fullFileName.contains(".") ? fullFileName.substring(0, fullFileName.lastIndexOf(".")) : fullFileName;

        // If there is a folder name and it starts with "v" followed by digits, remove the version prefix
//        if (!version.isEmpty() && version.matches("^v\\d+.*")) {
//            folderName = version + "/" + folderName;
//        }

        // Concatenate folder name and file name
        return folderName + "/" + fileName;
    }

}
