// Simple array-based circular queue implementation with a small demo
#include <iostream>

class Queue {
public:
    static const int MAX_CAP = 100; // fixed compile-time capacity

    Queue(int capacity = 10)
        : cap_(capacity <= MAX_CAP ? capacity : MAX_CAP), head_(0), tail_(0), count_(0) {}

    bool enqueue(int value) {
        if (isFull()) return false;
        data_[tail_] = value;
        tail_ = (tail_ + 1) % cap_;
        ++count_;
        return true;
    }

    bool dequeue(int& out) {
        if (isEmpty()) return false;
        out = data_[head_];
        head_ = (head_ + 1) % cap_;
        --count_;
        return true;
    }

    bool front(int& out) const {
        if (isEmpty()) return false;
        out = data_[head_];
        return true;
    }

    bool isEmpty() const { return count_ == 0; }
    bool isFull() const { return count_ == cap_; }
    int size() const { return count_; }
    int capacity() const { return cap_; }

    void display(std::ostream& os = std::cout) const {
        os << "[";
        for (int i = 0; i < count_; ++i) {
            int idx = (head_ + i) % cap_;
            os << data_[idx];
            if (i != count_ - 1) os << ", ";
        }
        os << "]";
    }

private:
    int cap_;
    int data_[MAX_CAP];
    int head_;
    int tail_;
    int count_;
};

int main() {
    Queue q(5);
    std::cout << "Capacity: " << q.capacity() << "\n";

    std::cout << "Enqueue 10, 20, 30\n";
    q.enqueue(10);
    q.enqueue(20);
    q.enqueue(30);
    std::cout << "Queue: "; q.display(); std::cout << "\n";

    int f;
    if (q.front(f)) {
        std::cout << "Front: " << f << "\n";
    }

    std::cout << "Dequeue two\n";
    int x;
    q.dequeue(x); std::cout << "Removed: " << x << "\n";
    q.dequeue(x); std::cout << "Removed: " << x << "\n";
    std::cout << "Queue: "; q.display(); std::cout << "\n";

    std::cout << "Enqueue 40, 50, 60 (wrap-around)\n";
    q.enqueue(40);
    q.enqueue(50);
    std::cout << "Add 60: " << (q.enqueue(60) ? "ok" : "full") << "\n";
    std::cout << "Queue: "; q.display(); std::cout << "\n";

    std::cout << std::boolalpha;
    std::cout << "Empty? " << q.isEmpty() << ", Full? " << q.isFull() << "\n";

    std::cout << "Drain: ";
    bool first = true;
    while (q.dequeue(x)) {
        if (!first) std::cout << ", ";
        std::cout << x;
        first = false;
    }
    std::cout << "\nEmpty? " << q.isEmpty() << "\n";
    return 0;
}