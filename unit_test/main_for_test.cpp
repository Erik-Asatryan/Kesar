#include "../inc/unit_test.hxx"
#include "../inc/header.hxx"
#include "../inc/second_header.hxx"
#include <iostream>


std::string unit_test(std::string text, int number, std::string text1, std::string text2) {

	while (text != "break"){
		  	for (int c = 0; c < text.size(); c++) {
         		text1[c] = char(encoder(text[c]));
				text2[c] = char(decoder(text1[c]));
      		}

	}

	if (text1 == text2) {
		return "PASS";
	}
return text;
}
