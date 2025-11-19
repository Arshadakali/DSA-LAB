#include <iostream>
using namespace std;

struct Node {
    int data;
    Node* next;
    Node(int d) : data(d), next(nullptr) {}
};

class LinkedListQueue {
    Node* front_;
    Node* rear_;
    size_t count_;
public:
    LinkedListQueue() : front_(nullptr), rear_(nullptr), count_(0) {}

    bool isEmpty() const { return front_ == nullptr; }
    size_t size() const { return count_; }

    void enqueue(int x) {
        Node* node = new Node(x);
        if (isEmpty()) {
            front_ = rear_ = node;
        } else {
            rear_->next = node;
            rear_ = node;
        }
        ++count_;
    }

    int dequeue() {
        if (isEmpty()) {
            cout << "Queue is empty" << endl;
            return -1;
        }
        Node* tmp = front_;
        int val = tmp->data;
        front_ = front_->next;
        if (front_ == nullptr) {
            rear_ = nullptr;
        }
        delete tmp;
        --count_;
        return val;
    }

    int frontValue() const {
        if (isEmpty()) {
            cout << "Queue is empty" << endl;
            return -1;
        }
        return front_->data;
    }

    void show() const {
        if (isEmpty()) {
            cout << "Queue is empty" << endl;
            return;
        }
        Node* curr = front_;
        while (curr) {
            cout << curr->data << " ";
            curr = curr->next;
        }
        cout << endl;
    }

    void clear() {
        while (!isEmpty()) {
            dequeue();
        }
    }
};

int main() {
    LinkedListQueue q;
    q.enqueue(10);
    q.enqueue(20);
    q.enqueue(30);
    q.enqueue(40);
    q.enqueue(50);
    q.show();          // 10 20 30 40 50
    q.dequeue();       // removes 10
    q.show();          // 20 30 40 50
    q.enqueue(60);
    q.show();          // 20 30 40 50 60

    cout << "Front: " << q.frontValue() << endl;  // 20
    cout << "Size: " << q.size() << endl;         // 5

    q.clear();
    q.show();          // Queue is empty
    return 0;
}