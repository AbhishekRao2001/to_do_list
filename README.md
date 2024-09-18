# to_do_list


## Overview

The To-Do List app is a modern task management application built with Flutter and GetX for state management. It allows users to efficiently manage their tasks, set priorities, and receive notifications for due dates. The app offers robust features including task creation, editing, sorting, and real-time search functionality.

# Features

- **Task Management**: Create, edit, and delete tasks with a title, description, due date, and priority.
- **Search Functionality**: Filter tasks by title or description in real-time.
- **Task Sorting**: Sort tasks by priority, due date, or creation date.
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

## Project Structure

- **lib/:** Contains the main source code of the app.
- **controllers/:** Contains task_controller.dart for managing tasks and state.
- **models/:** Contains task.dart for defining the task data model.
- **pages/:** Contains task_list_page.dart and edit_task_page.dart for the app’s UI.
- **utils/:** Contains notification_service.dart and storage_service.dart for handling notifications and data storage.
- **bindings.dart:** Contains the dependency injection setup for GetX.

