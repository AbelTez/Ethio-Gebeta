# Ethio Telecom USSD Menu Simulator

A command-line simulation of the Ethio telecom *999# (Ethio Gebeta) USSD service, implemented in both **Bash** and **Python**.
This project models real-world telecom interaction flows, including hierarchical menus, input validation, and transaction processing.

---

## 📌 Overview

This system replicates the behavior of a USSD-based telecom service where users can:

* Purchase **Internet**, **Voice**, **Social Media**, and **Combo (Voice + Internet)** packages
* Send packages **for self** or **as a gift**
* Navigate menus using USSD-style controls (`*`, `**`, `#`, `##`)
* Interact with a simulated **Telebirr** service
* Perform transactions with a **limited balance system**

The project demonstrates how real telecom systems manage **stateful user interactions** over stateless input channels.

---

## ⚙️ Features

* ✅ Multi-level menu navigation (state-driven design)
* ✅ Strict input validation (only valid options accepted)
* ✅ Phone number validation (`09XXXXXXXX` or `2519XXXXXXXX`)
* ✅ Balance management with insufficient funds protection
* ✅ USSD navigation support:

  * `*` → Back one step
  * `**` → Main menu
  * `#` → Next page
  * `##` → Previous page
* ✅ Transaction confirmation and cancellation
* ✅ Dual implementation:

  * Bash (system-level scripting)
  * Python (structured logic & readability)

---

## 🧠 System Design Concept

This project is based on a **Finite State Machine (FSM)** model:

```
Main Menu
   ↓
Category (Internet / Voice / Social / Combo)
   ↓
Type (Self / Gift)
   ↓
Duration (Daily / Weekly / Monthly)
   ↓
Package Selection
   ↓
Confirmation → Transaction → Exit
```

Each menu represents a **state**, and user input determines transitions between states.

---

## 📂 Project Structure

```
ethio-ussd-simulator/
│
├── ethitel.sh      # Bash implementation
├── ethitel.py      # Python implementation
└── README.md
```

---

## 🚀 How to Run

### 1. Bash Version

Make the script executable:

```bash
chmod +x ethitel.sh
```

Run:

```bash
./ethitel.sh
```

---

### 2. Python Version

Run using Python 3:

```bash
python3 ethitel.py
```

---

## 💳 Initial Conditions

* Initial balance: **100 birr**
* Transactions are **blocked** if balance is insufficient
* Program **exits immediately** after:

  * Successful purchase
  * Cancellation

---

## 📱 Telebirr Simulation

* Displays Telebirr menu options
* Any selection returns:

  ```
  Service not yet available. We will fix soon.
  ```
* Input `00` returns to the main menu

---

## 🔒 Input Rules

* Only displayed options are accepted
* Invalid input → re-prompt (no error message)
* Phone number must match:

  * `09XXXXXXXX`
  * `2519XXXXXXXX`

---

## 🎯 Learning Objectives

This project demonstrates:

* State machine modeling in CLI applications
* Structured control flow design
* Input validation strategies
* Separation of concerns (logic vs interaction)
* Comparison between **scripting (Bash)** and **programming (Python)** paradigms

---

## 🔧 Future Improvements

* Convert to a **web-based USSD simulator**
* Integrate with a **backend API (Node.js / Django)**
* Add **persistent user sessions**
* Implement **real transaction logging**
* Improve Telebirr functionality

---

## 👨‍💻 Author

Developed as part of a system design and scripting exercise to model real-world telecom services.

---

## 📄 License

This project is for educational purposes.
