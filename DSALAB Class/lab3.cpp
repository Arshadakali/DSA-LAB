
/*
Write a program that declares an array of 5 integers, takes input values from the user with proper 
validation, and then determines and displays the largest number in the array along with its position 
(index). Additionally, handle cases where multiple elements share the same maximum value by 
displaying all their positions
*/
#include <iostream>
using namespace std;
int main ()
{
    int arr[5];
    int sum = 0;
    cout << "Enter 5 integers:" << endl;
    for (int i = 0; i < 5; i++)
    {
        while (true)
        {
            cout << "Enter integer " << i + 1 << ": ";
            if (cin >> arr[i])
            {
                break; // Valid input, exit the loop
            }
            else
            {
                cout << "Invalid input. Please enter an integer." << endl;
                cin.clear(); 
                
            }
        }
 sum += arr[i];
    }
 double avg = sum / 5.0;

    cout << "You entered the following integers:" << endl;
    for (int i = 0; i < 5; i++)
    {
        cout << arr[i] << " ";
    }
    cout << endl;

    cout << "Sum = " << sum << endl;
 cout << "Average = " << avg << endl;

 
    return 0;
}
