#include<iostream>
using namespace std;

class Node {
    public:
    int data;
    Node* next;
    Node(int data) {
        this->data = data;
        this->next = NULL;
    }
};
void insertAtFront(Node* &head, int data) {
    // Create new node
    Node* newNode = new Node(data);
    
    // Make new node point to current head
    newNode->next = head;
    
    // Update head to point to new node
    head = newNode;
}
void display(Node* head){
    Node* temp = head;
    while(temp != NULL){
        cout << temp->data << " ";
        temp = temp->next;
    }
    cout << endl;
}
int main() {
    Node* head = NULL;
    
    cout << "Inserting elements at front..." << endl;
    insertAtFront(head, 30);  // List: 30
    insertAtFront(head, 20);  // List: 20->30
    insertAtFront(head, 10);  // List: 10->20->30
    
    cout << "Final list: ";
    display(head);
    return 0;
}