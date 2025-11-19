#include <iostream>
#include <vector>

class ArrayQueue {
public:
    ArrayQueue(std::size_t capacity = 10)
        : cap_(capacity), data_(capacity), head_(0), tail_(0), count_(0) {}

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

    bool peek(int& out) const {
        if (isEmpty()) return false;
        out = data_[head_];
        return true;
    }

    bool isEmpty() const { return count_ == 0; }
    bool isFull() const { return count_ == cap_; }
    std::size_t size() const { return count_; }
    std::size_t capacity() const { return cap_; }

private:
    std::size_t cap_;
    std::vector<int> data_;
    std::size_t head_;
    std::size_t tail_;
    std::size_t count_;
};

int main() {
    ArrayQueue q(5);

    std::cout << "Capacity: " << q.capacity() << "\n";
    std::cout << "Enqueue 10,20,30,40,50\n";
    for (int v : {10, 20, 30, 40, 50}) {
        std::cout << (q.enqueue(v) ? "  ok" : "  full") << "\n";
    }
    std::cout << "Is full: " << std::boolalpha << q.isFull() << "\n";

    std::cout << "Try enqueue 60 (should fail): "
              << (q.enqueue(60) ? "ok" : "full") << "\n";

    std::cout << "Dequeue three: ";
    int x;
    for (int i = 0; i < 3; ++i) {
        if (q.dequeue(x)) {
            std::cout << x << (i < 2 ? ", " : "\n");
        }
    }

    std::cout << "Enqueue 60,70 (wrap-around)\n";
    for (int v : {60, 70}) {
        std::cout << (q.enqueue(v) ? "  ok" : "  full") << "\n";
    }

    int front;
    if (q.peek(front)) {
        std::cout << "Front element: " << front << "\n";
    }

    std::cout << "Drain queue: ";
    bool first = true;
    while (q.dequeue(x)) {
        if (!first) std::cout << ", ";
        std::cout << x;
        first = false;
    }
    std::cout << "\nEmpty: " << std::boolalpha << q.isEmpty() << "\n";

    return 0;
}