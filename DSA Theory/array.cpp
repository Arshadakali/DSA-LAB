//Write a program that prompts the user for two matrices of order 2 x 3 of integers, multiplies them and displays the result in matrix form. Give the source code and the runtime screen
#include <iostream>
using namespace std;

class Matrix {
    int arr[2][3];
public:
    void getdata() {
        cout << "Enter elements of matrix (2x3):" << endl;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 3; j++) {
                cin >> arr[i][j];
            }
        }
    }

    void display() {
        cout << "Matrix:" << endl;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 3; j++) {
                cout << arr[i][j] << " ";
            }
            cout << endl;
        }
    }

    Matrix operator*(const Matrix& m) {
        Matrix result;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 3; j++) {
                result.arr[i][j] = arr[i][j] * m.arr[i][j];
            }
        }
        return result;
    }
};
int main() {
    Matrix m1, m2, m3;

    cout << "Matrix 1:" << endl;
    m1.getdata();
    cout << "Matrix 2:" << endl;
    m2.getdata();

    m3 = m1 * m2;

    cout << "Resultant Matrix after multiplication:" << endl;
    m3.display();

    return 0;
}