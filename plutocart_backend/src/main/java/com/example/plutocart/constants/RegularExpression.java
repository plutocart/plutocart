package com.example.plutocart.constants;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegularExpression {
    public static final  String regxDecimalType = "-?\\d+(\\.\\d+)?";
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    private static final Pattern pattern = Pattern.compile(EMAIL_REGEX);

    public static boolean isValidEmail(String email) {
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

}
