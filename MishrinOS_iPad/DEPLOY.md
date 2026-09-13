# Deploy Mishrin OS to iPad

1. Create an iPadOS SwiftUI app in Xcode and add `Sources/MishrinOSApp.swift`.
2. Use a bundle identifier registered to your Apple Developer account and select your signing team.
3. Build and test on an iPad Simulator and an authorized physical iPad.
4. Archive and upload to App Store Connect for TestFlight/App Store distribution, or package for an authorized organizational MDM deployment.
5. Replace the placeholder `https://apps.apple.com/` in the Download / Update button with the actual App Store/TestFlight URL after publication.

Apple signing and distribution controls cannot be bypassed, and an ordinary app cannot replace iPadOS or force-install itself on arbitrary iPads.