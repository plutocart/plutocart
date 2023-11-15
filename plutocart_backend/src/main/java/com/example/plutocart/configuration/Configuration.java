package com.example.plutocart.configuration;

import com.example.plutocart.constant.Message;
import com.example.plutocart.constant.Response;
import com.example.plutocart.constant.Status;
import com.example.plutocart.dtos.WalletDto;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;

@org.springframework.context.annotation.Configuration
public class Configuration {

    @Bean
    public ModelMapper modelMapper(){
        return new ModelMapper();
    }

    @Bean
    public WalletDto walletDto(){ return new WalletDto();}

    @Bean
    public Response response(){return  new Response();}
    @Bean
    public Status status(){return  new Status();}

    @Bean
    public Message message(){return  new Message();};
}
