# Flutter Assessment App - CodeBase Technology

This Flutter application was developed as an **assessment task** for **CodeBase Technology**.  
It is built specifically for **Android** and follows the principles of **Clean Architecture** for better scalability and maintainability.

---

## 🧩 Tech Stack & Architecture

- **Flutter** — Cross-platform UI framework  
- **Riverpod** — State management  
- **Firebase Authentication** — For user login and signup  
- **Firebase Firestore** — For storing user and task data  
- **Shared Preferences** — For local storage of user-related data  
- **Dartz** — For functional programming (`Either`, `Option`, etc.)  
- **Equatable** — For value comparison in entities and state classes  

---

## 🧱 Architecture Overview

The app is structured following **Clean Architecture**, separating responsibilities into distinct layers:

- **Presentation Layer** — UI widgets, providers, and notifiers  
- **Domain Layer** — Use cases and entities  
- **Data Layer** — Repositories, remote and local data sources  

This approach ensures a **testable, scalable, and maintainable** codebase.

---

## 🚀 Features

- Login and Signup using Firebase Authentication  
- User data stored in Firebase Firestore  
- Task data managed via Firestore  
- Persistent login session using Shared Preferences  
- Strongly typed and immutable state using Riverpod  
- Functional error handling using Dartz