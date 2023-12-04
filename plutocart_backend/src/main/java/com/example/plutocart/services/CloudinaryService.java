package com.example.plutocart.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.example.plutocart.repositories.TransactionCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;
import java.util.function.BiConsumer;

@Service
public class CloudinaryService {
    @Autowired
    Cloudinary cloudinary;
    @Autowired
    TransactionCategoryRepository transactionCategoryRepository;

//    public String uploadImage(MultipartFile file, String folderName, int transactionCategoryId) throws IOException {
//        // Extract the original filename
//        String imageName = file.getOriginalFilename();
//
//        // Include the folder name as part of the 'public_id'
//        String publicId = folderName + "/" + imageName;
//
//        // You can include additional parameters if needed
//        Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap("public_id", publicId));
//        String imageUrl = (String) uploadResult.get("secure_url");
//
//        transactionCategoryRepository.updateTransactionCategoryImageIconUrl(imageUrl, transactionCategoryId);
//        return imageUrl;
//    }

    public <T> String uploadImage(
            MultipartFile file,
            String folderName,
            int entityId,
            BiConsumer<String, Integer> updateEntityImage
//            , T repository
    ) throws IOException {
        // Extract the original filename
        String originalFilename = file.getOriginalFilename();

        // Strip the file extension from the original filename
        String imageName = StringUtils.stripFilenameExtension(originalFilename);

        // Include the folder name and entity ID as part of the 'public_id'
        String publicId = folderName + "/" + imageName;

        // You can include additional parameters if needed
        Map uploadResult = cloudinary.uploader().upload(file.getBytes(), ObjectUtils.asMap("public_id", publicId));
        String imageUrl = (String) uploadResult.get("secure_url");

        // Call the provided BiConsumer to update the entity image URL
        updateEntityImage.accept(imageUrl, entityId);

        return imageUrl;
    }

}
