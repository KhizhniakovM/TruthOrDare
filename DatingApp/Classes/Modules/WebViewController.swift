//
//  WebViewController.swift
//  DatingApp
//
//  Created by Max Khizhniakov on 07.09.2020.
//

import UIKit
import WebKit
import FirebaseRemoteConfig

class WebViewController: UIViewController {
    // MARK: - Properties
    var remoteConfig: RemoteConfig?
    var parameters: String?
    var url: String?
    
    // MARK: - UI
    lazy var webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let view = WKWebView(frame: .zero, configuration: configuration)
        return view
    }()

    // MARK: - Lifecycle
    override func loadView() {
        self.view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        canRotate()
        webView.navigationDelegate = self
        setupWebView()
        
        setRemoteConfig()
        fetchRemoteConfig { [weak self] in
            guard let self = self else { return }
            guard let url = self.url else { self.openURL(string: UserDefaults.standard.object(forKey: "validURL") as? String ?? "https://almanach.su/policy/"); print("\(UserDefaults.standard.object(forKey: "validURL") ?? "nil??")"); return }
            
            self.makeUrl(from: url) { [weak self] urlString in
                guard let self = self, let parameters = self.parameters else { return }
                UserDefaults.standard.set(String(parameters + urlString), forKey: "validURL")
                print("url = \(parameters)\(urlString)")
                self.openURL(string: parameters + urlString)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.isMovingFromParent) {
          UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    // MARK: - Methods
    private func setRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig?.configSettings = settings
    }
    private func fetchRemoteConfig(completion: @escaping () -> Void) {
        remoteConfig?.fetchAndActivate { [weak self] status, error in
            guard let self = self, error == nil else { return }
            self.parameters = self.remoteConfig?.configValue(forKey: "url").stringValue
            completion()
        }
    }
    private func openURL(string: String) {
        guard let url = URL(string: string) else { return }
        let request = URLRequest(url: url)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.webView.load(request)
        }
    }
    private func setupWebView() {
        let source = "function captureLog(msg) { window.webkit.messageHandlers.logHandler.postMessage(msg); } window.console.log = captureLog;"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        webView.configuration.userContentController.addUserScript(script)
        webView.configuration.userContentController.add(self, name: "logHandler")
    }
    private func makeUrl(from string: String, completion: @escaping (String) -> Void) {
        let urlString = string.lowercased()
        if let bundleID = Bundle.main.bundleIdentifier {
            if let range = urlString.range(of: bundleID.lowercased()) {
                if let range2 = urlString.range(of: "?") {
                    var phone = urlString[range.upperBound...range2.lowerBound]
                    phone.removeLast()
                    let split = String(phone).split(separator: "/")
                    var index = 1
                    var endUrl = ""
                    for item in split {
                        if index == split.count {
                            endUrl += "subid\(index)=" + item
                        } else {
                            endUrl += "subid\(index)=" + item + "&"
                            index += 1
                        }
                    }
                    completion(endUrl)
                } else {
                    let phone = urlString[range.upperBound...]
                    let split = String(phone).split(separator: "/")
                    var index = 1
                    var endUrl = ""
                    for item in split {
                        if index == split.count {
                            endUrl += "subid\(index)=" + item
                        } else {
                            endUrl += "subid\(index)=" + item + "&"
                            index += 1
                        }
                    }
                    completion(endUrl)
                }
            }
        }
    }
    @objc func canRotate() -> Void {}
}
// MARK: - Extensions
extension WebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let string = message.body as? String else { return }
        
        if string == "user_accepted_action" {
            UserDefaults.standard.set(true, forKey: Keys.access)
            let view = RootViewController()
            let presenter = RootPresenter(view: view)
            view.presenter = presenter
            let nc = UINavigationController(rootViewController: view)
            nc.isNavigationBarHidden = true
            nc.modalPresentationStyle = .fullScreen
            self.present(nc, animated: true, completion: nil)
        }
    }
}
