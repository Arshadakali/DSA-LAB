/*
Write a program that simulates the checkout counter of a supermarket using a queue data 
structure. Customers should be added to the queue in the order they arrive, and the cashier 
should serve them sequentially using the dequeue operation. The program must handle cases 
where the queue is full by preventing new customers from entering until space becomes 
available (overflow condition), as well as cases where the queue is empty (underflow condition). 
After each operation, the program should display the current state of the queue and provide 
clear messages about customers being added, served, or waiting
*/
#include <iostream>
using namespace std;
#define SIZE 4
class CheckoutQueue {
 int arr[SIZE], front, rear;
public:
 CheckoutQueue() { front = rear = -1; }
 void addCustomer(int id) {
 if (rear == SIZE - 1) {
 cout << "Checkout line full! Customer " << id << " cannot join.\n";
 return;
 }
 if (front == -1) front = 0;
 arr[++rear] = id;
 cout << "Customer " << id << " joined checkout line.\n";
 }
 void serveCustomer() {
 if (front == -1 || front > rear) {
 cout << "No customers to serve.\n";
 return;
 }
 cout << "Customer " << arr[front++] << " served.\n";
 }
 void showLine() {
 if (front == -1 || front > rear) {
 cout << "No customers waiting.\n";
 return;
 }
 cout << "Checkout line: ";
 for (int i = front; i <= rear; i++)
 cout << arr[i] << " ";
 cout << endl;
 }
};
int main() {
 CheckoutQueue cq;
 cq.addCustomer(301);
 cq.addCustomer(302);
 cq.showLine();
 cq.serveCustomer();
 cq.showLine();
}