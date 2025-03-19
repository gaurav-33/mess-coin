# MessCoin

MessCoin is a digital mess coupon system that replaces the traditional paper coupon system with a digital coin-based transaction model. It integrates secure payments, authentication, and meal tracking for hostel mess management.

## Features
- **Digital Payments:** Allows students to pay for meals digitally.
- **Authentication:** Supports biometric authentication for secure transactions.
- **Transaction History:** Users can view their top-up and spending history.
- **Hostel Management:** Students are assigned to hostels, and data is stored accordingly.
- **Extra Meals & Menu Tracking:** Tracks extra meal requests and displays the mess menu.


## Authentication Flow
- If **biometric authentication** is available, users must authenticate before making a payment.
- If the device **does not support authentication**, users can proceed with payment without authentication.
- If **PhoneAuth** is enabled, users must verify their identity before payment.

## Usage
1. **Select Hostel**: On first launch, users select their hostel.
2. **Login/Register**: Users log in or register with their student details.
3. **Top-up Balance**: Users can add funds to their MessCoin wallet.
4. **Make Payment**: Users authenticate (if required) and pay for meals.
5. **View History**: Users can check their transaction history.

## Tech Stack
- **Flutter** (Frontend)
- **Firebase Firestore** (Database)
- **Firebase Authentication** (User Management)
- **Local Authentication** (Biometric & PIN authentication)
- **GetX** (State Management & Routing)

## UI
![Screenshot_2025-03-15-15-59-15-04_4f040d7df525f480d15b5790f9bc7b5a](https://github.com/user-attachments/assets/1e0e8447-6365-4f52-88cf-879d0d9be632)
![Screenshot_2025-03-15-15-59-10-36_4f040d7df525f480d15b5790f9bc7b5a](https://github.com/user-attachments/assets/3f2afb07-9b23-494b-b165-8a86a6f978bd)
![Screenshot_2025-03-15-15-59-07-37_4f040d7df525f480d15b5790f9bc7b5a](https://github.com/user-attachments/assets/a2222c91-09d1-4125-b8c3-74d99d80e8d0)
![Screenshot_2025-03-15-15-59-00-22_4f040d7df525f480d15b5790f9bc7b5a](https://github.com/user-attachments/assets/7bdd2ccb-cef2-4fb4-a9cc-8e8f853439d5)
![Screenshot_2025-03-15-15-58-57-42_4f040d7df525f480d15b5790f9bc7b5a](https://github.com/user-attachments/assets/2463201a-1bd7-454b-b170-ec4835710841)
![Screenshot_2025-03-15-15-58-51-44_4f040d7df525f480d15b5790f9bc7b5a](https://github.com/user-attachments/assets/e6c5a53a-8c9c-42b7-af48-8448c4baca9c)
![Screenshot_2025-03-15-15-58-49-21_4f040d7df525f480d15b5790f9bc7b5a](https://github.com/user-attachments/assets/21060f6f-d21a-4887-945e-5fc9c53f0cf1)
![Screenshot_2025-03-15-15-58-32-11_4f040d7df525f480d15b5790f9bc7b5a](https://github.com/user-attachments/assets/e98ae1e0-43e6-4589-85d0-9d042be2fa9c)


## Contact
For any queries, contact the project owner.

---
📌 **Note:** This project is under a **personal license**, and redistribution is not allowed.

