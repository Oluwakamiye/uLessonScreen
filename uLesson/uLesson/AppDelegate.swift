//
//  AppDelegate.swift
//  uLesson
//
//  Created by Oluwakamiye Akindele on 04/03/2021.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setApplicationColorTheme()
        try? AVAudioSession.sharedInstance().setCategory(
            AVAudioSession.Category.ambient,
            mode: AVAudioSession.Mode.moviePlayback,
            options: [.mixWithOthers])
        return true
    }
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    func setApplicationColorTheme() {
        let uLessonGray = RGB(237, 237, 238)
        // Application tintColor
        window?.tintColor = uLessonGray
        // Navigation bar background color
        UINavigationBar.appearance().barTintColor = uLessonGray
        // Make the back button black (instead of the global tintColor)
        UINavigationBar.appearance().tintColor = .black
        // Make the text in the navigation bar white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key(rawValue:
                    NSAttributedString.Key.foregroundColor.rawValue): UIColor.black]
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: "Itim", size: 24)!],
            for: UIControl.State.normal)
    }
    private func RGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
