package com.example.plutocart.exceptions;

import com.example.plutocart.constants.ErrorMessage;
import io.micrometer.common.lang.NonNull;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.*;

@RestControllerAdvice
public class GlobalExceptionHandle {

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler({MethodArgumentNotValidException.class, NumberFormatException.class})
    public Map<String, List<String>> handleInvalidArgument(MethodArgumentNotValidException methodArgumentNotValidException) {
        Map<String, List<String>> errorMap = new HashMap<>();
        methodArgumentNotValidException.getBindingResult().getFieldErrors().forEach(error -> {
            String fieldName = error.getField();
            String errorMessage = error.getDefaultMessage();
            if (!errorMap.containsKey(fieldName)) {
                errorMap.put(fieldName, new ArrayList<>());
            }
            errorMap.get(fieldName).add(errorMessage);
        });
        return errorMap;
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(NoSuchElementException.class)
    public Map<HttpStatus, Map<String, List<String>>> handleNotfound(NoSuchElementException noSuchElementException) {
        Map<String, List<String>> errorMap = new HashMap<>();
        Map<HttpStatus, Map<String, List<String>>> result = new HashMap<>();
        errorMap.put(ErrorMessage.MESSAGEERROR, new ArrayList<>());
        errorMap.get(ErrorMessage.MESSAGEERROR).add(noSuchElementException.getMessage());
        result.put(HttpStatus.NOT_FOUND, errorMap);
        return result;
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public Map<String, List<String>> handleHttpMessageNotReadableException(
            @NonNull final HttpMessageNotReadableException exception
    ) {
        Map<String, List<String>> errorMap = new HashMap<>();
        errorMap.put(ErrorMessage.MESSAGEERROR, new ArrayList<>());
        errorMap.get(ErrorMessage.MESSAGEERROR).add(exception.getMessage());
        return errorMap;
    }

}
