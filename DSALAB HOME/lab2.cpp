/*
Write a program that allows the user to input an array of 5 integers and then calculates the frequency of each 
unique number entered. The program should validate the input to ensure that only integers are accepted, traverse 
the array to count occurrences, and handle the possibility of duplicate values. Additionally, it should display the 
original array and a frequency table showing each number along with how many times it appears in the array
*/
#include <iostream>
using namespace std;
int main()
{
    int arr[5];
    int freq[5] = {0};
    bool counted[5] = {false};
    for (int i = 0; i < 5; i++)
    {
        cout << "Enter integer " << (i + 1) << ": ";
        while (!(cin >> arr[i]))
        {
            cout << "Invalid input. Please enter an integer: ";
            cin.clear();
           
        }
    }
    cout << "Original array: ";
    for (int i = 0; i < 5; i++)
    {
        cout << arr[i] << " ";
    }
    cout << endl;
    for (int i = 0; i < 5; i++)
    {
        if (!counted[i])
        {
            freq[i] = 1;
            for (int j = i + 1; j < 5; j++)
            {
                if (arr[i] == arr[j])
                {
                    freq[i]++;
                    counted[j] = true;
                }
            }
        }
    }
    cout << "Frequency table:" << endl;
    for (int i = 0; i < 5; i++)
    {
        if (!counted[i])
        {
            cout << "Number " << arr[i] << " appears " << freq[i] << " time(s)" << endl;
        }
    }
    {
        cout << "No even numbers were entered." << endl;
    }
    return 0;
}
