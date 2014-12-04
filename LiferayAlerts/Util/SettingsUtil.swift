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

	class func getLogin() -> String {
		return ""
	}

	class func getPassword() -> String {
		return ""
	}

	class func getServer() -> String {
		return "http://192.168.108.28:8080"
	}

	class func getSession() -> LRSession {
		return LRSession(
			server:getServer(), username:"test@liferay.com", password:"test")
	}

	class func isSignedIn() -> Bool {
		let login = self.getLogin()
		let password = self.getPassword()

		return !(Validator.isNull(login)) && !(Validator.isNull(password))
	}

}