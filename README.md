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

| Partial | duration | task |
|-|-|-|
| 20min | 20min | Create the project, README, Initial Planning. | 
| 80min | 60min | Setup project architecture, clean initial project files, implement base navigation. | 
| 170min | 90min | Implement Base UI Components, Auth Navigation, SignIn screen and base NetworkService. | 
| 180min | 10min | Generating SignUp Flow based on SignIn with Claude Agent with minor adjustments. | 
| 195min | 15min | Creating Architecture template for AI use. | 
| 210min | 15min | Creating Template prompt for agents to use to scaffold new features. Creating Doors Feed scafoold. | 
| 300min | 90min | Implement doors list UI, Navigation, Base API Service. | 
| 420min | 120min | Setup Network layer and Environment | 
| 450min | 30min | Connect API, implementing error handling on Form Fields | 
| 480min | 30min | Creating toast feedback | 
| 500min | 20min | Generating KeychainManager from Claude and Storing Login token on keychain | 
| 530min | 30min | Connecting doors fetch | 