/*
At an international airport, passengers must board flights in order. Since the number of passengers 
can vary, a dynamic linked list queue ensures smooth boarding without overflow issues. The system 
must allow passengers to join the queue, board when called, and show the remaining passengers
*/
#include <iostream>
using namespace std;
struct Passenger {
 string name;
 Passenger* next;
};

class BoardingQueue {
 Passenger *front, *rear;
public:
 BoardingQueue() { front = rear = NULL; }
 void joinBoarding(string n) {
 Passenger* newP = new Passenger{n, NULL};
 if (rear == NULL) front = rear = newP;
 else {
 rear->next = newP;
 rear = newP;
 }
 cout << n << " joined the boarding queue.\n";
 }
 void boardPassenger() {
 if (!front) {
 cout << "No passengers waiting.\n";
 return;
 }
 cout << "Passenger boarded: " << front->name << endl;
 Passenger* temp = front;
 front = front->next;
 if (!front) rear = NULL;
 delete temp;
 }
 void showQueue() {
 if (!front) {
 cout << "No passengers in queue.\n";
 return;
 }
 cout << "Boarding Queue: ";
 Passenger* temp = front;
 while (temp) {
 cout << temp->name << " ";
 temp = temp->next;
 }
 cout << endl;
 }
};
int main() {
 BoardingQueue bq;
 bq.joinBoarding("John");
 bq.joinBoarding("Maria");
 bq.joinBoarding("Ahmed");
 bq.showQueue();
 bq.boardPassenger();
 bq.showQueue();
}