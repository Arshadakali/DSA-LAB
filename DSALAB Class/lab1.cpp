///Write a program that declares an array of 5 integers, takes input from the user with validation to ensure only integers are entered, stores them in the array, and then prints all the numbers along with their positions (index values). Additionally, the program should also display the sum and average of the entered numbers for better analysis
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
                break; // Valid input, exit the loop
            }
            else
            {
                cout << "Invalid input. Please enter an integer." << endl;
                cin.clear(); // Clear the error flag
                
            }
        }
    }
cout << "You entered the following integers:" << endl;
    for (int i = 0; i < 5; i++) {
       cout << arr[i] << " ";
 }
 cout << endl;
 return 0;
}