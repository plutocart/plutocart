package com.example.plutocart.exceptions;

import com.example.plutocart.utils.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlutoCartServiceApiDataNotFound extends PlutoCartServiceApiException {
    public PlutoCartServiceApiDataNotFound(Status status) {
        super(status);
    }

    public PlutoCartServiceApiDataNotFound(Status status, String remark) {
        super(status, remark);
    }
}
