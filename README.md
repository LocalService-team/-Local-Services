<<<<<<< HEAD
# 📱 Local Services Super App (Kabul Version)

A lightweight Flutter-based mobile application designed to provide quick and easy access to essential local services in Kabul city — without requiring user registration or login.

---

## 👥 Team Members

* Sharifa Joya
* Binazir Hedayat
* Marwa Habibi
* Latifa Wakili
* Marwa Hashimi
* Eshwa Quraishi
* Wazhma Hakimi
* Elham Sarwari
* Zakia Rezayee

---

## 🎯 Introduction

The **Local Services Super App** is a mobile application developed using Flutter. It helps users quickly find essential local services such as bakeries, pharmacies, transportation, and home services within Kabul.

This version is designed to be simple, fast, and accessible — especially in low-resource environments — and does not require user authentication.

---

## 🎯 Objectives

* Simplify access to local services
* Reduce time spent searching for services
* Provide accurate and useful information
* Build a lightweight and efficient app
* Ensure usability in low internet conditions

---

## 📌 Project Scope

### ✅ Current Version (MVP)

* Limited to Kabul city
* Uses API to fetch service data
* No login or registration system
* Read-only system (no user input)

### 🚀 Future Development

* Expand to all provinces of Afghanistan
* Integrate with a real database
* Add offline functionality (SQLite)
* Integrate maps and location services
* Allow optional user submissions

---

## ⚙️ Technologies Used

* **Flutter** – Mobile app development
* **REST API** – Data communication
* **JSON** – Data format

---

## 📱 Application Screens

### 🏠 Home Screen

* Displays service categories
* Navigation to different categories

### 📋 Service List Screen

* Shows services by category
* Displays name and district
* Data fetched from API

### 📄 Service Detail Screen

* Shows full service details:

  * Name
  * Phone number
  * Address
* Includes direct call functionality

### 🔍 Search Screen

* Search by name or category
* Filters services dynamically

---

## 🧱 Project Structure

```
lib/
│
├── main.dart
├── core/
│   ├── constants/
│   └── utils/
├── models/
├── services/
├── providers/
├── screens/
├── widgets/
└── routes/
```

---

## 🔌 API Design

### Endpoint

```
GET /services
```

### Parameters

* `category` (optional)

### Sample Response

```json
{
  "id": 1,
  "name": "Ahmad Bakery",
  "category": "bakery",
  "district": "Karte Naw",
  "address": "Main Street",
  "phone": "0700000000"
}
```

---

## 🔄 System Flow

1. App launches
2. Categories are displayed
3. User selects a category
4. API request is sent
5. Services list is shown
6. User selects a service
7. Service details are displayed
8. User can directly call the service

---

## 💾 Data Handling

* Data is fetched from an API
* No user-generated data
* JSON-based structure
* Read-only system
* Easily extendable architecture

---

## 🚀 Future Work

* Real database integration
* Offline storage using SQLite
* Optional user system
* Maps and geolocation features
* Nationwide expansion

---

## 🧠 Advantages

* Simple and user-friendly
* No login required
* Fast and lightweight
* Easy to maintain
* Works in low-resource environments

---

## 🎓 Conclusion

The Local Services Super App offers a simple and effective solution for accessing essential services in Kabul. Its scalable architecture allows for future enhancements such as offline support, maps integration, and nationwide expansion.
=======
# local_servieces

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
>>>>>>> 7903b77 (Initial commit)
