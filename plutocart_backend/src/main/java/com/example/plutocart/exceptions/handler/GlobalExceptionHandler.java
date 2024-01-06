package com.example.plutocart.exceptions.handler;

import com.example.plutocart.exceptions.PlutoCartServiceApiDataNotFound;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiInvalidParamException;
import com.example.plutocart.utils.GenericResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler({PlutoCartServiceApiException.class, Exception.class})
    public ResponseEntity<GenericResponse> handlerInternalSystemException(PlutoCartServiceApiException e) {
        log.error("PlutoCart ServiceApi Exception : [{}]" + e.getStatus().getRemark());
        e.printStackTrace();
        GenericResponse response = new GenericResponse();
        response.setStatus(e.getStatus());
        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(PlutoCartServiceApiDataNotFound.class)
    public ResponseEntity<GenericResponse> handlerDataNotFoundException(PlutoCartServiceApiDataNotFound e) {
        log.error("PlutoCart ServiceApi Exception : [{}]" + e.getStatus().getRemark());
        GenericResponse response = new GenericResponse();
        response.setStatus(e.getStatus());
        return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(PlutoCartServiceApiInvalidParamException.class)
    public ResponseEntity<GenericResponse> handlerInvalidParamException(PlutoCartServiceApiInvalidParamException e) {
        log.error("PlutoCart ServiceApi Exception : [{}]" + e.getStatus().getRemark());
        GenericResponse response = new GenericResponse();
        response.setStatus(e.getStatus());
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }
}
