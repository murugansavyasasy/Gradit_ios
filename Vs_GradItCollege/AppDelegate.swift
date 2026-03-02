//
//  AppDelegate.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 27/10/22.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import AWSCore
import FirebaseCrashlytics
//import Firebase
// import SwiftJWT
import AVFAudio


@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate  {
    
//    struct MyClaims: Claims {
//        let iss: String
//        let scope: String
//        let aud: String
//        let iat: Date
//        let exp: Date
//    }
//    
   

    var DeviceToken : String!

        var window: UIWindow?
    

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            
            window?.overrideUserInterfaceStyle = .light
            

            FirebaseApp.configure()

            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
//            getAccessToken()
            if #available(iOS 10.0, *) {

                        // For iOS 10 display notification (sent via APNS)

                        UNUserNotificationCenter.current().delegate = self

            

                        let authOptions: UNAuthorizationOptions = [.alert, .badge,.sound]

                        UNUserNotificationCenter.current().requestAuthorization(

                            options: authOptions,

                            completionHandler: {_, _ in })

                    } else {

                        let settings: UIUserNotificationSettings =

                        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)

                        application.registerUserNotificationSettings(settings)

                    }

                    application.registerForRemoteNotifications()

                    Messaging.messaging().delegate = self

            return true

        }



    
   
//    func getAccessToken() {
//        // Path to the service account key JSON file
//        let filePath = Bundle.main.path(forResource: "service_account_key", ofType: "json")
//        guard let filePath = filePath else {
//            print("Service account file not found")
//            return
//        }
//        
//        // Load the Service Account JSON
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
//            let serviceAccount = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//            
//            guard let clientEmail = serviceAccount["client_email"] as? String,
//                  let privateKeyPem = serviceAccount["private_key"] as? String else {
//                print("Service account fields are missing")
//                return
//            }
//
//            // Convert the private key PEM string into Data format
//            let privateKeyData = convertPEMToData(pemString: privateKeyPem)
//            
//            // Create the JWT payload (iat and exp)
//            let iat = Date()
//            let exp = Date(timeIntervalSinceNow: 3600) // Token valid for 1 hour
//            
//            let claims = MyClaims(
//                iss: clientEmail,
//                scope: "https://www.googleapis.com/auth/firebase.messaging",
//                aud: "https://oauth2.googleapis.com/token",
//                iat: iat,
//                exp: exp
//            )
//            
//            // Create JWT header and sign it with the private key
//            var jwt = JWT(claims: claims)
//            let jwtSigner = JWTSigner.rs256(privateKey: privateKeyData) // Use Data instead of String
//            
//            guard let signedJWT = try? jwt.sign(using: jwtSigner) else {
//                print("Error signing JWT")
//                return
//            }
//            
//            // Prepare the request to exchange JWT for OAuth 2.0 token
//            let url = URL(string: "https://oauth2.googleapis.com/token")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            
//            // Set the request body
//            let bodyString = "grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=\(signedJWT)"
//            request.httpBody = bodyString.data(using: .utf8)
//            
//            // Send the request
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                guard let data = data, error == nil else {
//                    print("Error in network request: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                
//                do {
//                    // Parse the response JSON
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                       let accessToken = json["access_token"] as? String {
//                        print("Access Token: \(accessToken)")
//                    } else {
//                        print("Failed to parse access token from response")
//                    }
//                } catch {
//                    print("Error parsing response: \(error.localizedDescription)")
//                }
//            }
//            task.resume()
//            
//        } catch {
//            print("Error loading service account JSON: \(error.localizedDescription)")
//        }
//    }

    // Helper function to convert PEM string to Data
    func convertPEMToData(pemString: String) -> Data {
        // Remove PEM headers and footers
        let cleanedKey = pemString
            .replacingOccurrences(of: "-----BEGIN PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "-----END PRIVATE KEY-----", with: "")
            .replacingOccurrences(of: "\n", with: "")
        
        // Decode base64 encoded string to Data
        guard let keyData = Data(base64Encoded: cleanedKey) else {
            fatalError("Failed to decode PEM string to Data")
        }
        return keyData
    }
        // MARK: UISceneSession Lifecycle



        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

            

            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)

        }



        func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

            

        }



        


        func application(_ application: UIApplication,

                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

            Messaging.messaging().apnsToken = deviceToken

//            deviceTok = deviceToken

            

        }



   
