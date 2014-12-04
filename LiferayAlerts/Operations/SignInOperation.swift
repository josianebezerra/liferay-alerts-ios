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
 * @author Josiane Bezerra
 */
class SignInOperation: NSOperation {

	init(login: String, password: String) {
		self.login = login
		self.password = password
	}

	override func main() {
		let session: LRSession = LRSession(
			server:SettingsUtil.getServer(), username:login, password:password)

		var error: NSError?

		let groupService: LRGroupService_v62 = LRServiceFactory.getService(
			LRGroupService_v62.self, session:session) as LRGroupService_v62

		let groups: NSArray? = groupService.getUserSites(&error)

		if (self._hasError(error)) {
			return
		}

		SettingsUtil.setCredentials(login, password: password)
	}

	func _hasError(error: NSError?) -> Bool {
		if (error == nil) {
			return false
		}

		super.cancel()

		return true
	}

	var login: String
	var password: String

}