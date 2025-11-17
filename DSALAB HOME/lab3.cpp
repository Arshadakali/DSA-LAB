/*
Write a program that declares an array of 5 integers, takes input values from the user with proper validation, and then 
determines and displays the largest number in the array along with its position (index). Additionally, handle cases 
where multiple elements share the same maximum value by displaying all their positions
*/
#include <iostream>
using namespace std;
int main()
{
    int arr[5];
    int max, maxIndex;
    bool first = true;
    // Input with validation
    for (int i = 0; i < 5; i++)
    {
        cout << "Enter integer " << (i + 1) << ": ";
        while (!(cin >> arr[i]))
        {
            cout << "Invalid input. Please enter an integer: ";
            cin.clear();
            
        }
    }
    // Find max and its positions
    for (int i = 0; i < 5; i++)
    {
        if (first || arr[i] > max)
        {
            max = arr[i];
            maxIndex = i;
            first = false;
        }
    }
    // Display results
    cout << "Maximum number is " << max << " at index/indices: ";
    for (int i = 0; i < 5; i++)
    {
        if (arr[i] == max)
        {
            cout << i << " ";
        }
    }
    cout << endl;
    return 0;
}
