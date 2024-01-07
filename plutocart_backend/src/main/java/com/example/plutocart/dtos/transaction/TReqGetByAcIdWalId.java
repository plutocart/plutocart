package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TReqGetByAcIdWalId {
    Integer accountId;
    Integer walletId;
}
