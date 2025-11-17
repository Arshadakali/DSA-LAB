/*
Write a program that declares an array of 5 integers, takes input from the user with validation, and 
then displays the array elements in both the original order and the reverse order. The program should 
clearly label the outputs and ensure that the reverse printing does not modify the original array
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

    cout << "You entered the following integers in original order:" << endl;
    for (int i = 0; i < 5; i++)
    {
        cout << arr[i] << " ";
    }
    cout << endl;
    cout << "You entered the following integers in reverse order:" << endl;
    for (int i = 4; i >= 0; i--) 
    {
    cout << arr[i] << " ";
    }
 cout << endl;
 return 0;
}