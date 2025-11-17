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
void insertAtMiddle(Node* &head, int data, int position) {
    
    if(position < 1) {
        cout << "Invalid position!" << endl;
        return;
    }

    Node* newNode = new Node(data);
    
    
    if(position == 1 || head == NULL) {
        newNode->next = head;
        head = newNode;
        return;
    }

    // Traverse to position - 1
    Node* temp = head;
    int count = 1;
    while(count < position - 1 && temp != NULL) {
        temp = temp->next;
        count++;
    }

    
    if(temp == NULL) {
        cout << "Position exceeds list length!" << endl;
        return;
    }

    
    newNode->next = temp->next;
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
    
    cout << "Creating initial list..." << endl;
    insertAtMiddle(head, 10, 1);  
    insertAtMiddle(head, 20, 2); 
    insertAtMiddle(head, 30, 3);  
    
    cout << "Initial list: ";
    display(head);
    
    cout << "\nInserting 15 at position 2..." << endl;
    insertAtMiddle(head, 15, 2);  
    cout << "List after insertion: ";
    display(head);
    
    return 0;
}
