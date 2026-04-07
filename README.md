# Assa Abloy Challenge

This project is a challenge from Assa Abloy Interview process implemented by Lucas Costa Araujo. It will be removed as the process finishes.

# 1. Planning

The choosed architecture is MVVM with coordinator.
- MVVM facilitates making the view responsive to state changes following SwiftUI reactive principle.
- Coordinator organizes the navigation preparing for scalability.

## 1.1 Prioritized features
- Authentication (signin and signup).
Authentication must store a secure key and use it on future request to the API. The key is stored on Keychain 

- Doors List.
The list supports pagination and allow user to search by name

## 1.2 Additional features
- Door event list
- Permissions
- Raw BLE Event Parsing (adv.)
- Encrypted Requests (Plus)

# 2. Authentication
- Signin have a login with email and a secured password
- Signup is a form that require email, password and password confirmation.

# 3. Authenticated flow
- Doors list has door view cell. At the top there is a search bar.


# 4. Time Records
20min - Create the project, README, Initial Planning.

60min - Setup project architecture, clean initial project files, implement base navigation