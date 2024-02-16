package com.example.plutocart.configuration;

import com.example.plutocart.dtos.wallet.WalletDTO;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;

@org.springframework.context.annotation.Configuration
public class Configuration {

    @Bean
    public ModelMapper modelMapper(){
        return new ModelMapper();
    }

    @Bean
    public WalletDTO walletDto(){ return new WalletDTO();}

}
