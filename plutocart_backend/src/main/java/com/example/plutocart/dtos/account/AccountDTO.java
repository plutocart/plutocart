package com.example.plutocart.dtos.account;

import jakarta.validation.constraints.Email;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountDTO {
    private int accountId;
    private String imei;
    @Email
    private String email;
    private String accountRole;

}
