/*
Write a program that declares an array of 5 integers, takes input from the user to fill the array, and 
then asks the user to enter a number to search. The program should perform a search operation to 
check whether the number exists in the array. If found, it should display the index (or indices, in case of 
duplicates) where the number occurs; otherwise, it should display a clear message that the number is 
not present in the array
*/
#include <iostream>
using namespace std;
int main()
{
    int arr[5];
    cout << "Enter 5 integers:" << endl;
    for (int i = 0; i < 5; i++)
    {
        while (true)
        {
            cout << "Enter integer " << i + 1 << ": ";
            if (cin >> arr[i])
            {
                break; 
            }
            else
            {
                cout << "Invalid input. Please enter an integer." << endl;
                cin.clear(); // Clear the error flag
                
            }
        }
    }

    int searchNum;
    cout << "Enter a number to search: ";
    while (true)
    {
        if (cin >> searchNum)
        {
            break; 
        }
        else
        {
            cout << "Invalid input. Please enter an integer." << endl;
            cin.clear(); // Clear the error flag
            
        }
    }
    bool found = false;
    cout << "Searching for " << searchNum << " in the array..." << endl;
    for (int i = 0; i < 5; i++)
    {
        if (arr[i] == searchNum)
        {
            cout << "Number found at index: " << i << endl;
            found = true;
        }
    }
    if (!found)
    {
        cout << "Number " << searchNum << " is not present in the array." << endl;
    }
    return 0;

}