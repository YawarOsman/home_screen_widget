# Crypto Price Widget 📱💰

A native iOS widget that displays real-time cryptocurrency prices (Bitcoin and Ethereum) on your home screen. The widget automatically fetches data from the OKX cryptocurrency exchange API and updates every minute to keep you informed of the latest market prices.

## Features ✨

- **Real-time Crypto Prices**: Displays current BTC and ETH prices in USDT
- **Automatic Updates**: Fetches fresh data every minute from OKX API
- **Clean UI**: Modern, minimalist design that fits seamlessly with iOS
- **Live Activity Support**: Includes Live Activity functionality for dynamic updates
- **Error Handling**: Graceful fallback when network requests fail

## Screenshots 📸

The widget displays:
- **Header**: "Crypto Prices 💰"
- **Bitcoin (BTC)**: Current price in USD
- **Ethereum (ETH)**: Current price in USD

## Technical Details 🔧

### Architecture
- **Widget Extension**: Built using WidgetKit framework
- **Data Source**: OKX cryptocurrency exchange API
- **Update Frequency**: Every 60 seconds (1 minute)
- **Supported Cryptocurrencies**: Bitcoin (BTC-USDT) and Ethereum (ETH-USDT)

### API Integration
- **Endpoint**: `https://www.okx.com/api/v5/market/tickers?instType=SPOT`
- **Data Format**: JSON response with ticker information
- **Error Handling**: Network failures gracefully handled with "N/A" fallback

### Project Structure
```
hom_widget/
├── hom_widget.swift          # Main widget implementation
├── hom_widgetBundle.swift    # Widget bundle configuration
├── CryptoService.swift       # API service for fetching crypto data
├── hom_widgetLiveActivity.swift # Live Activity implementation
└── Assets.xcassets/          # Widget assets and colors
```

## Requirements 📋

- **iOS**: 14.0 or later
- **Xcode**: 12.0 or later
- **Swift**: 5.0 or later
- **Network**: Internet connection required for data fetching

## Installation 🚀

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd home_widget
   ```

2. **Open in Xcode**:
   ```bash
   open testing_app.xcodeproj
   ```

3. **Build and Run**:
   - Select your target device or simulator
   - Press `Cmd + R` to build and run
   - The app will install on your device/simulator

4. **Add Widget to Home Screen**:
   - Long press on home screen
   - Tap the "+" button
   - Search for "My Widget" or "hom_widget"
   - Select widget size and add to home screen

## Configuration ⚙️

### Customizing Update Frequency
To change the update interval from 1 minute to 5 minutes, modify the timeline policy in `hom_widget.swift`:

```swift
// Change from 60 seconds to 300 seconds (5 minutes)
let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(300)))
```

### Adding More Cryptocurrencies
To add more cryptocurrencies, modify the `getTimeline` function in `hom_widget.swift`:

```swift
// Add more crypto pairs
let adaPrice = prices.first(where: { $0.instId == "ADA-USDT" })?.last ?? "N/A"
let solPrice = prices.first(where: { $0.instId == "SOL-USDT" })?.last ?? "N/A"
```

### Customizing Widget Appearance
Modify the `hom_widgetEntryView` in `hom_widget.swift` to change:
- Colors and fonts
- Layout and spacing
- Text formatting
- Background styling

## API Information 🌐

This widget uses the **OKX Exchange API**:
- **Base URL**: `https://www.okx.com/api/v5/market/tickers`
- **Method**: GET
- **Parameters**: `instType=SPOT`
- **Rate Limits**: Standard public API limits apply
- **Data Format**: JSON

### Sample API Response
```json
{
  "code": "0",
  "msg": "",
  "data": [
    {
      "instId": "BTC-USDT",
      "last": "45000.50"
    },
    {
      "instId": "ETH-USDT", 
      "last": "3200.75"
    }
  ]
}
```

## Troubleshooting 🔍

### Common Issues

1. **Widget Not Updating**:
   - Check internet connection
   - Verify API endpoint is accessible
   - Check Xcode console for error messages

2. **Prices Showing "N/A"**:
   - Network connectivity issues
   - API rate limiting
   - Invalid API response format

3. **Widget Not Appearing**:
   - Ensure iOS 14.0+ is installed
   - Check widget extension is properly embedded
   - Verify widget bundle configuration

### Debug Mode
Enable debug logging by checking the Xcode console for:
- Network error messages
- Decoding error details
- Timeline update confirmations

## Development 👨‍💻

### Building from Source
1. Ensure you have Xcode 12.0+ installed
2. Open `testing_app.xcodeproj`
3. Select your development team in project settings
4. Build and run on device or simulator

### Testing
- Use iOS Simulator for basic functionality testing
- Test on physical device for accurate widget behavior
- Verify network requests in Xcode Network Inspector

## Contributing 🤝

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License 📄

This project is open source and available under the [MIT License](LICENSE).

## Acknowledgments 🙏

- **OKX Exchange** for providing the cryptocurrency data API
- **Apple** for the WidgetKit framework
- **SwiftUI** for the modern UI framework

## Support 💬

If you encounter any issues or have questions:
- Open an issue on GitHub
- Check the troubleshooting section above
- Review Apple's WidgetKit documentation

---

**Note**: This widget fetches data every minute (not 5 minutes as initially mentioned). The update frequency can be easily modified in the code as described in the Configuration section.
