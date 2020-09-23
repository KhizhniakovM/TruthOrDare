//
//  AppDelegate.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 03.09.2020.
//

import UIKit
import Firebase
import FacebookCore
import FBSDKCoreKit
import FirebaseRemoteConfig
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var urlForFB: String?
    var remoteConfig: RemoteConfig?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow()
        addOneSignal(launchOptions: launchOptions)
        
        fetchFBID { (appID) in
            Settings.appID = appID
            Settings.appURLSchemeSuffix = appID
            
            DispatchQueue.main.async {
                ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
                AppLinkUtility.fetchDeferredAppLink { [weak self] (url, error) in
                    guard let self = self else { return }
                    if let error = error {
                        print("Received error while fetching deferred app link %@", error)
                    }
                    if let url = url {
                        self.urlForFB = url.absoluteString
                        self.checkAccess()
                        self.window?.makeKeyAndVisible()
                    } else {
                        self.checkAccess()
                        self.window?.makeKeyAndVisible()
                    }
                }
            }
        }
        return true
    }
    
    func fetchFBID(completion: @escaping (String) -> Void) {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig?.configSettings = settings
        
        remoteConfig?.fetchAndActivate { [weak self] status, error in
            guard let x = self?.remoteConfig?.configValue(forKey: "FBid").numberValue else { return }
            completion("\(x)")
        }
    }
    func addOneSignal(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        //Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        //START OneSignal initialization code
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: false]
        // Replace 'YOUR_ONESIGNAL_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "590d4d17-adc0-44bc-9b8a-b65eab179041",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        // The promptForPushNotifications function code will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 6)
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    func checkAccess() {
        if UserDefaults.standard.object(forKey: Keys.access) == nil || UserDefaults.standard.bool(forKey: Keys.access) == false {
            if let urlString = urlForFB {
                let webVC = WebViewController()
                webVC.url = urlString
                webVC.remoteConfig = remoteConfig
                window?.rootViewController = webVC
            } else {
                let webVC = WebViewController()
                webVC.remoteConfig = remoteConfig
                window?.rootViewController = webVC
            }
        } else {
            let view = RootViewController()
            let presenter = RootPresenter(view: view)
            view.presenter = presenter
            let nc = UINavigationController(rootViewController: view)
            nc.isNavigationBarHidden = true
            window?.rootViewController = nc
        }
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
      if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
        if (rootViewController.responds(to: Selector(("canRotate")))) {
          return .allButUpsideDown;
        }
      }
      return .portrait;
    }
    
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
      if (rootViewController == nil) { return nil }
      if (rootViewController.isKind(of: UITabBarController.self)) {
        return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
      } else if (rootViewController.isKind(of: UINavigationController.self)) {
        return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
      } else if (rootViewController.presentedViewController != nil) {
        return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
      }
      return rootViewController
    }
}

