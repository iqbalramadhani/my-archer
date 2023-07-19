# myarchery_enterprise

MyArchery Enterprise

## Getting Started

Notes:
- Every changes (add / rename) in assets folder run "flutter pub run build_runner build --delete-conflicting-outputs"
- Every changes in model usin json_serialize run "pub run build_runner build --delete-conflicting-outputs"

For RUN / Compile App
- use --no-sound-null-safety as run args, if not will be fail


For Build APK / AppBundle
- run on terminal "flutter build apk -t lib/main_dev.dart --no-sound-null-safety" when need apk, or "flutter build appbundle -t lib/main_dev.dart --no-sound-null-safety" when need aab for staging
- run on terminal "flutter build apk -t lib/main_prod.dart --no-sound-null-safety" when need apk, or "flutter build appbundle -t lib/main_prod.dart --no-sound-null-safety" when need aab for production


