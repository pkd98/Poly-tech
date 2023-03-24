package com.pkd.mode;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;

public class SaveManager<T> {
    public static SaveMode saveMode;

    public SaveManager(SaveMode saveMode) {
        this.saveMode = saveMode;
    }

//    public void saveFactory() {
//
//        switch (saveMode) {
//            case NO_SAVE:
//                break;
//            case YES_SAVE:
//                break;
//
//            default:
//                break;
//        }
//    }
}
