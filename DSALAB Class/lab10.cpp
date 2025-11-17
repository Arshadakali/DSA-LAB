/*
Write a program that allows the user to input the elements of a 3×3 matrix, validates that only numeric 
values are entered, and then checks whether the given matrix is an identity matrix. The program 
should display the matrix in a well-formatted tabular form, verify that all diagonal elements are equal 
to 1 and all non-diagonal elements are equal to 0, and finally print a clear message stating whether the 
matrix is an identity matrix or not
*/
#include <iostream>
using namespace std;

int main() 
{
    int matrix[3][3];
    bool isIdentity = true;
    cout << "Enter the elements of a 3x3 matrix (numeric values only):" << endl;
    // Input and validation
    for (int i = 0; i < 3; i++) 
    {
        for (int j = 0; j < 3; j++) 
        {
            cin >> matrix[i][j];
            if (cin.fail()) 
            {
                cin.clear();
                cout << "Invalid input. Please enter a numeric value." << endl;
                j--; 
            }
        }
    }
    // Check for identity matrix
    for (int i = 0; i < 3; i++) 
    {
        for (int j = 0; j < 3; j++) 
        {
            if ((i == j && matrix[i][j] != 1) || (i != j && matrix[i][j] != 0)) 
            {
                isIdentity = false;
                break;
            }
        }
        if (!isIdentity) 
        {
            break;
        }
    }
    // Display the matrix
    cout << "\nMatrix:" << endl;
    for (int i = 0; i < 3; i++) 
    {
        for (int j = 0; j < 3; j++) 
        {
            cout << matrix[i][j] << "\t";
        }
        cout << endl;
    }
    // Display the result
    if (isIdentity) 
    {
        cout << "The matrix is an identity matrix." << endl;
    } 
    else 
    {
        cout << "The matrix is not an identity matrix." << endl;
    }
    return 0;
}
