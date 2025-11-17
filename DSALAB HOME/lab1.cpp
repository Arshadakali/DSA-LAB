/*
Write a program that declares an array of 10 integers. The program should:
1. Take input from the user with validation to ensure only integers are entered.
2. Store the numbers in the array.
3. Print all the numbers along with their index positions.
4. Display the maximum and minimum numbers in the array along with their positions.
5. Calculate and display the product of all even numbers entered.
*/
#include <iostream>
using namespace std;
int main() {
    int arr[10];
    int max, min, maxIndex, minIndex;
    long long product = 1;
    bool hasEven = false;

    // Input with validation
    for (int i = 0; i < 10; i++) {
        cout << "Enter integer " << (i + 1) << ": ";
        while (!(cin >> arr[i])) {
            cout << "Invalid input. Please enter an integer: ";
            cin.clear();
            
        }
    }

    // Initialize max and min
    max = min = arr[0];
    maxIndex = minIndex = 0;

    // Process the array
    for (int i = 0; i < 10; i++) {
        // Print index and value
        cout << "Index " << i << ": " << arr[i] << endl;

        // Find max and min
        if (arr[i] > max) {
            max = arr[i];
            maxIndex = i;
        }
        if (arr[i] < min) {
            min = arr[i];
            minIndex = i;
        }

        // Calculate product of even numbers
        if (arr[i] % 2 == 0) {
            product *= arr[i];
            hasEven = true;
        }
    }

    // Display max and min
    cout << "Maximum number is " << max << " at index " << maxIndex << endl;
    cout << "Minimum number is " << min << " at index " << minIndex << endl;

    // Display product of even numbers
    if (hasEven) {
        cout << "Product of all even numbers is: " << product << endl;
    } else {
        cout << "No even numbers were entered." << endl;
    }

    return 0;
}