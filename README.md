# House Split

Single-file PWA for splitting house expenses. Firestore + Google sign-in (same stack as `workout/`).

## Firebase setup
1. Firebase console → create project → **Firestore Database → Create**.
2. **Authentication → Sign-in method → Google → Enable**; add your hosting domain under Authorized domains.
3. **Project settings → Your apps → Web (`</>`)** → copy `firebaseConfig` into `FIREBASE_CONFIG` in `index.html`.
4. **Firestore → Rules** → paste `firestore.rules` (or `firebase deploy --only firestore:rules`).
5. Host it (GitHub Pages / `firebase deploy --only hosting`). Firebase doesn't work from `file://`.

## Data model
- `users/{uid}` → `{ name, email, houseId }`
- `houses/{houseId}` → `{ name, members[], names{uid:name} }` (houseId is the join code)
- `houses/{houseId}/expenses/{id}` → `{ desc, amount, payer, split[], date, by, settle? }`
