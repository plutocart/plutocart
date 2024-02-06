package com.example.plutocart_api_gateway;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class PlutocartApiGatewayApplication {

	@Bean
	public Dotenv dotenv() {
		return Dotenv.configure().load();
	}

	public static void main(String[] args) {
		SpringApplication.run(PlutocartApiGatewayApplication.class, args);
	}



}
