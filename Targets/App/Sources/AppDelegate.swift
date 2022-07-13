import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    
    return true
  }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  
  // 3. 앱이 foreground상태 일 때, 알림이 온 경우 어떻게 표현할 것인지 처리
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
    // 푸시가 오면 alert, badge, sound표시를 하라는 의미
    completionHandler([.alert, .badge, .sound])
  }
  
  // push가 온 경우 처리
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    // deep link처리 시 아래 url값 가지고 처리
    let url = response.notification.request.content.userInfo
    print("url = \(url)")
    NotificationCenter.default.post(name: .home, object: nil)
    
    // if url.containts("receipt")...
  }
  
  private func registerForRemoteNotifications() {
    
    // 1. 푸시 center (유저에게 권한 요청 용도)
    let center = UNUserNotificationCenter.current()
    center.delegate = self // push처리에 대한 delegate - UNUserNotificationCenterDelegate
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    center.requestAuthorization(options: options) { (granted, error) in
      
      guard granted else { return }
      
      DispatchQueue.main.async {
        // 2. APNs에 디바이스 토큰 등록
        UIApplication.shared.registerForRemoteNotifications()
      }
    }
  }
  
  // 디바이스 토큰 등록 성공 시 실행되는 메서드
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
    print(deviceTokenString)
  }
  
  // FCM Swizzling disabled, device token appending to FCM
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    Messaging.messaging().apnsToken = deviceToken
  }
  
  // 디바이스 토큰 등록 실패 시 실행되는 메서드
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
  }
}

extension NSNotification.Name {
  static let home = NSNotification.Name("Home")
}
