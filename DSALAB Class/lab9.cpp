/*
Write a program that prompts the user to input the elements of a 3×3 square matrix, validates the 
input to ensure only numeric values are entered, and then calculates the sum of both the main 
diagonal (top-left to bottom-right) and the secondary diagonal (top-right to bottom-left). The 
program should display the matrix in a properly formatted tabular structure, show the computed 
sums of each diagonal separately, and also display their combined total for better analysis.
*/
#include <iostream>
using namespace std;

int main() {
    const int SIZE = 3;
    int matrix[SIZE][SIZE];
    int mainDiagonalSum = 0;
    int secondaryDiagonalSum = 0;

    // Input and validation
    cout << "Enter the elements of a 3x3 matrix (numeric values only):" << endl;
    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            while (true) {
                cout << "Element [" << i + 1 << "][" << j + 1 << "]: ";
                cin >> matrix[i][j];
                if (cin.fail()) {
                    cin.clear(); // clear the fail state
                    
                    cout << "Invalid input. Please enter a numeric value." << endl;
                } else {
                    break; // valid input
                }
            }
        }
    }

    // Calculate diagonal sums
    for (int i = 0; i < SIZE; ++i) {
        mainDiagonalSum += matrix[i][i];
        secondaryDiagonalSum += matrix[i][SIZE - 1 - i];
    }
    int totalDiagonalSum = mainDiagonalSum + secondaryDiagonalSum;

    // Display the matrix and diagonal sums
    cout << "\nMatrix:" << endl;
    cout << "-----------------------" << endl;
    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            cout << matrix[i][j] << "\t";
        }
        cout << endl;
    }
    cout << "-----------------------" << endl;
    cout << "Main Diagonal Sum: " << mainDiagonalSum << endl;
    cout << "Secondary Diagonal Sum: " << secondaryDiagonalSum << endl;
    cout << "Total Diagonal Sum: " << totalDiagonalSum << endl;

    return 0;
}