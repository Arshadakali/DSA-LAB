/*
Write a program that allows the user to input the elements of a 3×3 matrix, ensuring only valid numeric 
inputs are accepted. After storing the values, the program should display the matrix in a well-formatted 
tabular form. Additionally, the program should calculate and display the sum of each row, each column, 
and the main diagonal to provide extra insights about the matrix.
*/
#include <iostream>
using namespace std;
int main()
{
    int matrix[3][3];
    cout << "Enter the elements of the 3x3 matrix:" << endl;
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            while (true)
            {
                cout << "Enter element at row " << i + 1 << ", column " << j + 1 << ": ";
                if (cin >> matrix[i][j])
                {
                    break;
                }
                else
                {
                    cout << "Invalid input. Please enter a valid numeric value." << endl;
                    cin.clear();
                    
                }
            }
        }
    }   
    cout << "The 3x3 matrix is:" << endl;
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            cout << matrix[i][j] << "\t";
        }
        cout << endl;
    }
    cout << "Sum of each row:" << endl;
    for (int i = 0; i < 3; i++)
    {
        int rowSum = 0;
        for (int j = 0; j < 3; j++)
        {
            rowSum += matrix[i][j];
        }
        cout << "Row " << i + 1 << ": " << rowSum << endl;
    }

    cout << "Sum of each column:" << endl;
    for (int j = 0; j < 3; j++)
    {
        int colSum = 0;
        for (int i = 0; i < 3; i++)
        {
            colSum += matrix[i][j];
        }
        cout << "Column " << j + 1 << ": " << colSum << endl;
    }
    int diagSum = 0;
    for (int i = 0; i < 3; i++)
    {
        diagSum += matrix[i][i];
    }
    cout << "Sum of the main diagonal: " << diagSum << endl;
    return 0;
}
