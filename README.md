Rakshak
Overview

This project is a safety application developed as a minor project during the course of Computer Engineering at NCIT. The Emergency SOS App is designed to provide a quick and efficient way for users to send distress signals, share their location, and make emergency calls to a pre-defined contact in critical situations.
Features

    1. SOS Button: A prominent SOS button on the app's interface triggers an emergency alert when pressed.

    2. Location Sharing: The app retrieves the user's current location and includes it in the emergency message for quick assistance.

    3. Emergency Contact Call: Users can designate one emergency contact within the app, and pressing the SOS button initiates a call to this contact.

    4. Customizable Message: Users can personalize the distress message sent to their emergency contact, providing additional information about the situation.

    5. Database Integration: SOS messages and user locations are securely stored in a database for historical reference and further analysis.

Technologies Used

    1. Programming Language: Flutter is used for ui elements. Firebase is used as a database. Mapbox is used for location purpose.

    2. Mobile Platform: Android/IOS

    3. Location Services: Utilizes the device's location services to fetch the user's current location.

    4. Messaging Services: Utilizes messaging services to send SOS messages.

    5. Calling Services: Implements calling services to connect with the designated emergency contact.

    6. Database: Integrates with a secure database system to store SOS messages and user locations.

Getting Started

To run the Emergency SOS App on your local machine, follow these steps:

    1. Clone the Repository:

    git clone https://github.com/VividSoda/Rakshak2.git

    2. Open in IDE:
    Open the project in your preferred integrated development environment (IDE) for Android development.

    3. Build and Run:
    Build and run the project on an Android emulator or a physical Android device.

    5. Configure Permissions:
    Make sure to grant the necessary permissions, such as location and contact access, for the app to function properly.

Usage

    1. Launch the App:
    Open the Emergency SOS App on your Android device.

    2. Set Emergency Contact:
    Navigate to the settings to set a designated emergency contact.

    3. Press SOS Button:
    In an emergency, press the prominent SOS button on the app's interface.

    4. Initiate Call:
    The app will initiate a call to the pre-defined emergency contact and send an SOS message with your current location.

#NOTE: The mapbox api that i had used has depreciated so make sure to use the new one if you want to integrate mapbox.