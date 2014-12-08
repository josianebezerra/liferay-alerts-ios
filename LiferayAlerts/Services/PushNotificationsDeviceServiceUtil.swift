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
class PushNotificationsServiceUtil {

	class func addDevice(token: String) {
		var server: String = SettingsUtil.getServer()
		var callback: AddPushNotificationDeviceCallback =
		AddPushNotificationDeviceCallback()

		var session: LRSession = LRSession(server:server, callback:callback)

		var service: LRPushnotificationsdeviceService_v62 =
		LRPushnotificationsdeviceService_v62(session:session)

		var error: NSError?

		service.addPushNotificationsDeviceWithToken(
			token, platform:"apple", error:&error)
	}

	class func getToken(tokenData: NSData) -> String {
		var token: String = tokenData.description

		var set: NSCharacterSet = NSCharacterSet(charactersInString:"<>")
		token = token.stringByTrimmingCharactersInSet(set)
		token = token.stringByReplacingOccurrencesOfString(" ", withString:"")

		return token
	}

}
