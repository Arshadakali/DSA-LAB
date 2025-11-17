/*
Write a C++ program to add a node at the end of linked list. Put the screen shot of your output
*/

#include <iostream>
using namespace std;
struct Node {
    int data;
    Node* next;
};

void append(Node** head_ref, int new_data) {
    Node* new_node = new Node();
    Node* last = *head_ref;
    new_node->data = new_data;
    new_node->next = NULL;
    if (*head_ref == NULL) {
        *head_ref = new_node;
        return;
    }
    while (last->next != NULL) {
        last = last->next;
    }
    last->next = new_node;
    return;
    return;
}
void printList(Node* node) {
    while (node!=NULL) {
        cout << node->data << " ";
        node = node->next;
    }
}
int main() {
    Node* head = NULL;
    append(&head,
        6);
    append(&head,
        7);
    append(&head,
        1);
    append(&head,
        4);
        printList(head);
        return 0;
}