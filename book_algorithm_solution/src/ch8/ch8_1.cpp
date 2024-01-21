#include <vector>
#include <iostream>
using namespace std;

int main() {
    vector<int> a = {1, 2, 3, 4, 5};

    cout << a[0] << endl;
    cout << a[2] << endl;

    a[2] = 5;
    cout << a[2] << endl;
}