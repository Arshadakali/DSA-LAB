/*
Write a program that takes user input to fill a 3×3 matrix with numeric values, validates the input, and 
then calculates the sum of each row. The program should display the matrix in a well-formatted tabular 
layout and print the sum of each row alongside it, clearly labeling which sum belongs to which row. 
Additionally, the program should also compute and display the overall total of all elements for extra 
insight.
*/
#include <iostream>
using namespace std;

int main() {
    const int SIZE = 3;
    int matrix[SIZE][SIZE];
    int rowSums[SIZE] = {0};
    int totalSum = 0;

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

    // Calculate row sums and total sum
    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            rowSums[i] += matrix[i][j];
            totalSum += matrix[i][j];
        }
    }

    // Display the matrix and row sums
    cout << "\nMatrix with Row Sums:" << endl;
    cout << "-----------------------" << endl;
    for (int i = 0; i < SIZE; ++i) {
        for (int j = 0; j < SIZE; ++j) {
            cout << matrix[i][j] << "\t";
        }
        cout << "| Sum: " << rowSums[i] << endl;
    }
    cout << "-----------------------" << endl;
    cout << "Total Sum of all elements: " << totalSum << endl;

    return 0;
}