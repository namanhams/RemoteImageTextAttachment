//
//  AppDelegate.swift
//  AttributedStringRemoteImage
//
//  Created by Hoang Le Pham on 22/11/2020.
//  Copyright © 2020 Pham Le. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  private var window: UIWindow!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = ViewController()
    window.makeKeyAndVisible()
    return true
  }
}

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    view.backgroundColor = .white
    let label = UILabel()
    label.backgroundColor = .green
    label.translatesAutoresizingMaskIntoConstraints = false
    label.frame = CGRect(x: 0, y: 0, width: 1000, height: 200)
    label.textAlignment = .left
    label.attributedText = {
      let s = NSMutableAttributedString(string: "Hello")
      let attachment = RemoteImageTextAttachment(imageURL: url, displaySize: CGSize(width: 30, height: 30))
      attachment.label = label
      s.append(NSAttributedString(attachment: attachment))
      return s
    }()
    view.addSubview(label)
    
    let textView = UITextView()
    textView.backgroundColor = .red
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.frame = CGRect(x: 0, y: 200, width: 1000, height: 200)
    textView.attributedText = {
      let s = NSMutableAttributedString(string: "Hello")
      let attachment = RemoteImageTextAttachment(imageURL: url)
      s.append(NSAttributedString(attachment: attachment))
      return s
    }()
    view.addSubview(textView)
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

let  url = URL(string: "https://www.cloudflare.com/img/learning/security/glossary/what-is-https/not-secure.png")!
