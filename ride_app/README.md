# Ride App (Flutter) — Passenger / Admin

Dio + Riverpod + Hive দিয়ে বানানো একটা প্রফেশনাল, role-based Flutter অ্যাপ।

## আপনার API গুলো কীভাবে ব্যবহার হয়েছে

| # | Endpoint | ব্যবহৃত হয়েছে |
|---|----------|----------------|
| 1 | `POST /api/v1/auth/register` | Register screen → `AuthService.register()` |
| 2 | `POST /api/v1/auth/login` | Login screen → `AuthService.login()` → token Hive-তে সেভ হয় |
| 3 | `GET /api/v1/auth/me` | App চালু হলে auto-login check, এবং Profile screen pull-to-refresh |
| 4 | `POST /api/v1/auth/me/profile-picture` | Profile screen এর camera icon → gallery থেকে ছবি বেছে multipart upload |
| 5 | `GET /api/v1/auth/me/profile-picture/preview` | Profile avatar এ `Image.network` + Authorization header দিয়ে render |

## শুরু করার আগে যা করতে হবে

1. **Base URL বসান**
   `lib/core/constants/api_constants.dart` ফাইলে:
   ```dart
   static const String baseUrl = "https://your-api-domain.com";
   ```
   এখানে আপনার আসল backend URL বসান।

2. **Dependencies install করুন**
   ```bash
   cd ride_app
   flutter pub get
   ```

3. **Android internet permission**
   `android/app/src/main/AndroidManifest.xml` এর `<manifest>` ট্যাগের ভেতরে (application ট্যাগের বাইরে):
   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   ```
   (রেফারেন্স হিসেবে `android/app/src/main/AndroidManifest_permissions_snippet.txt` ফাইলে দেওয়া আছে)

4. **iOS হলে** (image picker এর জন্য) `ios/Runner/Info.plist` এ যোগ করুন:
   ```xml
   <key>NSPhotoLibraryUsageDescription</key>
   <string>প্রোফাইল ছবি আপলোড করার জন্য গ্যালারি অ্যাক্সেস প্রয়োজন</string>
   ```

5. **Run করুন**
   ```bash
   flutter run
   ```

## আর্কিটেকচার

```
lib/
  core/
    constants/api_constants.dart     → endpoints + role constants
    network/dio_client.dart          → shared Dio + auth interceptor
    storage/hive_storage.dart        → token/user persistence
    theme/app_theme.dart             → professional color/typography
  models/user_model.dart             → API response এর সাথে ম্যাপিং
  services/auth_service.dart         → সবগুলো API call (register/login/me/upload/preview)
  providers/auth_provider.dart       → Riverpod StateNotifier (single source of truth)
  screens/
    splash/       → auto-login + role-based routing
    auth/          → login_screen.dart, register_screen.dart
    profile/       → profile_screen.dart (view/upload/preview)
    admin/         → admin_home_screen.dart (bottom nav)
    passenger/     → passenger_home_screen.dart (bottom nav)
  widgets/         → reusable CustomTextField, CustomButton
  utils/validators.dart
```

## Role-based flow

- Register করার সময় user **Passenger** অথবা **Admin** বেছে নেয়।
- Login সফল হলে `/auth/login` response এর `user.role` অনুযায়ী app স্বয়ংক্রিয়ভাবে
  `AdminHomeScreen` অথবা `PassengerHomeScreen` এ নিয়ে যায় (SplashScreen এ এই লজিক আছে)।
- App পুনরায় খুললে Hive-তে সেভ করা token দিয়ে `/auth/me` কল করে auto-login হয়।

## পরবর্তী ধাপ (আপনার প্রয়োজন অনুযায়ী)

- Admin এর জন্য users list / booking management API যোগ হলে `admin_home_screen.dart`
  এর `_AdminUsersTab` অংশে বসাবেন।
- Passenger এর জন্য ride booking API যোগ হলে `passenger_home_screen.dart`
  এর `_PassengerBookTab` এ বসাবেন।
- 401 পেলে auto-logout করতে চাইলে `dio_client.dart` এর `onError` interceptor এ লজিক যোগ করুন।
