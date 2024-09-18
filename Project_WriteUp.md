> Overview :- 

This To-Do List app was designed with a focus on user experience and functionality, employing modern development practices with Flutter and GetX for state management.The primary goal was to create a user-friendly and efficient task management system that includes essential features like task creation, editing, deletion, sorting, and notifications. Here’s a detailed explanation of the design decisions and thought process that guided the development of the app.

> Design Decisions :- 

1. State Management with GetX :- 

- Why GetX?: GetX was chosen for its simplicity and efficiency in managing state and dependencies. Its reactive programming model aligns well with Flutter’s declarative UI approach, enabling seamless updates to the UI in response to state changes.

- TaskController: This controller manages tasks, including their creation, updating, deletion, and filtering based on search queries. It also handles sorting tasks by different criteria and integrates with notification services to remind users of upcoming deadlines.

2. Task Management Features :-

- Task Creation and Editing: The EditTaskPage was designed to accommodate both task creation and editing. By using text fields for titles and descriptions, a date picker for due dates, and a dropdown for priority levels, users can easily input and modify task details. This page is accessible from the TaskListPage for a smooth user workflow.

- Task Deletion: Tasks can be deleted with a confirmation dialog to prevent accidental removals. This feature is crucial for maintaining task accuracy and user control over their to-do list.

3. UI/UX Considerations :- 

- ListView Display: Tasks are displayed in a ListView with a card layout to improve readability and aesthetics. Each task card shows the title, description, due date, and a checkbox to mark tasks as completed. This layout ensures that users can quickly scan through their tasks and understand their details at a glance.

- Sorting and Filtering: Users can sort tasks based on priority, due date, or creation date using a PopupMenuButton in the app bar. This flexibility allows users to view their tasks in a way that best suits their needs. Filtering tasks by search queries is also supported, enhancing the app’s usability.

4. Custom UI Elements :- 

- AppBar Design: A custom ClipPath is used to create a visually appealing, rounded bottom app bar. This design choice adds a touch of modernity and helps the app stand out.

- Date Picker: For selecting due dates, a showDatePicker dialog was implemented to provide a standard and user-friendly way to choose dates.

5. Notifications :-

- Integration: Notifications are scheduled and managed through the NotificationService. This ensures that users receive timely reminders about upcoming tasks, improving task management and adherence to deadlines.

6. Error Handling and User Feedback :- 

- Validation: When saving a task, the app ensures that essential fields like the title and due date are provided. Users are prompted with error messages if these fields are empty, preventing incomplete task entries.

- Feedback Mechanisms: Snackbar messages and dialog prompts provide clear feedback and confirmation options to users, enhancing the app’s usability and user experience.



> Conclusion :-

This To-Do List app is designed to be both functional and user-friendly, incorporating features and design elements that cater to real-world task management needs. By leveraging Flutter’s capabilities and GetX’s efficient state management, the app provides a smooth and responsive user experience. The thoughtful integration of sorting, filtering, and notifications ensures that users can manage their tasks effectively and stay organized.