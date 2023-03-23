package com.pkd.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Utils {

    public static Date stringToDate(String dateName) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
        Date releaseDate = null;
        try {
            releaseDate = format.parse(dateName);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return releaseDate;
    }
    
    public static String dateToString(Date date) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
        String answerDate = format.format(date);
        return answerDate;
    }
    
    
    
}
