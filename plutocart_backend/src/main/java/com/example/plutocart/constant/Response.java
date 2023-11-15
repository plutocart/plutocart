package com.example.plutocart.constant;


import lombok.Builder;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;

@Data
@Builder
public class Response {
    @Autowired
    Message  message;
    @Autowired
    Status status;
}
