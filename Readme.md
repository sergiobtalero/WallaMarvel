# Wallapop iOS Tech Test

## Overview
This project is my implementation of Wallapop’s iOS Tech Test. It demonstrates my engineering approach, architectural thinking, and use of modern iOS development practices. Building on the provided Marvel App codebase, I enhanced it to meet all required objectives while introducing improvements in scalability, maintainability, and overall developer and user experience.

The app retrieves a list of superheroes from the Marvel API, displays them, allows to load more characters with pagination, supports filtering via a search bar, and allows users to navigate to a detail view for each hero.

---

## Objectives Completed

- **Show Hero Detail**: ✅
- **Pagination**: ✅
- **Search Bar**: ✅

---

## Architectural and Implementation Decisions

1. **Modularization**
   - The app is split into distinct modules: `Data` (API and networking) and `Domain` (business logic and models).
   - Modules are implemented as local Swift Packages to enforce boundaries and support reusability across projects.
   - This promotes separation of concerns, testability, and scalability. It also simplifies UI replacement or platform adaptation.

2. **Modern Concurrency**
   - `async/await` replaces callback-based data flows in the `Data` and `Domain` layers.
   - This aligns with Swift’s concurrency model, reducing complexity and improving readability.

3. **Generic Models**
   - Common Marvel API response patterns are handled using generics, enabling reuse across endpoints.
   - This reduces boilerplate and increases flexibility.

4. **Dependency Injection**
   - A `Composer` module acts as a factory to assemble dependencies and manage composition.
   - The UI module depends only on `Domain`, while `Composer` connects `Domain` and `Data`, respecting Clean Architecture principles.

5. **UI Reimplementation with SwiftUI**
   - Replaced UIKit and MVP with a SwiftUI-based UI layer.
   - This transition was made possible by the modular design; only the UI had to change.
   - SwiftUI enables a modern, declarative development style better suited to rapid iteration and scaling.

6. **State Management**
   - ViewModel logic handles view states explicitly using an internal enum to represent loading, success, error, and empty states.
   - This approach improves clarity in SwiftUI view updates and aligns with clean UI architecture practices.

7. **Coordinator Pattern**
   - Navigation is handled by a `MainCoordinator` class that manages screen transitions independently of view logic.
   - The design supports future extension to multiple flows (e.g., onboarding, authentication) via child coordinators or flow composition.

8. **Testing**
   - Adopted the new `Swift Testing` framework (available in Swift 5.9+) over XCTest to simplify assertions and improve test readability.
   - High unit test coverage in `Data` and `Domain`, particularly around use cases, model mapping, and error handling.
   - Also high unit test coverage for `Marvel`, (includes UI tests).

9. **Code Quality**
   - Applied SOLID principles to ensure clean, maintainable, and testable code.
   - Maintained consistent naming, organization, and encapsulation throughout.

10. **Security Considerations**
    - API keys are hardcoded in this technical test for simplicity.
    - In a real-world scenario, I would avoid bundling private API keys in the binary altogether. My approach includes:
      - **Development**: Keys are stored in `.xcconfig` files that are excluded from version control (`.gitignore`) and shared securely with developers.
      - **CI/CD**: Secrets are injected at build time using environment variables (e.g., via GitHub Actions or other CI tools) and passed to the compiler or build scripts.
      - **Production**: For sensitive operations or private keys (e.g., Marvel's private API key), I would strongly prefer routing API requests through a secure backend proxy. This removes the need for client-side storage of secrets and centralizes control over authentication, rate limiting, and analytics.

---

## Trade-offs and Prioritization

- **Security**: Keys are not secured to keep focus on architecture and features. Best practices for production are outlined but not implemented.
- **MVP Removal**: The original UIKit/MVP approach was replaced with SwiftUI and a simpler, use-case-driven structure. This better supports modularity and scalability in a SwiftUI context.

---

## How to Run

1. Clone the repository or unzip the provided file.
2. Open the project using the latest stable version of Xcode.
3. Build and run the app.

---

## Future Improvements

- Implement caching (e.g., via Core Data or NSCache) to improve performance and offline support.
- Fully secure API keys using best practices described above.

---

## Final Notes

This implementation reflects my emphasis on scalable architecture, modern iOS development, and clean, testable code. All test objectives—both required and optional—have been met. I look forward to discussing the design decisions and how they align with Wallapop’s engineering culture during the interview.
