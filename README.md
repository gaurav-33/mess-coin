# MessCoin

MessCoin is a digital mess coupon system that replaces the traditional paper coupon system with a digital coin-based transaction model. It integrates secure payments, authentication, and meal tracking for hostel mess management.

## Features
- **Digital Payments:** Allows students to pay for meals digitally.
- **Authentication:** Supports biometric authentication for secure transactions.
- **Transaction History:** Users can view their top-up and spending history.
- **Hostel Management:** Students are assigned to hostels, and data is stored accordingly.
- **Extra Meals & Menu Tracking:** Tracks extra meal requests and displays the mess menu.

## Installation
1. Clone the repository:
   ```sh
   git clone <repo-url>
   ```
2. Navigate to the project directory:
   ```sh
   cd messcoin
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

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

## Contributing
This is a private repository with a personal license. If you are part of the development team and want to contribute:
1. Fork the repository (if applicable).
2. Create a new branch:
   ```sh
   git checkout -b feature-branch
   ```
3. Commit changes:
   ```sh
   git commit -m "Add new feature"
   ```
4. Push to the branch:
   ```sh
   git push origin feature-branch
   ```
5. Open a Pull Request.

## Contact
For any queries, contact the project owner.

---
📌 **Note:** This project is under a **personal license**, and redistribution is not allowed.

