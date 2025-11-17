#include<iostream>
using namespace std;
class Node{
    public:
    int data;
    Node* next;
    Node(int data){
        this->data = data;
        this->next = NULL;
    }
};
void insertAtLast(Node* &head, int data){
    Node* newNode = new Node(data);
    if(head == NULL){
        head = newNode;
        return;
    }
    Node* temp = head;
    while(temp->next != NULL){
        temp = temp->next;
    }
    temp->next = newNode;
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
    
    
    insertAtLast(head, 10);
    insertAtLast(head, 20);
    insertAtLast(head, 30);
    
    cout << "Initial list: ";
    display(head);  
    
    
    cout << "After inserting 50 at the last: ";
    insertAtLast(head, 50);
    display(head);  
    
    return 0;
}