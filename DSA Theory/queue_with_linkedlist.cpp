#include <iostream>

struct Node {
    int data;
    Node* next;
};

class LinkedQueue {
public:
    LinkedQueue() : front_(nullptr), rear_(nullptr), count_(0) {}
    ~LinkedQueue() { clear(); }

    void enqueue(int value) {
        Node* n = new Node{value, nullptr};
        if (!rear_) {
            front_ = rear_ = n;
        } else {
            rear_->next = n;
            rear_ = n;
        }
        ++count_;
    }

    bool dequeue(int& out) {
        if (!front_) return false;
        Node* n = front_;
        out = n->data;
        front_ = front_->next;
        if (!front_) rear_ = nullptr;
        delete n;
        --count_;
        return true;
    }

    bool peek(int& out) const {
        if (!front_) return false;
        out = front_->data;
        return true;
    }

    bool isEmpty() const { return count_ == 0; }
    std::size_t size() const { return count_; }

    void clear() {
        int tmp;
        while (dequeue(tmp)) {}
    }

private:
    Node* front_;
    Node* rear_;
    std::size_t count_;
};

int main() {
    LinkedQueue q;

    q.enqueue(10);
    q.enqueue(20);
    q.enqueue(30);
    std::cout << "Size after enqueues: " << q.size() << '\n';

    int v;
    if (q.peek(v)) {
        std::cout << "Front element: " << v << '\n';
    }

    std::cout << "Dequeuing: ";
    bool first = true;
    while (q.dequeue(v)) {
        if (!first) std::cout << ", ";
        std::cout << v;
        first = false;
    }
    std::cout << '\n';

    std::cout << std::boolalpha;
    std::cout << "Queue empty: " << q.isEmpty() << '\n';

    q.enqueue(42);
    q.enqueue(7);
    std::cout << "Size now: " << q.size() << '\n';
    if (q.peek(v)) {
        std::cout << "Front now: " << v << '\n';
    }

    q.clear();
    std::cout << "Size after clear: " << q.size() << '\n';

    return 0;
}