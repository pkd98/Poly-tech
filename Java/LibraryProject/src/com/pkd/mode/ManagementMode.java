package com.pkd.mode;

import com.pkd.utils.SaveMethod;
import com.pkd.utils.SaveUtil;

public class ManagementMode {
    
    public ManagementMode(Mode mode){
        
        switch(mode) {
            case TEST_MODE:
                SaveUtil.saveMethod = SaveMethod.NO_SAVE;
                break;
                
            case START_MODE:
                SaveUtil.saveMethod = SaveMethod.YES_SAVE;
                break;
        }
    }
}
