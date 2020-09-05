/*
Title: Exercise19
Author: Mark Staun Poulsen
Date: 05/09 2020
*/

String sourceMessage = "ABC HELLO TEST ONE TWO ONE TWO IS THIS ON";
String translatedMessage = "";

char alphabet[] = {' ','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
String[] morseCode = {" ", ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."};

for(int i = 0; i < sourceMessage.length(); i++)
{
  for(int j = 0; j < alphabet.length; j++)
  {
    if(sourceMessage.charAt(i) == alphabet[j])
    {
      translatedMessage = translatedMessage + morseCode[j];
    }
  }
}

println(translatedMessage);
