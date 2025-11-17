//Write a program that allows the user to input an array of 5 integers and then finds and displays the largest number in the array. The program should validate the input to ensure that only integers are accepted, traverse the array to compare all elements, and handle the possibility of duplicate maximum values. Additionally, it should display the original array, the largest number found, and its position(s) in the array, providing a clear explanation of how the largest value was determined
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
    int largest = arr[0];
    for (int i = 1; i < 5; i++)
    {
        if (arr[i] > largest)
        {
            largest = arr[i];
        }
    }
    cout << "You entered the following integers:" << endl;
    for (int i = 0; i < 5; i++)
    {
        cout << arr[i] << " ";
    }
    cout << endl;
    cout << "The largest number is: " << largest << endl;
    cout << "Position(s) of the largest number in the array: ";
    for (int i = 0; i < 5; i++)
    {
        if (arr[i] == largest)
        {
            cout << i << " "; 
        }
    }
    cout << endl;
    return 0;
}