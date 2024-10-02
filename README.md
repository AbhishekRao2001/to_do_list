# to_do_list


## Overview

The To-Do List app is a task management application built using Flutter and GetX for state management. This app allows users to manage tasks efficiently, set priorities, and receive notifications when tasks are due. The app uses Hive for persistent local storage, ensuring tasks are saved even after the app is closed.

# Features

- **Task Management**: Create, edit, and delete tasks with a title, description, due date, and priority.
- **Search Functionality**: Filter tasks by title or description in real-time.
- **Task Sorting**: Sort tasks by priority, due date, or creation date.
- **Local Storage with Hive**: All tasks are stored locally using Hive, ensuring data persistence without an internet connection.
- **Notifications**: Receive notifications for tasks based on their due dates.
- **Custom UI**: A visually appealing and user-friendly interface with a custom AppBar design.

## Installation

# To-Do List App

## Prerequisites

Before you start, make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Visual Studio Code](https://code.visualstudio.com/)

## Clone the Repository

git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name

## Install Dependencies

flutter pub get

## Usage

1. **Run the App:** Start the app on an emulator or physical device.
2. **Create and Manage Tasks:** Use the app to add, edit, or delete tasks. Set priorities and due dates as needed.
3. **Search and Sort Tasks:** Use the search bar to filter tasks and the sort options to organize them according to your preference.
4. **Notifications:** Grant notification permissions when prompted to receive reminders for upcoming tasks.
5. **Persistent Local Storage:** Tasks are saved locally using Hive, ensuring they persist across app sessions.

## Project Structure

- **lib/:** Contains the main source code of the app.
- **controllers/:** Contains task_controller.dart for managing tasks and state.
- **models/:** Contains task.dart for defining the task data model.
- **pages/:** Contains task_list_page.dart and edit_task_page.dart for the app’s UI.
- **utils/:** Contains notification_service.dart and storage_service.dart for handling notifications and data storage.
- **bindings.dart:** Contains the dependency injection setup for GetX.

