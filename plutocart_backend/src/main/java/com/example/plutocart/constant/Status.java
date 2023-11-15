package com.example.plutocart.constant;


import lombok.Data;

@Data
public class Status {
    public final String  CREATE = "CREATE";
    public static final String SUCCESS = "SUCCESS";
    public final String  NOTFOUND = "NOTFOUND";
    public final String  BADREQUEST = "BADREQUEST";
}
