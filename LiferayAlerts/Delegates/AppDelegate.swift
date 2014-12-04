/**
 * Copyright (c) 2000-2014 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

/**
 * @author Silvio Santos
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(
		application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)
		-> Bool {

		let navigationController = UINavigationController(
			rootViewController: self._getRootViewController())

		navigationController.navigationBarHidden = true

		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window!.rootViewController = navigationController
		window!.makeKeyAndVisible()

		PushNotificationUtil.registerForNotifications()

		return true
	}

	func application(
		application: UIApplication,
		didFailToRegisterForRemoteNotificationsWithError error: NSError) {

		println(error.localizedDescription)
	}

	func application(
		application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {

		var token: String = PushNotificationsServiceUtil.getToken(deviceToken)

		PushNotificationsServiceUtil.addDevice(token);
	}

	func application(
		application: UIApplication,
		didReceiveRemoteNotification userInfo: [NSObject: AnyObject]) {

		PushNotificationUtil.handleNotification(userInfo)
	}

	func _getRootViewController() -> UIViewController {
		if (SettingsUtil.isSignedIn()) {
			return MainViewController()
		}
		else {
			return SignInViewController()
		}
	}

	var window: UIWindow?

}
