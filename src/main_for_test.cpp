//#include "../inc/unit_test.hxx"
//#include "../inc/header.hxx"
//#include "../inc/second_header.hxx"
#include <iostream>

int encoder(int symbol){
       symbol+=3;
       return symbol;
   }

int decoder(int symbol){
	symbol-=3;
    return symbol;
  }

std::string unit_test_decoder(std::string text, std::string text1) {
	for (int c = 0; c < text.size(); c++) {
    	text1[c] = char(encoder(text[c]));
    }
	return text1;
}
std::string unit_test_encoder(std::string sec_text, std::string text1, text2) {
	for (int c = 0; c < sec_text.size(); c++) {
    	text1[c] = char(decoder(text2[c]));
    }
    return text1;
}

int main(){
	std::cout << "Enter first text for test: ";
    std::string text;
    std::cout << "Enter second text for test: ";
    std::string sec_text;

	std::cin >> text;
    std::string text1;
    std::string text2 = unit_test_decoder(text, text1);
	std::string text3 = unit_test_encoder(second_text, text2);
    for (int c = 0; c < text.size(); c++) {
          std::cout << text[c] << "   " << text2[c] << std::endl;
		  if(text2[c] = text3[c]) {
				std::cout << "PASS" << std::endl;
		  }else{
				std::cout << "Error" << std::endl;
				}
    }
	std::cout << std::endl;
    for (int c = 0; c < text.size(); c++) {
           std::cout << text2[c] << "   " << text3[c] << std::endl;  
   	}

  }
