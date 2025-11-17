/*
A local cinema is facing crowd management issues at its ticket counter. Customers line up to buy 
tickets, but without proper order, conflicts occur. To resolve this, the cinema implements a queue 
system using arrays, where customers are served in the order they arrive
*/

#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

// Customer structure to store customer information
struct Customer {
    string name;
    string ticketType;
    int quantity;
    double totalAmount;
    
    Customer() : name(""), ticketType(""), quantity(0), totalAmount(0.0) {}
    
    Customer(string n, string type, int qty, double amount) 
        : name(n), ticketType(type), quantity(qty), totalAmount(amount) {}
};

// Cinema Queue class using array implementation
class CinemaQueue {
private:
    static const int MAX_SIZE = 50;
    Customer queue[MAX_SIZE];
    int front;
    int rear;
    int count;
    
public:
    // Constructor
    CinemaQueue() : front(0), rear(-1), count(0) {}
    
    // Check if queue is empty
    bool isEmpty() {
        return count == 0;
    }
    
    // Check if queue is full
    bool isFull() {
        return count == MAX_SIZE;
    }
    
    // Get current queue size
    int size() {
        return count;
    }
    
    // Add customer to queue (enqueue)
    bool enqueue(const Customer& customer) {
        if (isFull()) {
            cout << "Queue is full! Cannot add more customers." << endl;
            return false;
        }
        
        rear = (rear + 1) % MAX_SIZE;
        queue[rear] = customer;
        count++;
        
        cout << "Customer " << customer.name << " added to queue successfully!" << endl;
        cout << "Position in queue: " << count << endl;
        return true;
    }
    
    // Serve customer (dequeue)
    bool dequeue() {
        if (isEmpty()) {
            cout << "No customers in queue!" << endl;
            return false;
        }
        
        Customer servedCustomer = queue[front];
        front = (front + 1) % MAX_SIZE;
        count--;
        
        cout << "Now serving: " << servedCustomer.name << endl;
        cout << "Ticket Type: " << servedCustomer.ticketType << endl;
        cout << "Quantity: " << servedCustomer.quantity << endl;
        cout << "Total Amount: $" << fixed << setprecision(2) << servedCustomer.totalAmount << endl;
        cout << "Customer served successfully!" << endl;
        
        return true;
    }
    
    // Display current queue
    void displayQueue() {
        cout << "\n========== CINEMA TICKET QUEUE ==========\n";
        
        if (isEmpty()) {
            cout << "No customers currently waiting in queue.\n";
            cout << "Counter is ready for new customers!\n";
            return;
        }
        
        cout << "Current customers in queue: " << count << endl;
        cout << "Queue capacity: " << MAX_SIZE << endl;
        cout << "\nCustomers waiting:\n";
        cout << setw(5) << "Pos" << setw(15) << "Name" << setw(12) << "Ticket" 
             << setw(8) << "Qty" << setw(10) << "Amount" << endl;
        cout << string(50, '-') << endl;
        
        int tempFront = front;
        for (int i = 0; i < count; i++) {
            int pos = (tempFront + i) % MAX_SIZE;
            cout << setw(5) << (i + 1) 
                 << setw(15) << queue[pos].name
                 << setw(12) << queue[pos].ticketType
                 << setw(8) << queue[pos].quantity
                 << setw(10) << "$" << fixed << setprecision(2) << queue[pos].totalAmount << endl;
        }
        
        cout << "\nNext customer to be served: " << queue[front].name << endl;
    }
    
    // Show queue statistics
    void showStatistics() {
        cout << "\n=== CINEMA QUEUE STATISTICS ===\n";
        cout << "Total customers waiting: " << count << endl;
        cout << "Queue capacity: " << MAX_SIZE << endl;
        cout << "Available spots: " << (MAX_SIZE - count) << endl;
        cout << "Queue status: " << (isEmpty() ? "Empty" : (isFull() ? "Full" : "Active")) << endl;
        
        if (!isEmpty()) {
            cout << "Next customer: " << queue[front].name << endl;
        }
    }
};

// Function to display menu
void displayMenu() {
    cout << "\n========== STARLIGHT CINEMA TICKET SYSTEM ==========\n";
    cout << "Welcome to our Ticket Counter Management System\n";
    cout << "====================================================\n";
    cout << "1. Add Customer to Queue\n";
    cout << "2. Serve Next Customer\n";
    cout << "3. View Current Queue\n";
    cout << "4. Show Queue Statistics\n";
    cout << "5. Exit System\n";
    cout << "====================================================\n";
    cout << "Please select an option (1-5): ";
}

int main() {
    CinemaQueue cinema;
    int choice;
    
    cout << "Welcome to Starlight Cinema Ticket Management System!\n";
    cout << "Solving crowd management with organized queuing.\n";
    
    while (true) {
        displayMenu();
        cin >> choice;
        
        if (choice == 1) {
            string name, ticketType;
            int quantity;
            double price, totalAmount;
            
            cout << "\n--- ADD NEW CUSTOMER ---\n";
            cout << "Enter customer name: ";
            cin.ignore();
            getline(cin, name);
            
            cout << "Select ticket type:\n";
            cout << "1. Regular ($12.00)\n";
            cout << "2. Premium ($18.00)\n";
            cout << "3. VIP ($25.00)\n";
            cout << "Choice: ";
            int typeChoice;
            cin >> typeChoice;
            
            if (typeChoice == 1) {
                ticketType = "Regular";
                price = 12.00;
            } else if (typeChoice == 2) {
                ticketType = "Premium";
                price = 18.00;
            } else if (typeChoice == 3) {
                ticketType = "VIP";
                price = 25.00;
            } else {
                cout << "Invalid choice! Defaulting to Regular.\n";
                ticketType = "Regular";
                price = 12.00;
            }
            
            cout << "Enter quantity: ";
            cin >> quantity;
            
            totalAmount = price * quantity;
            
            Customer newCustomer(name, ticketType, quantity, totalAmount);
            cinema.enqueue(newCustomer);
            
        } else if (choice == 2) {
            cout << "\n--- SERVING CUSTOMER ---\n";
            cinema.dequeue();
            
        } else if (choice == 3) {
            cinema.displayQueue();
            
        } else if (choice == 4) {
            cinema.showStatistics();
            
        } else if (choice == 5) {
            cout << "\nThank you for using Starlight Cinema Ticket System!\n";
            cout << "Have a great movie experience!\n";
            break;
            
        } else {
            cout << "Invalid choice! Please select 1-5.\n";
        }
        
        cout << "\nPress Enter to continue...";
        cin.ignore();
        cin.get();
    }
    
    return 0;
}
