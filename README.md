SwiftUI News App

A modern News App built with SwiftUI that fetches articles from NewsAPI.org, allows users to view details, save favorites offline, and handle connectivity gracefully.

Features

News List View

Displays a scrollable list of news articles.

Each article shows:

Thumbnail image

Title

Published date

Article Detail Page

Tap an article to view full content.

Displays a large header image.

Shows detailed content.

Favorite Functionality

Toggle a "Favorite" button (star icon) to mark/unmark articles.

Favorite articles are stored offline using Core Data.

Saved Articles Screen

Lists all favorite articles.

Accessible via a separate tab.

Offline Handling

Detects network status.

Displays fallback UI/messages when offline.

State Management

Built with SwiftUI using @StateObject, @Published, and ObservableObject.

Good Design

Clean, modern SwiftUI interface.

Responsive layouts on all iOS devices.
