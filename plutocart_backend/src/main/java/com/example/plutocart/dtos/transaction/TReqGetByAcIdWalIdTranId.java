package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TReqGetByAcIdWalIdTranId {
    Integer accountId;
    Integer walletId;
    Integer transactionId;
}
