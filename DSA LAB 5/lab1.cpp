/*
Customers wait in line at a bank. The first customer in line is served first.
Operations:
enqueue() → Add customer
dequeue() → Serve customer
display() → Show waiting customers
*/
#include <iostream>
#include <string>
using namespace std;

#define MAX_SIZE 100

class BankQueue {
private:
    string customers[MAX_SIZE];
    int front;
    int rear;
    int count;

public:
    // Constructor
    BankQueue() {
        front = 0;
        rear = -1;
        count = 0;
    }

    // Check if queue is empty
    bool isEmpty() {
        return count == 0;
    }

    // Check if queue is full
    bool isFull() {
        return count == MAX_SIZE;
    }

    // Add customer to queue (enqueue)
    void enqueue() {
        if (isFull()) {
            cout << "Queue is full! Cannot add more customers.\n";
            return;
        }
        
        string customerName;
        cout << "Enter customer name: ";
        cin.ignore();
        getline(cin, customerName);
        
        rear = (rear + 1) % MAX_SIZE;
        customers[rear] = customerName;
        count++;
        
        cout << "Customer '" << customerName << "' added to queue.\n";
    }

    // Serve customer (dequeue)
    void dequeue() {
        if (isEmpty()) {
            cout << "No customers in queue to serve.\n";
            return;
        }
        
        string servedCustomer = customers[front];
        front = (front + 1) % MAX_SIZE;
        count--;
        
        cout << "Serving customer: " << servedCustomer << "\n";
        cout << "Customer '" << servedCustomer << "' has been served.\n";
    }

    // Display all waiting customers
    void display() {
        if (isEmpty()) {
            cout << "No customers waiting in queue.\n";
            return;
        }
        
        cout << "\n--- Customers waiting in line ---\n";
        cout << "Position\tCustomer Name\n";
        cout << "--------\t-------------\n";
        
        int position = 1;
        int index = front;
        
        for (int i = 0; i < count; i++) {
            cout << position << "\t\t" << customers[index] << "\n";
            index = (index + 1) % MAX_SIZE;
            position++;
        }
        
        cout << "\nTotal customers waiting: " << count << "\n";
    }

    // Get queue size
    int size() {
        return count;
    }
};

void displayMenu() {
    cout << "\n========== BANK QUEUE SYSTEM ==========\n";
    cout << "1. Add Customer (Enqueue)\n";
    cout << "2. Serve Customer (Dequeue)\n";
    cout << "3. Display Waiting Customers\n";
    cout << "4. Show Queue Status\n";
    cout << "5. Exit\n";
    cout << "=======================================\n";
    cout << "Enter your choice: ";
}

int main() {
    BankQueue bankQueue;
    int choice;
    
    cout << "Welcome to Bank Queue Management System!\n";
    
    do {
        displayMenu();
        cin >> choice;
        
        if (choice == 1) {
            cout << "\n--- Adding Customer ---\n";
            bankQueue.enqueue();
        }
        else if (choice == 2) {
            cout << "\n--- Serving Customer ---\n";
            bankQueue.dequeue();
        }
        else if (choice == 3) {
            cout << "\n--- Queue Display ---\n";
            bankQueue.display();
        }
        else if (choice == 4) {
            cout << "\n--- Queue Status ---\n";
            cout << "Customers in queue: " << bankQueue.size() << "\n";
            cout << "Queue empty: " << (bankQueue.isEmpty() ? "Yes" : "No") << "\n";
            cout << "Queue full: " << (bankQueue.isFull() ? "Yes" : "No") << "\n";
        }
        else if (choice == 5) {
            cout << "\nThank you for using Bank Queue System!\n";
        }
        else {
            cout << "\nInvalid choice! Please try again.\n";
        }
        
        if (choice != 5) {
            cout << "\nPress Enter to continue...";
            cin.ignore();
            cin.get();
        }
        
    } while (choice != 5);
    
    return 0;
}