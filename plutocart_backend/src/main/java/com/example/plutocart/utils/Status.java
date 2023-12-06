package com.example.plutocart.utils;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Status {
    private String code;
    private String message;
    private String remark;

    public Status(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public Status(String code, String message, String remark) {
        this.code = code;
        this.message = message;
        this.remark = remark;
    }
}
