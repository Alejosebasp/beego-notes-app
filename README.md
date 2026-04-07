# Beego Notes App

A minimalist Fullstack Notes application built with Go (Beego framework) and SQLite.

## Features
- **CRUD Operations**: Create, Read, Update, and Delete notes.
- **Search**: Search notes by title with a dedicated button.
- **Modern UI**: Dark theme (`#00253d`) with glassmorphism and responsive design.
- **SQLite Database**: Persistent storage for notes.

## Project Structure
- `models/`: Data models and DB logic using Beego ORM.
- `controllers/`: Request handlers.
- `routers/`: URL routing configuration.
- `views/`: Beego templates (.tpl) for the frontend.
- `conf/`: Application configuration.

## Prerequisites
- **Go** (1.24+ recommended)
- **Beego v2**

## Setup and Run
1. Clone the repository.
2. Run `go mod tidy` to install dependencies.
3. Start the application:
   ```bash
   go run main.go
   ```
4. Access the app at `http://localhost:8080`.

## Security Best Practices
- Local database (`notes.db`) is excluded from version control to prevent data leaks.
- Godoc-style documentation is included for all backend source code.
