/*
Write a C++ program to delete a node from the linked list.
Beginning
End
Middle
*/
#include <iostream>
using namespace std;
struct Node {
    int data;
    Node* next;
};

// Function to delete a node at a given position
void deleteNode(Node** head_ref, int position)
{
    if (*head_ref == NULL)
        return;
        Node* temp = *head_ref;
        if (position == 0) {
            *head_ref = temp->next;
            delete temp;
            return;
        }
        for (int i = 0; temp!=NULL && i < position-1; i++)
            temp = temp->next;
            if (temp == NULL || temp->next == NULL)
                return;
            Node* next = temp->next->next;
            delete temp->next;
            temp->next = next;
}
// Function to print the linked list
void printList(Node* node)
{
    while (node != NULL) {
        cout << node->data << " ";
        node = node->next;
    }
};

int main()
{
    Node* head = NULL;
    head = new Node();

    head->data = 1;
    head->next = new Node();
    head->next->data = 2;
    head->next->next = new Node();
    head->next->next->data = 3;
    head->next->next->next = new Node();
    head->next->next->next->data = 4;
    head->next->next->next->next = NULL;

    cout << "Original linked list: ";
    printList(head);

    int position = 2;
    deleteNode(&head, position);

    cout << "\nLinked list after deletion: ";
    printList(head);

    return 0;
}