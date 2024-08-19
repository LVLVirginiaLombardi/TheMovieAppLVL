# Movies App

- Single Responsibility Principle:

  The single responsibility principle (SRP) states that a class should have only one reason to change, meaning it should have only one job or responsibility. The purpose of SRP is to     reduce the complexity of a system by ensuring that each class or module is focused on a single aspect of the functionality, making the codebase easier to maintain, test, and            understand.
  
- Characteristics of Good or Clean Code:

  In my opinion, good code is:
  
  - Readable: Easy to understand by other developers.
  - Maintainable: Easy to modify or extend.
  - Testable: Structured in a way that allows for comprehensive unit testing.
  - Efficient: Optimized for performance without premature optimization.
  - Adheres to SOLID Principles: Follows best practices for object-oriented design.
  
- Detailing Uncompleted Tasks:
 
  I aimed to make the app as simple yet functional as possible. However, the code needs to be made more reusable, adhere to best practices, and include unit tests. Additionally, the UI requires improvement, as it is quite basic. To enhance the project, 
  I should focus on refactoring the code for better modularity, adopting best practices for code organization and maintainability, and incorporating comprehensive unit tests to ensure reliability. Furthermore, refining the UI to make it more visually appealing and user-friendly while aligning with modern design standards is necessary.

- What did I do?

  In this project, I used SwiftUI for building the user interface, and for data persistence, I opted for UserDefaults instead of Core Data due to its complexities. For handling image loading efficiently, I utilized Kingfisher, which simplifies asynchronous image fetching and caching.
  Here’s a brief overview of the technologies and how they were used:
    * SwiftUI: For creating the user interface and managing state in a declarative manner.
    * UserDefaults: To persist simple data, such as storing and retrieving favorite movies.
    * Kingfisher: To load and cache images from URLs, ensuring efficient image handling and smooth user experience.
    I avoided Core Data because it introduced unnecessary complexity for this project, and UserDefaults was sufficient for the app’s data persistence needs.
    * YouTube iOS Player Helper: Added to the project to embed YouTube videos by wrapping the YTPlayerView in a UIViewRepresentable SwiftUI component. This approach facilitated video playback within the app and allowed for easy integration with the existing SwiftUI views.

