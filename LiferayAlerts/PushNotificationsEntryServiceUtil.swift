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
class PushNotificationsEntryServiceUtil {

	class func likeAlert(alertId: Int, like: Bool) {
		var session: LRSession = SettingsUtil.getSession()

		var callback: AddLikeCallback = AddLikeCallback(
			alertId: alertId, like:like)

		session.callback = callback

		var service: LRPushnotificationsentryService_v62 =
			LRPushnotificationsentryService_v62(session:session)

		var error: NSError?

		if (like) {
			service.likePushNotificationsEntryWithPushNotificationsEntryId(
				Int64(alertId), error:&error)
		}
		else {
			service.dislikePushNotificationsEntryWithPushNotificationsEntryId(
				Int64(alertId), error:&error)
		}
	}

}