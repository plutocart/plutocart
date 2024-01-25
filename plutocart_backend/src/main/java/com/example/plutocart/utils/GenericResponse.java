package com.example.plutocart.utils;

import lombok.Getter;
import lombok.Setter;
import org.springframework.lang.Nullable;

@Getter
@Setter
public class GenericResponse {
    private Status status;
    private Object data;
//    @Nullable
    private Object authentication;
}
