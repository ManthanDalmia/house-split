# House Split

Personal PWA to log what you paid for, split it with flatmates (Ashish, Parth), and track what's not yet added to Splitwise. Firestore + Google sign-in, same stack as `workout/`.

## Firebase setup
1. https://console.firebase.google.com → **Add project** (Analytics not needed).
2. **Build → Firestore Database → Create database** → production mode, region `asia-south1` (Mumbai).
3. **Build → Authentication → Get started → Google → Enable** (pick a support email).
   **Settings → Authorized domains → Add** `manthandalmia.github.io`.
4. **Project settings → Your apps → Web (`</>`)** → register app → copy `firebaseConfig` into `FIREBASE_CONFIG` in `index.html`.
5. **Firestore → Rules** → paste `firestore.rules` → Publish.
6. Commit + push; open https://manthandalmia.github.io/house-split/ and sign in.

## iOS widget
Open the app → **iOS widget** section → copy the script into Scriptable (see on-page steps). The app keeps a read-only summary at `widgets/<random-secret>`; the widget reads it via the Firestore REST API.

## Data model
- `users/{uid}` → `{ widgetSecret }`
- `users/{uid}/expenses/{id}` → `{ amount, note, tag, date, owes{name:amt}, added, addedAt, createdAt }`
- `widgets/{secret}` → `{ owner, owed{}, pending, updatedAt }`
