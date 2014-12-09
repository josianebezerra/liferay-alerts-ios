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

import Foundation

/**
 * @author Silvio Santos
 * @author Josiane Bezerra
 */
class SettingsUtil {

	class func getLogin() -> String? {
		return self._getPreference("login") as String?
	}

	class func getPassword() -> String? {
		return self._getPreference("password") as String?
	}

	class func getPortraitId() -> Int64 {
		return (self._getPreference("portraitId") as NSNumber).longLongValue
	}

	class func getServer() -> String {
		return "http://192.168.108.28:8080"
	}

	class func getUsername() -> String {
		return self._getPreference("username") as String
	}

	class func getUserUuid() -> String {
		return self._getPreference("uuid") as String
	}

	class func getSession() -> LRSession {
		let login: String? = self.getLogin()
		let password: String? = self.getPassword()

		return LRSession(
			server:getServer(), username:login, password:password)
	}

	class func isSignedIn() -> Bool {
		let login: String? = self.getLogin()
		let password: String? = self.getPassword()

		return !(Validator.isNull(login)) && !(Validator.isNull(password))
	}

	class func setCredentials(login: String, password: String) {
		self.setLogin(login)
		self.setPassword(password)
	}

	class func setLogin(login: String) {
		self._setPreference(login, key: "login")
	}

	class func setPassword(password: String) {
		self._setPreference(password, key: "password")
	}

	class func setPortraitId(portraitId: NSNumber) {
		self._setPreference(portraitId, key: "portraitId")
	}

	class func setUser(user: [NSObject: AnyObject]) {
		let firstName: String = user["firstName"] as String
		let lastName: String = user["lastName"] as String

		self.setUsername("\(firstName) \(lastName)")
		self.setPortraitId(user["portraitId"] as NSNumber)
		self.setUserUuid(user["uuid"] as String)
	}

	class func setUsername(username: String) {
		self._setPreference(username, key: "username")
	}

	class func setUserUuid(uuid: String) {
		self._setPreference(uuid, key: "uuid")
	}

	class func _getPreference(key: String) -> AnyObject? {
		var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

		return defaults.objectForKey(key)
	}

	class func _setPreference(object: AnyObject?, key: String) {
		var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

		defaults.setObject(object, forKey: key)
		defaults.synchronize()
	}

}