#include<iostream>
using namespace std;
int main()
{
/* a  97  0x61   1 0x01
 b  98  0x62   2 0x02
 c  98  0x62   3 0x03
 d  98  0x62   4 0x04
 e  98  0x62   5 0x05
 f  98  0x62   6 0x06
 g  98  0x62   7 0x07
 h  98  0x62   8 0x08
 i  98  0x62   9 0x09
 j  98  0x62  10 0x0a
 k  98  0x62  11 0x0b
 l  98  0x62  12 0x0c
 m  98  0x62  13 0x0d
 n  98  0x62  14 0x0e 01110

 o  98  0x62  15 0x0f
 p  98  0x62  16 0x10
 q  98  0x62  17 0x11 r  98  0x62  18 0x12
 s  98  0x62  19 0x13
 t  98  0x62  20 0x14
 u  98  0x62  21 0x15
 v  98  0x62  22 0x16
 w  98  0x62  23 0x17
 x  98  0x62  24 0x18
 y  98  0x62  25 0x19
 z 122  0x72  26 0x1A(5bit)
*/

	//      b     e     l     e     v     e
	//      2     5     c     5    16     5
	//  00010 00101 01100 00101 10110 00101 
    //
	//  00101 10110 00101 01100 00101 00010 
	//  001011011000101011000010100010 = 191017122

    //      i     n
    //      9     e
    //  01001 01110
	// 
	//  01110 01001 
	//  0111001001 = 457

    //      y     o     u     r     s     e     l     f
	//     19     f    15    12    13     5     c     6
	//  11001 01111 10101 10010 10011 10101 01100 00110
    //
	//  00110 01100 10101 10011 10010 10101 01111 11001 
	//  0011001100101011001110010101010111111001  = 0x332B3955F9

    //      s     a     k     a     i
    //     13     1     b     1     9
    //  10011 00001 01011 00001 01001
    //
    //  01001 00001 01011 00001 10011
    //  0100100001010110000110011 = 0x90AC33

    //      s     a     n
    //     13     1     e   
    //  10011 00001 01110
    //
    //  01110 00001 10011 
    //  011100000110011  = 0x3833

	auto f=[](unsigned long c){string s;while(c>0){s+=(96+(c&31));c>>=5;}return s+" ";};	
	cout<<f(191017122)+f(457)+f(219768509945)+f(9481267)+f(14387)<<endl;

	//auto g = [](auto self, long long c){return (c>0)? string(1,96+(c&31))+self(self, c>>5) : "";};
	//auto g = [](auto self, long long c){return (string(1,96+(c&31)) + self(self, c>>5)); };
	//auto g=[](auto t,unsigned long c)->string{string s(1,96+(c&31));return(c>0?(s+t(t,c>>5)):" ");};
	auto g=[](auto t,unsigned long c)->string{return(c>0?((96+(char)(c&31))+t(t,c>>5)):" ");};
	//auto g = [](auto self, unsigned long long c) -> string{string s = (c>0? {(96+(c&31)), self(self, c>>5)}: " "); return s; };
	cout<<g(g,191017122)+g(g,457)+g(g,219768509945)+g(g,9481267)+g(g,14387)<<endl;

	//auto h=[](string a){string s;for(auto c:stoll(a.split(){while(c>0){s+=(96+(c&31));c>>=5;}s+=" ";}return s;};	
	//cout<<h("191017122 457 219768509945 9481267 14387")<<endl;
}
