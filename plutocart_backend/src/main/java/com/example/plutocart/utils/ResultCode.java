package com.example.plutocart.utils;

public class ResultCode {
    public static final Status SUCCESS = new Status("0", "Success.");
    public static final Status INVALID_PARAM = new Status("1001", "Invalid Param.");
    public static final Status DATA_NOT_FOUND = new Status("1002", "Data Not Found.");
    public static final Status NOT_FOUND = new Status("1003", "Not Found.");
    public static final Status USER_PERMISSION_DENIED = new Status("1004", "User Permission Denied.");
    public static final Status UPLOAD_IMAGE_ERROR = new Status("1005", "Upload Image Error.");
    public static final Status SFTP_PATH_NOT_FOUND = new Status("1005", "Sftp Path Not Found.");
    public static final Status SYSTEM_ERROR = new Status("5001", "System Error.");
    public static final Status INTERNAL_SYSTEM_ERROR = new Status("5002", "General Error.");
}
