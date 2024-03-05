#include <iostream>

struct Emp{};

struct X 
{
	int i;
	//Emp e;
	[[no_unique_address]] Emp e;
};

int main(){
	X x;
	std::cout << sizeof(x) << std::endl;
};
