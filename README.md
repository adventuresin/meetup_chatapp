# meetup_chatapp

A Chat App for Adventures in Flutter.

## Missing Files

### Firebase Config

Get `GoogleService-Info.plist` and `google-services.json` from the [Shared Project Folder](https://drive.google.com/drive/folders/1URxuILxk8NR66DIRbuERFDXIILCX6jM2?usp=sharing)

Add them to your project at:

- `ios/Runner/GoogleService-Info.plist`
- `android/app/google-services.json`

## Misc Tips

### ios

#### clean script

Useful when expereinceing weirness with Run / Debug

``` sh
cd ios/; rm -rf ~/Library/Caches/CocoaPods Pods ~/Library/Developer/Xcode/DerivedData/*; pod deintegrate; pod setup; pod install;
```
