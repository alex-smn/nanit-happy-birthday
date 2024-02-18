# Happy Birthday!

This application is designed to allow users to manage and display a birhday postcard with personal details, including name, birthday, and picture. The application is developed using SwiftUI and utilizes UserDefaults and FileManager for storing user data persistently. The minimum iOS version supported is 16.0+.

## Features

1. **Details Screen**:
    - Users can view and edit their personal details on this screen. Details will persist between app launches.
    - Elements displayed:
        - App title
        - Name (text)
        - Birthday (date picker)
        - Picture (can be selected from gallery or camera)
        - "Show birthday screen" button (disabled until name & birthday are provided)

2. **Birthday Screen**:
    - Users can access the birthday screen by tapping the "Show birthday screen" button.
    - Design follows the attached UI assets.
    - Screen logic:
        - Three visual options displayed randomly.
        - Birthdays shown by months until 1 year and then in years.
        - Correct age displayed according to the baby's birthday.
        - Title adjusts to occupy two lines if the name is too long.
        - Close button returns to the previous screen.
    - Users can change the picture by tapping the "Add camera" icon.
    - Prompt to choose a picture from the gallery or take a photo.
    - Selected picture replaces the default picture.

3. **Sharing the Screen**:
    - Users can press "Share the news" button to share the generated postcard without "close", "share" and "camera" buttons
    - Tapping the button opens the default share menu.

## Technologies Used
- MVVM architecture
- SwiftUI for layout
- UserDefaults and FileManager for storing user data

## Additional Notes
- For the picker, UIImagePicker is used as SwiftUI ImagePicker doesn't support camera source.

## How to Run
This application can be launched via Xcode on either a simulator or a physical iOS device.

### Running on Simulator
1. Open Xcode.
2. Open the project file (.xcodeproj).
3. Select a simulator device from the list of available devices.
4. Click on the "Run" button to build and run the application.

### Running on Physical Device
1. Connect your iOS device to your computer via USB cable.
2. Open Xcode.
3. Open the project file (.xcodeproj).
4. Select your connected iOS device from the list of available devices.
5. Click on the "Run" button to build and run the application on your device.

Ensure that you have the necessary provisioning profiles and certificates set up for running the application on a physical device.
