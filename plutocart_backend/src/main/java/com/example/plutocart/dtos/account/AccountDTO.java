package com.example.plutocart.dtos.account;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountDTO {
    private int accountId;
    private String imei;
    private String email;
    private String accountRole;

}
