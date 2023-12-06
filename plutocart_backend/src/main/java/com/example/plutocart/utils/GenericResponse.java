package com.example.plutocart.utils;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GenericResponse {
    private Status status;
    private Object data;
}
