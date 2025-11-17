/*
Write a program that allows the user to input the elements of a 3×3 matrix, validates that only numeric values are entered, 
and then checks whether the given matrix is an identity matrix. The program should display the matrix in a well-formatted 
tabular form, verify that all diagonal elements are equal to 1 and all non-diagonal elements are equal to 0, and finally 
print a clear message stating whether the matrix is an identity matrix or not
*/

#include <iostream>
using namespace std;

int main() {
    const int SIZE = 3;
    double matrix[SIZE][SIZE];
    bool isIdentity = true;
    // Input with validation
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            cout << "Enter element [" << i + 1 << "][" << j + 1 << "]: ";
            while (!(cin >> matrix[i][j])) {
                cout << "Invalid input. Please enter a numeric value: ";
                cin.clear();
                
            }
        }
    }
    // Check for identity matrix
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            if ((i == j && matrix[i][j]!= 1) || (i!= j && matrix[i][j]!= 0)) {
                isIdentity = false;
                break;
            }
        }
    }
    // Display the matrix
    cout << "\nMatrix:\n";
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            cout << matrix[i][j] << "\t";
        }
        cout << endl;
    }
    cout << (isIdentity? "The matrix is an identity matrix." : "The matrix is not an identity matrix.") << endl;
    return 0;
}
