#include<iostream>
using namespace std;
struct queue_using_array
{
    int arr[5];
    int front;
    int rear;
    int n;
    queue_using_array()
    {
        front = rear =-1;
        n = 5;
    }

    void enqueue(int x)
    {
        // Full when next rear equals front (circular condition)
        if ((rear + 1) % n == front)
        {
            cout << "Queue is full" << endl;
            return;
        }
        if (front == -1)
        {
            front = 0; // first element
        }
        rear = (rear + 1) % n;
        arr[rear] = x;
    }
    void dequeue()
    {
        if (front == -1)
        {
            cout << "Queue is empty" << endl;
            return;
        }
        if (front == rear)
        {
            // last element removed; reset to empty state
            front = rear = -1;
        }
        else
        {
            front = (front + 1) % n;
        }
    }

    void show()
    {
        if (front == -1)
        {
            cout << "Queue is empty" << endl;
            return;
        }
        int i = front;
        while (true)
        {
            cout << arr[i] << " ";
            if (i == rear) break;
            i = (i + 1) % n;
        }
        cout << endl;
    }
};

int main()
{
     queue_using_array q;
     q.enqueue(10);
     q.enqueue(20);
     q.enqueue(30);
     q.enqueue(40);
     q.enqueue(50);
     q.show();
     q.dequeue();
     q.show();
     
     
    
}

