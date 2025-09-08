Notes and API App 
This Flutter project demonstrates a multi-featured application with local note-taking, API data fetching, and dynamic theming.

Project Setup
Install dependencies:
To get all the required packages, open your terminal in the project's root directory and run the following command:

flutter pub get

Add Android Internet Permission:
To allow the app to fetch data from the internet, you must add the internet permission to your Android manifest file. Open android/app/src/main/AndroidManifest.xml and insert the following line just before the closing </application> tag.

<uses-permission android:name="android.permission.INTERNET" />

Run the app:
With a device or emulator connected, you can launch the app using:

flutter run

Discussions
This app includes three main sections, accessible via the bottom navigation bar, to showcase different mobile development concepts:

Notes: A fully functional note-taking feature that persists data on the device. It includes the ability to add, edit, and delete notes, with a helpful "undo" option after deletion.

API Posts: This section demonstrates how to fetch data from a public API. It handles different UI states, showing a loading shimmer effect while the data is being fetched and a clear error message if the network request fails.

Theming: You can customize the app's appearance by toggling between light and dark modes. Additionally, you can change the primary color of the app from a set of predefined options, with your preferences being saved for future sessions.
