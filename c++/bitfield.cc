#include <iostream>
using namespace std;

struct Bit {
	unsigned short a : 4;
	unsigned short b : 4;
	unsigned short c : 4;
};

int main()
{
	Bit b{1, 2, 3};
	cout << b.a << ", " << b.b << ", " << b.c << endl;
	cout << sizeof(b) << " byte" << endl;

	return 0;
}
