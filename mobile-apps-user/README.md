# myarcher_archer

MyArchery Archer

## Getting Started

Notes:
- Every changes (add / rename) in assets folder run "flutter pub run build_runner build --delete-conflicting-outputs"
- Every changes in model usin json_serialize run "pub run build_runner build --delete-conflicting-outputs"


For Build APK / AppBundle
1. flutter clean
2. flutter pub get
3. run command below
- run on terminal "flutter build apk -t lib/main_dev.dart" when need apk, or "flutter build appbundle -t lib/main_dev.dart" when need aab for staging
- run on terminal "flutter build apk -t lib/main_prod.dart" when need apk, or "flutter build appbundle -t lib/main_prod.dart" when need aab for production


For Build for iOS
1. flutter clean
2. flutter pub get
3. open terminal in project path run 'cd ios', enter
4. run command 'pod install --repo-update'
5. back to root path of project
6. run command below
- run on terminal "flutter build ipa -t lib/main_dev.dart" when for staging
- run on terminal "flutter build ipa -t lib/main_prod.dart" when for production
- Download Apple Transport macOS app https://apps.apple.com/us/app/transporter/id1450874784
- Drag and drop the "build/ios/ipa/*.ipa" bundle into the Apple Transport
