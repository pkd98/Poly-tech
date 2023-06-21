package com.pkd;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ContextListenerEx01 implements ServletContextListener {
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // TODO Auto-generated method stub
        ServletContextListener.super.contextDestroyed(sce);
        
        System.out.println("contextDestroyed");
    }
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // TODO Auto-generated method stub
        ServletContextListener.super.contextInitialized(sce);
        
        System.out.println("contextInitialized");
    }
}
