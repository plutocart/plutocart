package com.example.plutocart.exceptions;

import com.example.plutocart.utils.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlutoCartServiceApiException extends Exception {
    private Status status;

    public PlutoCartServiceApiException(Status status) {
        this.status = status;
    }

    public PlutoCartServiceApiException(Status status, String remark) {
//        super(remark);
        status.setRemark(remark);
        this.status = status;
    }

}
