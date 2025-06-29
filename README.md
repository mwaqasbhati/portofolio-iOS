# baraka-iOS

A sample portfolio viewer built with UIKit, RxSwift and the MVVM pattern. The app downloads a portfolio from `https://dummyjson.com/c/60b7-70a6-4ee3-bae8`, displays the balance and open positions and simulates live market prices.

## Features
- Fetch portfolio details from the remote JSON endpoint.
- Display net value, profit/loss and individual positions.
- Simulated real‑time price updates using RxSwift.
- English and Arabic localisation with automatic layout direction.
- Unit tests covering formatting helpers and network requests.
- Centralized theme for fonts and colors.

## Project Summary Table

- Platform	iOS (UIKit)
- Minimum iOS Version	13.0
- Architecture	MVVM + RxSwift
- Layout System	Programmatic UI using UICollectionViewCompositionalLayout and UITableView
- Reactive Framework	RxSwift
- Live Market Simulation	Simulates live price updates using Observable.interval
- Data Source	Dummy JSON
- Unit Tests	XCTest (basic coverage included)
- Language Support	English / Arabic with RTL alignment
- Localization Toggle	Toggle button with UISemanticContentAttribute updates


## APP Screenshots

# Dark Mode

|             English         |         Arabic          | 
|---------------------------------|------------------------------|
|![iOS_dark_en](https://github.com/user-attachments/assets/265a23cc-c063-4a28-97f9-4c30a23dde3e)|![iOS_dark_ar](https://github.com/user-attachments/assets/1b05bea3-e114-4693-9201-b342bb344038)|

# Light Mode

|             English         |         Arabic          | 
|---------------------------------|------------------------------|
|![iOS_light_en](https://github.com/user-attachments/assets/b3dfae59-04a6-413f-b533-4f1d66b6fa87)|![iOS_light_ar](https://github.com/user-attachments/assets/6aff4afa-df0d-429c-8090-85e39334a51d)|


## Project Structure

<img width="342" alt="Screenshot 2025-06-27 at 8 50 12 PM" src="https://github.com/user-attachments/assets/e680ac05-c8e4-4dd4-9bc0-fecf1bd75ff4" />



## Requirements
- Xcode 15 or later
- CocoaPods
- iOS 13+

## Installation
1. Clone the repository.
2. Run `pod install` to fetch dependencies.
3. Open `baraka-iOS.xcworkspace` and run the **baraka-iOS** scheme.

### Building from the command line
```bash
xcodebuild -workspace baraka-iOS.xcworkspace \
  -scheme "baraka-iOS" \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max,OS=18.0' \
  CODE_SIGNING_ALLOWED=NO \
  CODE_SIGNING_REQUIRED=NO \
  build
```

### Tests

<img width="323" alt="Screenshot 2025-06-27 at 9 05 20 PM" src="https://github.com/user-attachments/assets/338c6542-9cdd-4433-800b-be8dea44d737" />

## Theme
Fonts and colors are defined in `Theme.swift` and used throughout the app for a consistent look and feel.

## Screenshots

## License
baraka-iOS is available under the MIT license.
