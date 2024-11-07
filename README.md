# IndonesAI Android

An Indonesian AI assistant mobile app using Flutter and GPT-4o Mini model. The app provides a chat interface where users can interact with an AI assistant in Indonesian language.

## Features

- Chat interface with GPT-4o Mini model integration
- Indonesian language responses
- Text-to-Speech capability
- Firebase Authentication (anonymous)
- Firestore for message persistence
- Cloud Functions for secure API key management

## Setup

1. Clone the repository:

```bash
git clone https://github.com/aidanoss/IndonesAIandroid.git
cd IndonesAIandroid
```

2. Set up Firebase:

   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Authentication (Anonymous sign-in)
   - Enable Firestore Database
   - Enable Cloud Functions
   - Copy the Firebase configuration:
     - Rename `lib/core/config/firebase_config.template.dart` to `firebase_config.dart`
     - Replace placeholder values with your Firebase project configuration

3. Set up OpenAI API:

   - Get an API key from [OpenAI](https://platform.openai.com)
   - In Firebase Console, go to Project Settings > Service Accounts
   - Create a new Secret in Secret Manager named "OPENAI_API_KEY"
   - Store your OpenAI API key in this secret

4. Install dependencies:

```bash
flutter pub get
```

5. Deploy Firebase Functions:

```bash
cd functions
npm install
firebase deploy --only functions
```

6. Create Firestore indexes:

   - Go to Firebase Console > Firestore Database > Indexes
   - Add composite index for the messages collection:
     - Collection ID: messages
     - Fields to index:
       - userId (Ascending)
       - timestamp (Ascending)
       - **name** (Ascending)

7. Run the app:

```bash
flutter run
```

## Project Structure

```
lib/
├── core/                 # Core functionality
│   ├── config/          # Configuration files
│   ├── constants/       # App constants
│   ├── models/          # Data models
│   ├── providers/       # State management
│   ├── services/        # Business logic
│   └── theme/           # App theme
└── features/            # App features
    ├── chat/           # Chat functionality
    ├── help/           # Help screens
    ├── navigation/     # Navigation
    ├── profile/        # User profile
    ├── settings/       # App settings
    └── welcome/        # Welcome screens
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
