#include <iostream>
#include <vector>

using namespace std;

int main()
{
	vector<int> v {1,2,3,4,5,6,7,8,9,10};
	int index = 0;

	cout << v[0] << endl;
	cout << v[(++index, 0)] << endl;
	cout << v[(++index, 0)] << endl;
	cout << v[(++index, 1)] << endl;

	return 0;
}

	
