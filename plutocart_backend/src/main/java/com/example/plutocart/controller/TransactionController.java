package com.example.plutocart.controller;

import com.cloudinary.Cloudinary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class TransactionController {
//    @Autowired
//    Cloudinary cloudinary;


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
}
