package com.example.plutocart.utils;

import com.example.plutocart.constants.ErrorMessage;
import org.modelmapper.internal.bytebuddy.implementation.bytecode.Throw;

import java.math.BigDecimal;
import java.util.NoSuchElementException;

public class HelperMethod {
    public static boolean isInteger(String str) {
        try {
            Integer.parseInt(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static int changeStringToInteger(String str) {
        return Integer.parseInt(str);
    }


    public static boolean isDecimal(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }


}
