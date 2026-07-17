# 📦 E-Commerce Online Store - Pure Dart Clean Architecture

A production-ready Showcase Project demonstrating the implementation of an E-Commerce backend core engine using **Pure Dart**, strictly adhering to **Object-Oriented Programming (OOP)**, **SOLID Principles**, and **Clean Architecture** patterns.

---

## 🚀 Project Overview & Requirements

This system simulates the core transaction lifecycle of a modern digital storefront satisfying the following client constraints:

- **Customer Capabilities:** Browse catalog products, build temporary shopping carts, and place formal orders.
- **Payment Adaptability:** Flexible settlement support supporting **Credit/Debit Cards**, **Digital Wallets**, and **Cash on Delivery (COD)**.
- **Automated Stock Control:** Instant secure deduction of item stock limits upon order validation.
- **Customer Communication:** Dispatches instant transactional confirmation emails post-settlement.
- **Administrative Supervision:** Provides localized hooks enabling administrators to trace (track) and instantly cancel existing orders.

---

## 🏗️ Architecture Design & Blueprint

The code layout is strictly isolated into three disconnected structural layers ensuring zero tight-coupling. Dependency flows strictly move **inward** toward the pure business core.

```text
lib/
│
├── domain/                         # Layer 01: Pure Core Enterprise Rules (No Frameworks)
│   ├── entities/                   # Encapsulated Domain Models with Immutable Specs
│   │   ├── product.dart            # Standard item model enforcing stock containment
│   │   ├── cart_item.dart          # Local context wrapping specific products with buying units
│   │   └── order.dart              # Lifecycle entity tracking transaction state transitions
│   │
│   ├── repositories/               # Abstract Boundary Contracts (DIP Interfaces)
│   │   ├── product_repository.dart # Abstract rules for fetching and updating inventory
│   │   ├── order_repository.dart   # Contract boundary for order queries/updates
│   │   ├── payment_gateway.dart    # Pluggable abstraction for processing money transfers
│   │   └── email_service.dart      # Communication contract for notifications
│   │
│   └── usecases/                   # Orchestrators executing application actions
│       ├── customer/
│       │   └── place_order_usecase.dart # High-level transactional order placement choreography
│       └── admin/
│           ├── track_order_usecase.dart    # Queries target orders using administrative criteria
│           └── cancel_order_usecase.dart   # Validates status rules and enforces cancellation
│
├── data/                           # Layer 02: Infrastructure Implementations
│   ├── repositories/               # Concrete realization of Domain Layer interfaces
│   │   ├── product_repository_impl.dart
│   │   └── order_repository_impl.dart
│   │
│   └── datasources/                # Integrations with low-level details (APIs / Storage)
│       ├── payment/                # CardPayment, WalletPayment, and CodPayment implementations
│       └── notification/           # SmtpEmailSender (Simulated network email gateway)
│
├── presentation/                   # Layer 03: System Interaction & Delivery
│   └── app.dart                    # Simulates interactive screen cycles for both workflows
│
└── main.dart                       # Composition Root (Constructs and injects concrete modules)
```
