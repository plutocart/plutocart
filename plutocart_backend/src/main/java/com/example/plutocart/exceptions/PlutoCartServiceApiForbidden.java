package com.example.plutocart.exceptions;

import com.example.plutocart.utils.Status;

public class PlutoCartServiceApiForbidden extends PlutoCartServiceApiException {
    public PlutoCartServiceApiForbidden(Status status) {
        super(status);
    }

    public PlutoCartServiceApiForbidden(Status status, String remark) {
        super(status, remark);
    }
}
