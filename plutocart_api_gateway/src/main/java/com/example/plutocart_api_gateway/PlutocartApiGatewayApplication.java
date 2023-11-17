package com.example.plutocart_api_gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class PlutocartApiGatewayApplication {

	public static void main(String[] args) {

		 new SpringApplicationBuilder(PlutocartApiGatewayApplication.class)
				 .web(WebApplicationType.NONE)
				 .run(args);
	}
}
