# MessCoin

MessCoin is a digital payment system designed to replace traditional paper coupons for hostel mess transactions. The system allows users to make payments securely using **biometric authentication** (if supported) and ensures a seamless experience for hostel students and staff.

---

## 🚀 Features

- 🔹 **Digital Coin System** - Replace paper coupons with a cashless transaction system.
- 🔹 **Biometric Authentication** - Secure payments with fingerprint/face authentication.
- 🔹 **Hostel Selection** - Users can select or change their hostel.
- 🔹 **Transaction History** - View previous transactions and top-up history.
- 🔹 **Secure & Fast Payments** - Authenticate and pay seamlessly.
- 🔹 **Firebase Integration** - Store and fetch student and transaction data.
- 🔹 **Shared Preferences** - Persist user data locally for a smooth experience.

---

## 🛠 Tech Stack

- **Flutter** - UI Framework
- **Dart** - Programming Language
- **GetX** - State Management & Routing
- **Firebase Firestore** - Database
- **Firebase Authentication** - User Authentication
- **Shared Preferences** - Local Storage
- **Local Authentication** - Biometric/Face ID

---

## 📲 Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/messcoin.git
   cd messcoin
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

3. Set up Firebase:
   - Create a Firebase project.
   - Enable **Firestore Database**.
   - Download and add `google-services.json` (for Android) & `GoogleService-Info.plist` (for iOS).

4. Run the project:
   ```sh
   flutter run
   ```

---

## 🏗 Project Structure

```
lib/
│-- controllers/         # GetX Controllers
│-- models/             # Data Models
│-- screens/            # UI Screens
│-- services/           # Firebase & API Services
│-- utils/              # Helper Functions & Constants
│-- main.dart           # App Entry Point
```

---

## 🔐 Authentication Flow

1. On startup, check if the **hostel ID** is stored in `SharedPreferences`.
2. If the hostel is not found, redirect the user to **Select Hostel Screen**.
3. If biometric authentication is supported, require authentication for payments.
4. If authentication fails or is not supported, allow payment without authentication.

---

## 🛠 API & Database Structure

### **Firestore Collections:**
- `hostel_mess/{hostelId}/students/{uid}` - Student details.
- `transactions/{transactionId}` - Stores transaction details.

### **Shared Preferences Keys:**
- `_hostelIdKey` → Stores selected hostel.

---

## 📝 Contribution

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -m "Added new feature"`
4. Push changes: `git push origin feature-name`
5. Open a pull request.

---

## 📜 License

This project is licensed under the **MIT License**.

---

## 📧 Contact

For queries, reach out to **Gaurav** (Project Owner) at `your-email@example.com`. 🚀

