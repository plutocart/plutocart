package com.example.plutocart_api_gateway.model;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class HeaderModel {
    @Value("${HEADER_KEY}")
    public String headerKey;
    @Value("${VALUE_HEADER}")
    public String headerValue;
}
