#include <iostream>
using namespace std;

#define SIZE 5

class TicketQueue {
    int arr[SIZE], front, rear;
    
public:
    TicketQueue() { 
        front = rear = -1; 
    }
    
    void bookTicket(int customerID) {
        if (rear == SIZE - 1) {
            cout << "Queue full! Customer " << customerID 
                 << " cannot book now.\n";
            return;
        }
        if (front == -1) front = 0;
        arr[++rear] = customerID;
        cout << "Customer " << customerID 
             << " joined ticket queue.\n";
    }
    
    void serveCustomer() {
        if (front == -1 || front > rear) {
            cout << "No customers in ticket queue.\n";
            return;
        }
        cout << "Customer " << arr[front++] 
             << " bought ticket.\n";
    }
    
    void showQueue() {
        if (front == -1 || front > rear) {
            cout << "No customers waiting.\n";
            return;
        }
        cout << "Customers waiting: ";
        for (int i = front; i <= rear; i++)
            cout << arr[i] << " ";
        cout << endl;
    }
};

int main() {
    TicketQueue tq;
    tq.bookTicket(201);
    tq.bookTicket(202);
    tq.bookTicket(203);
    tq.showQueue();
    tq.serveCustomer();
    tq.showQueue();
    return 0;
}