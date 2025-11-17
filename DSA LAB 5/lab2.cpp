/*
At City Hospital, patients are treated in the order they arrive. Since the number of patients may 
vary throughout the day, the hospital decides to implement a dynamic queue using linked lists. 
Each new patient joins the queue, and doctors treat them one by one. If no patients are present, 
the system notifies staff
*/

#include <iostream>
#include <string>
#include <iomanip>
using namespace std;

// Patient node structure
struct Patient {
    string name;
    int patientID;
    string condition;
    Patient* next;
    
    // Constructor for easy patient creation
    Patient(string n, int id, string cond) {
        name = n;
        patientID = id;
        condition = cond;
        next = nullptr;
    }
};

class HospitalQueue {
private:
    Patient* front;
    Patient* rear;
    int totalPatients;
    int nextPatientID;

public:
    // Constructor
    HospitalQueue() {
        front = nullptr;
        rear = nullptr;
        totalPatients = 0;
        nextPatientID = 1001; // Starting patient ID
    }
    
    // Destructor to free memory
    ~HospitalQueue() {
        while (!isEmpty()) {
            treatPatient();
        }
    }
    
    // Check if queue is empty
    bool isEmpty() {
        return front == nullptr;
    }
    
    // Add new patient to queue (Enqueue)
    void addPatient() {
        string name, condition;
        
        cout << "\n PATIENT REGISTRATION\n";
        cout << "Enter patient name: ";
        cin.ignore();
        getline(cin, name);
        
        cout << "Enter medical condition/reason for visit: ";
        getline(cin, condition);
        
        // Create new patient with auto-generated ID
        Patient* newPatient = new Patient(name, nextPatientID++, condition);
        
        // If queue is empty
        if (isEmpty()) {
            front = rear = newPatient;
        } else {
            // Add to rear of queue
            rear->next = newPatient;
            rear = newPatient;
        }
        
        totalPatients++;
        
        cout << "\nPatient successfully registered!\n";
        cout << "Patient ID: " << newPatient->patientID << "\n";
        cout << "Name: " << newPatient->name << "\n";
        cout << "Condition: " << newPatient->condition << "\n";
        cout << "Position in queue: " << totalPatients << "\n";
    }
    
    // Treat patient (Dequeue)
    void treatPatient() {
        if (isEmpty()) {
            cout << "\n No patients waiting! The queue is empty.\n";
            cout << " Staff notification: All patients have been treated!\n";
            return;
        }
        
        Patient* patientToTreat = front;
        
        cout << "\nTREATING PATIENT\n";
        cout << "Now treating:\n";
        cout << "Patient ID: " << patientToTreat->patientID << "\n";
        cout << " Name: " << patientToTreat->name << "\n";
        cout << "Condition: " << patientToTreat->condition << "\n";
        
        // Move front pointer
        front = front->next;
        
        // If queue becomes empty
        if (front == nullptr) {
            rear = nullptr;
        }
        
        // Free memory
        delete patientToTreat;
        totalPatients--;
        
        cout << "Patient has been successfully treated!\n";
        
        if (totalPatients > 0) {
            cout << "Remaining patients in queue: " << totalPatients << "\n";
        } else {
            cout << "All patients have been treated! Queue is now empty.\n";
        }
    }
    
    // Display all waiting patients
    void displayQueue() {
        if (isEmpty()) {
            cout << "\nPATIENT QUEUE STATUS\n";
            cout << "No patients currently waiting.\n";
            cout << "Staff notification: Queue is empty!\n";
            return;
        }
        
        cout << "\n=== CURRENT PATIENT QUEUE ===\n";
        cout << "Total patients waiting: " << totalPatients << "\n";
        cout << string(60, '=') << "\n";
        cout << left << setw(10) << "Position" 
             << setw(12) << "Patient ID" 
             << setw(20) << "Name" 
             << setw(18) << "Condition" << "\n";
        cout << string(60, '-') << "\n";
        
        Patient* current = front;
        int position = 1;
        
        while (current != nullptr) {
            cout << left << setw(10) << position
                 << setw(12) << current->patientID
                 << setw(20) << current->name
                 << setw(18) << current->condition << "\n";
            current = current->next;
            position++;
        }
        
        cout << string(60, '=') << "\n";
        cout << "Next patient to be treated: " << front->name 
             << " (ID: " << front->patientID << ")\n";
    }
    
    // Get queue statistics
    void showStatistics() {
        cout << "\n=== HOSPITAL QUEUE STATISTICS ===\n";
        cout << "Total patients waiting: " << totalPatients << "\n";
        cout << "Queue status: " << (isEmpty() ? "Empty" : "Active") << "\n";
        cout << "Next patient ID: " << nextPatientID << "\n";
        
        if (!isEmpty()) {
            cout << "Next patient: " << front->name 
                 << " (ID: " << front->patientID << ")\n";
            cout << "Last patient: " << rear->name 
                 << " (ID: " << rear->patientID << ")\n";
        }
    }
};

void displayMenu() {
    cout << "\n========== CITY HOSPITAL PATIENT QUEUE SYSTEM ==========\n";
    cout << "Welcome to the Patient Management System\n";
    cout << string(60, '=') << "\n";
    cout << "1. Register New Patient (Add to Queue)\n";
    cout << "2. Treat Next Patient (Remove from Queue)\n";
    cout << "3. View Patient Queue\n";
    cout << "4. Show Queue Statistics\n";
    cout << "5. Exit System\n";
    cout << string(60, '=') << "\n";
    cout << "Please select an option (1-5): ";
}

int main() {
    HospitalQueue hospital;
    int choice;
    
    cout << "Welcome to City Hospital Patient Queue Management System!\n";
    cout << "This system helps manage patient flow efficiently using a dynamic queue.\n";
    
    do {
        displayMenu();
        cin >> choice;
        
        if (choice == 1) {
            hospital.addPatient();
        }
        else if (choice == 2) {
            hospital.treatPatient();
        }
        else if (choice == 3) {
            hospital.displayQueue();
        }
        else if (choice == 4) {
            hospital.showStatistics();
        }
        else if (choice == 5) {
            cout << "\nThank you for using City Hospital Patient Queue System!\n";
            cout << "Have a great day and stay healthy!\n";
        }
        else {
            cout << "\nInvalid choice! Please select a valid option (1-5).\n";
        }
        
        if (choice != 5) {
            cout << "\nPress Enter to continue...";
            cin.ignore();
            cin.get();
        }
        
    } while (choice != 5);
    
    return 0;
}
