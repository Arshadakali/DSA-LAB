/*
Write a program that allows the user to input the elements of a 3×3 matrix, validates the input to ensure only numeric 
values are entered, and then calculates the sum of all the elements in the matrix. The program should also display the 
matrix in a well-formatted tabular structure along with the computed total sum, and additionally highlight the sums 
of each row and each column separately for better analysis.
*/
#include <iostream>
using namespace std;

int main() {
    const int SIZE = 3;
    double matrix[SIZE][SIZE];
    double rowSums[SIZE] = {0};
    double colSums[SIZE] = {0};
    double totalSum = 0;

    // Input with validation
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            cout << "Enter element [" << i + 1 << "][" << j + 1 << "]: ";
            while (!(cin >> matrix[i][j])) {
                cout << "Invalid input. Please enter a numeric value: ";
                cin.clear();
                
            }
            rowSums[i] += matrix[i][j];
            colSums[j] += matrix[i][j];
            totalSum += matrix[i][j];
        }
    }

    // Display the matrix
    cout << "\nMatrix:\n";
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            cout << matrix[i][j] << "\t";
        }
        cout << "| Row Sum: " << rowSums[i] << endl;
    }

    // Display column sums
    cout << "-------------------------\n";
    for (int j = 0; j < SIZE; j++) {
        cout << colSums[j] << "\t";
    }
    cout << "| Column Sums\n";

    // Display total sum
    cout << "\nTotal Sum of all elements: " << totalSum << endl;

    return 0;
}
