# MAG
Seminar project for RS II college subject.

### Setup Instructions
1. Open a terminal inside the solution folder.
2. Run the following commands:</br>
- set STRIPE_SECRET_KEY=YourSecretKey </br>
- docker-compose up -d --build


## Flutter Desktop

### Credentials
- **Username:** desktop
- **Password:** test


### Setup Instructions
Run the following commands:
</br>
- flutter clean </br>
- flutter pub get </br>
- flutter run


### Note
- Choose option number 1 (windows) when prompted.

---

## Flutter Mobile

### Credentials
- **Username:** mobile
- **Password:** test


### Setup Instructions
Run the following commands:
</br>
- flutter clean </br>
- flutter pub get </br>
- flutter run

### Using Stripe Keys
- If you want to use your own Stripe keys, use the following commands: </br>

**Mobile app**
flutter run --dart-define=STRIPE_PUBLISHABLE_KEY=YourPublishableKey

**Backend**
set STRIPE_SECRET_KEY=YourKey </br>
docker-compose up -d --build

### Stripe Test Card Number
- Test card number: 4242 4242 4242 4242

## Additional Notes
- Emails are sometimes received in the spam folder of the gmail account.



