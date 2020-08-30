/*
Title: Exercise09
Author: Mark Staun Poulsen
Date: 30/08 2020
*/

String[] days = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" };

void setup()
{
  size(600, 300);
  background(200, 200, 200);
  
  calculateWeekWithinMonth(); //the montly cycle consists of 4 weeks and 7 days per week
}

void calculateWeekWithinMonth()
{
  int week = 0;
  int weeksInAMonth = 3;
  while(week <= weeksInAMonth)
  {
    calculateDayWithinWeek(week);
    week++;
  }
}

void calculateDayWithinWeek(int week)
{
  int day = 0;
  while(day < days.length)
  {
    drawWeekday(week, day, 50, 60, 70);
    day++;
  }
}

void drawWeekday(int week, int day, int boxWidth, int xDistance, int yDistance)
{
  chooseColourOfText();
  text(days[day], day * xDistance, 20);  
  chooseColourOfBox(day);
  rect(day * xDistance, 30 + yDistance * week, boxWidth, boxWidth);

}

void chooseColourOfText()
{
  fill(255, 255, 255);
}

void chooseColourOfBox(int day)
{
   if (day == days.length - 1)
    {
      fill(255, 0, 0);
    } else if (day == days.length - 2) 
    {
      fill(0, 200, 200);
    } else 
    {
      fill(255, 255, 255);
    }
}
