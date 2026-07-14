# 🌦️ Umbrella - Weather Forecast App

Umbrella is a modern iOS weather application built with **SwiftUI** that provides real-time weather information, hourly forecasts, and daily weather predictions for multiple cities. The app focuses on delivering a clean user experience with responsive UI, offline handling, and efficient state management.

## 📱 Features

### 🌍 Current Weather

* Display current weather conditions for selected cities
* Real-time temperature updates
* Weather descriptions and icons
* Wind speed, humidity, and atmospheric information

### 📅 Forecasts

* Hourly weather forecast
* Daily weather forecast
* Detailed weather information for each day
* Easy-to-read forecast timeline

### 🏙️ City Management

* Search and add cities
* Save favorite cities
* Switch between multiple locations
* Quick access to recently viewed cities

### 🌐 Network Handling

* Internet connectivity monitoring
* User-friendly error handling
* Offline state management
* Retry mechanism for failed requests

### 🎨 User Experience

* Clean and modern SwiftUI interface
* Dark Mode support
* Smooth animations and transitions
* Responsive design for different device sizes

## 🛠️ Technologies Used

* **Swift**
* **SwiftUI**
* **MVVM Architecture**
* **Async/Await**
* **URLSession**
* **Combine**
* **Network Framework**
* **OpenWeather API** (or your weather API)

## 🏗️ Architecture

The project follows the **MVVM (Model-View-ViewModel)** architecture pattern:

* **Model:** Represents weather data and business logic.
* **View:** SwiftUI screens and UI components.
* **ViewModel:** Handles state management and data preparation for views.
* **Service Layer:** Responsible for API communication and data fetching.

