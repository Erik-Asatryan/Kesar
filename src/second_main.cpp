#include <iostream>
#include "../inc/second_header.hxx"

std::string coder(std::string text, std::string text1){
    for (int c = 0; c < text.size(); c++) {
        text1[c] = char(decoder(text[c]));
    }    
    return text1;
}


int main(){
    std::string text;
    std::cin >> text;
    std::string text1;
    std::string text2 = coder(text, text1);
    std::cout << text2 << std::endl;


    for (int c = 0; c < text.size(); c++) {
        std::cout << text[c] << "   " << text2[c] << std::endl;
    }
}

