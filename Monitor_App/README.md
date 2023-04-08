# Water Monitoring App

This is a water monitoring app written in Flutter that allows users to monitor the water and chlorine tank levels, as well as other stats such as pH and turbidity. The app connects to a local server (Monitor_Server) in the same repository to fetch the data.

## Features
- Realtime monitoring of water and chlorine tank levels.
- View pH and turbidity stats.
- Fetch data weekly, monthly, daily, or all.
- Connects to a local server (Monitor_Server) to fetch data.

## Requirements
- Flutter 2.0 or higher
- Monitor_Server (included in the same repository)

## Installation and Usage
- Clone the repository to your local machine.
- Open the project in your preferred IDE or editor.
- Run flutter pub get to install the required dependencies.
- Start the Monitor_Server by running node index.js in the terminal in the Monitor_Server directory.
- Run the app on an emulator or physical device using flutter run command in the terminal.

## Configuration
The app is currently configured to connect to the local server at <http://localhost:3000>. If you need to change this, update the SERVER_URL constant in the lib/utils/constants.dart file to the URL of your server.

## Contributing
Contributions to the project are welcome. If you find any bugs or want to suggest new features, please create an issue or submit a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
