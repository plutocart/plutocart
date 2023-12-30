package com.example.plutocart.services;

import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.entities.TransactionCategory;
import com.example.plutocart.repositories.TransactionCategoryRepository;
import com.example.plutocart.utils.GenericResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionCategoryService {

    @Autowired
    ModelMapper modelMapper;
    @Autowired
    TransactionCategoryRepository transactionCategoryRepository;

    public GenericResponse getAllTransactionCategoryType(Integer tranCaType) {
        GenericResponse response = new GenericResponse();
        try {
            List<TransactionCategory> transactionCategoryList = transactionCategoryRepository.getAllTransactionCategory(tranCaType);
            response.setStatus(ResultCode.SUCCESS);
            response.setData(transactionCategoryList);
            return response;
        } catch (Exception ex) {
            response.setStatus(ResultCode.NOT_FOUND);
            response.setData(null);
            return response;
        }
    }
}
