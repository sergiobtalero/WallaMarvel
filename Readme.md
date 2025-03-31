
# Wallapop iOS Tech Test

## Overview
This project is my implementation of Wallapop's iOS Tech Test, built to demonstrate my approach to software engineering, architecture, and modern iOS development practices. Starting from the provided Marvel App codebase (using MVP and Clean Architecture with UIKit), I’ve evolved the app to meet all required objectives while introducing significant improvements to scalability, maintainability, and developer experience.

The app fetches a list of superheroes from the Marvel API, displays them with pagination, includes a search bar for filtering, and allows navigation to a detailed view for each hero.

## Objectives Completed
- **Show Hero Detail**: Tapping a superhero navigates to a new screen displaying detailed information (e.g., name, description, comics, series). This is powered by new HTTP requests to Marvel API endpoints.
- **Pagination**: Reaching the bottom of the list triggers additional HTTP requests to load more superheroes, ensuring all heroes can be listed.
- **Search Bar**: Added a search bar above the list to filter superheroes by name in real-time, enhancing user experience.

## Architectural and Implementation Decisions
1. **Modularization**:
   - Split the app into separate packages: `Data` (networking and API logic) and `Domain` (business logic and models).
   - This improves separation of concerns, reusability, and testability while making it easier to swap implementations or UI frameworks.

2. **Modern Concurrency**:
   - Replaced closure-based data passing with `async/await` in the `Data` and `Domain` layers.
   - This modernizes the codebase, improves readability, and reduces callback hell, aligning with Swift’s concurrency model.

3. **Generic Models**:
   - Updated models to use generics, enabling reuse across different API responses (e.g., hero list and hero details).
   - This reduces code duplication and enhances flexibility.

4. **Dependency Injection**:
   - Introduced a `Composer` package with a factory to manage dependencies.
   - The main module only imports `Domain`, while `Composer` bridges `Data` and `Domain`, preserving Clean Architecture principles.
   - This approach simplifies testing and ensures loose coupling.

5. **UI Overhaul with SwiftUI**:
   - Replaced UIKit and UITableView with SwiftUI, starting a new project for the UI layer.
   - Thanks to modularization, this transition was seamless—only the UI needed reimplementation, while `Data` and `Domain` remained intact.
   - SwiftUI offers a more modern, declarative approach, improving scalability and developer productivity over MVP/UIKit.

6. **Testing**:
   - Adopted `Swift Testing` instead of XCTest for a more modern testing experience.
   - Achieved high code coverage in `Data` and `Domain` layers, focusing on unit tests for API calls, model mapping, and business logic.

7. **Code Quality**:
   - Followed SOLID principles for clean, maintainable, and testable code.
   - Emphasized readability and organization with clear package boundaries and consistent naming.

8. **Security Considerations**:
   - Currently, the Marvel API keys are hardcoded for simplicity in this test environment (Public Key: `d575c26d5c746f623518e753921ac847`, Private Key: `188f9a5aa76846d907c41cbea6506e4cc455293f`).
   - In a production setting, I would secure these keys by:
     - Storing them in a `.xcconfig` file or environment variables, excluded from version control via `.gitignore`.
     - Using the Keychain for runtime storage and retrieval on iOS.
     - Implementing an additional layer of encryption if keys need to be bundled securely.
   - This is an area I’d prioritize for a real-world app to mitigate exposure risks.

## Trade-offs and Prioritization
- **UI Polish**: The SwiftUI implementation is functional but could benefit from additional refinement (e.g., animations, layout tweaks). I prioritized architecture and core functionality over UI polish.
- **Security**: Hardcoded API keys were retained for this test to focus on architecture and features. A production-ready security solution is outlined above but not implemented here.
- **MVP Removal**: While the original app used MVP, I found it less suitable for a SwiftUI-based project and harder to scale in a modern context, so I opted for a simpler, use-case-driven approach.

## How to Run
1. Clone the repository or unzip the provided file.
2. Open the project in the latest stable version of Xcode.
3. Build and run the app.

## Future Improvements
- Enhance SwiftUI views with animations and better error handling UX.
- Expand test coverage to include UI and integration tests.
- Implement caching (e.g., using Core Data or a lightweight solution) to improve performance and offline support.
- Fully secure API keys as described in the security section.

## Final Notes
This implementation reflects my focus on modern iOS practices, scalability, and clean architecture. I completed all objectives (must and should) while showcasing my engineering approach, with the exception of production-level security, which I’ve outlined for discussion. I’m excited to discuss my decisions and explore how they align with Wallapop’s engineering goals during the interview!