//
//        func userNotificationCenter(_ center: UNUserNotificationCenter,
//
//                                      willPresent notification: UNNotification) async
//
//            -> UNNotificationPresentationOptions {
//
//            let userInfo = notification.request.content.userInfo
//
//
//
//            // With swizzling disabled you must let Messaging know about the message, for Analytics
//
//            // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//
//
//            // ...
//
//
//
//            // Print full message.
//
//                
//                showCustomNotificationView(with: notification)
//                       
//                       // Decide what notification to show (banner, sound, etc.)
//                      
//            print(userInfo)
//
//
//
//            // Change this to your preferred presentation option
//
//            return [[.alert, .sound]]
//                
//                completionHandler([.sound])
//
//          }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           
        
        print("will Presentfvfevfevefvefwill Presentfvfevfevefvef")
        
        
           // Create a custom notification banner (example)
  
        completionHandler([.alert,.sound]) // Use .badge and .banner based on your need
       }

    
    
          func userNotificationCenter(_ center: UNUserNotificationCenter,

                                      didReceive response: UNNotificationResponse) async {

            let userInfo = response.notification.request.content.userInfo

//              Messaging.messaging().appDidReceiveMessage(userInfo)

            // ...



            // With swizzling disabled you must let Messaging know about the message, for Analytics

            // Messaging.messaging().appDidReceiveMessage(userInfo)



            // Print full message.
              
//              
              if let wavURLString = userInfo["wav_url"] as? String, let wavURL = URL(string: wavURLString) {
                          print("WAV File URL: \(wavURL)")

                          // Navigate to the specific view controller
                          navigateToViewController(with: wavURL)
                      }

            print("didReceivedidReceivedidReceive",userInfo)

          }











            func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

              print("Firebase registration token: \(String(describing: fcmToken))")


                DeviceToken = fcmToken
              let dataDict: [String: String] = ["token": fcmToken ?? ""]

              NotificationCenter.default.post(

                name: Notification.Name("FCMToken"),

                object: nil,

                userInfo: dataDict

              )

              // TODO: If necessary send token to application server.

              // Note: This callback is fired at each app startup and whenever a new token is generated.

            }





        func application(_ application: UIApplication,

                             didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async

              -> UIBackgroundFetchResult {

            

                  
                  if let wavURLString = userInfo["wav_url"] as? String, let wavURL = URL(string: wavURLString) {
                              print("WAV File URL: \(wavURL)")

                              // Navigate to the specific view controller
                              navigateToViewController(with: wavURL)
                          }

                         
                  
                  
              print("didReceiveRemoteNotification",userInfo)



              return UIBackgroundFetchResult.newData
                  
                  
                
                  

            }

    func navigateToViewController(with wavURL: URL) {
           
                print("URL: \(wavURL)")
                // Do something with the URL, such as opening it in a web view or playing the audio

        
        
        
        
        
        let vc = getCurrentViewController()
       
                                 let vcc = NotificationCallingscreen(nibName: nil, bundle: nil)
       
                       vcc.urlss = wavURL.absoluteString
                                 vcc.modalPresentationStyle = .fullScreen
       
                                 vc?.present(vcc, animated: true)

            }
//        
       
    func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
        
    }
        
//    func showCustomAlert(with content: UNNotificationContent) {
//           guard let window = UIApplication.shared.windows.first else { return }
//
//           // Create a semi-transparent background view
//           let backgroundView = UIView(frame: window.bounds)
//           backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//
//           // Create the alert view
//           let alertView = UIView(frame: CGRect(x: 20, y: window.frame.height / 2 - 100, width: window.frame.width - 40, height: 200))
//           alertView.backgroundColor = UIColor.white
//           alertView.layer.cornerRadius = 10
//
//           // Title label
//           let titleLabel = UILabel(frame: CGRect(x: 10, y: 20, width: alertView.frame.width - 20, height: 40))
//           titleLabel.text = content.title
//           titleLabel.textAlignment = .center
//           titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//           alertView.addSubview(titleLabel)
//
//           // Body label
//           let bodyLabel = UILabel(frame: CGRect(x: 10, y: 70, width: alertView.frame.width - 20, height: 40))
//           bodyLabel.text = content.body
//           bodyLabel.textAlignment = .center
//           bodyLabel.numberOfLines = 2
//           alertView.addSubview(bodyLabel)
//
//           // Accept button (green)
//           let acceptButton = UIButton(frame: CGRect(x: 10, y: 130, width: alertView.frame.width / 2 - 20, height: 40))
//           acceptButton.backgroundColor = UIColor.green
//           acceptButton.setTitle("Accept", for: .normal)
//           acceptButton.layer.cornerRadius = 5
//           acceptButton.addTarget(self, action: #selector(handleAcceptAction), for: .touchUpInside)
//           alertView.addSubview(acceptButton)
//
//           // Decline button (red)
//           let declineButton = UIButton(frame: CGRect(x: alertView.frame.width / 2 + 10, y: 130, width: alertView.frame.width / 2 - 20, height: 40))
//           declineButton.backgroundColor = UIColor.red
//           declineButton.setTitle("Decline", for: .normal)
//           declineButton.layer.cornerRadius = 5
//           declineButton.addTarget(self, action: #selector(handleDeclineAction), for: .touchUpInside)
//           alertView.addSubview(declineButton)
//
//           // Add alert view and background to window
//           window.addSubview(backgroundView)
//           window.addSubview(alertView)
//
//           // Add animation to alert view
//           alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//           alertView.alpha = 0
//           UIView.animate(withDuration: 0.5) {
//               alertView.transform = CGAffineTransform.identity
//               alertView.alpha = 1
//           }
//       }
//    
    
    

//       @objc func handleAcceptAction() {
//           print("Accept button clicked")
//           // Handle the accept action here (e.g., navigate to another view controller)
//
//           // Remove the alert view and background
//           removeAlertView()
//       }
//
//       @objc func handleDeclineAction() {
//           print("Decline button clicked")
//           // Handle the decline action here
//
//           // Remove the alert view and background
//           removeAlertView()
//       }
//
//       // Remove the alert view and background
//       func removeAlertView() {
//           if let window = UIApplication.shared.windows.first {
//               window.subviews.forEach { view in
//                   if view is UIView {
//                       view.removeFromSuperview()
//                   }
//               }
//           }
//       }
    
    
    
   }


    //MARK: -  UNUserNotificationCenterDelegate



    @available(iOS 10, *)



        func userNotificationCenter(_ center: UNUserNotificationCenter,

                                    didReceive response: UNNotificationResponse,

                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            
         

            completionHandler()

        }

        

      func userNotificationCenter(_ center: UNUserNotificationCenter,

                                  willPresent notification: UNNotification,

        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        NotificationCenter.default.post(name: Notification.Name.didReceiveNotification, object: nil)

        let userInfo = notification.request.content.userInfo

        print("will Presentfvfevfevefvef")

        print(userInfo)

    //    if let messageID = userInfo[gcmMessageIDKey] {

    //      print("Message ID: \(messageID)")

    //    }
          
          
//          showCustomAlert(with: notification.request.content)

        completionHandler([[.alert, .sound]])
          

      }

