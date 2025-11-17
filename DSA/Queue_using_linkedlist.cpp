#include <iostream>
using namespace std;

struct Node {
    int data;
    Node* next;
};

Node *front = NULL, *rear = NULL;

void enqueue(int val) {
    Node* n = new Node();
    n->data = val;
    n->next = NULL;
    if (rear == NULL)
        front = rear = n;
    else {
        rear->next = n;
        rear = n;
    }
    cout << val << " enqueued\n";
}

void dequeue() {
    if (front == NULL)
        cout << "Queue Underflow\n";
    else {
        cout << front->data << " dequeued\n";
        Node* temp = front;
        front = front->next;
        delete temp;
        if (front == NULL)
            rear = NULL;
    }
}

void display() {
    if (front == NULL)
        cout << "Queue is empty\n";
    else {
        Node* temp = front;
        cout << "Queue Elements: ";
        while (temp != NULL) {
            cout << temp->data << " ";
            temp = temp->next;
        }
        cout << endl;
    }
}

int main() {
    enqueue(10);
    enqueue(20);
    enqueue(30);
    display();
    dequeue();
    display();
    return 0;
}
