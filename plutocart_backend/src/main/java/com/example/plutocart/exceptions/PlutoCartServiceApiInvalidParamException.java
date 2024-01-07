package com.example.plutocart.exceptions;

import com.example.plutocart.utils.Status;

public class PlutoCartServiceApiInvalidParamException extends PlutoCartServiceApiException {
    public PlutoCartServiceApiInvalidParamException(Status status) {
        super(status);
    }

    public PlutoCartServiceApiInvalidParamException(Status status, String remark) {
        super(status, remark);
    }
}

