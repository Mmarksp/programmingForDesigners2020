/*
Title: exercise24
Author: Mark Staun Poulsen
Date: 13/08 2020
*/

import java.util.Date; //in order to getDay()
String weekDays[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};

void setup()
{
  whatIsDayAndTime();
}

void whatIsDayAndTime()
{
  int hour = hour();
  int minute = minute();
  
  if(hour > 2 && hour < 9)
  {
    println("Time is only "+hour+":"+minute+"h, and too early to find out what day it is");
  } else 
  {
    int day = day();
    int month = month();
    int indicatorForDayOfWeek = new Date().getDay();
    
    println("Today is "+weekDays[indicatorForDayOfWeek]+" the "+day+"/"+month+", and the time is "+hour+":"+minute+"h."); //to-do add conditional for one string minute
  }
  
}
