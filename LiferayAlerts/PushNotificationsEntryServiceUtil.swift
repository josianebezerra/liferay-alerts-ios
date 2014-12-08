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

	class func addComment(alert: Alert, comment: String) {
		var callback: LRCallback = AddCommentCallback(alert: alert)

		var service: LRPushnotificationsentryService_v62 = getService(callback)

		var payload: [String: AnyObject] = [
			"message": comment
		]

		var json: String = JsonUtil.toString(payload)

		var error: NSError?

		service.addPushNotificationsEntryWithParentPushNotificationsEntryId(
			Int64(alert.alertId.integerValue), payload: json, error: &error)
	}

	class func getComments(alertId: Int) {
		var callback: LRCallback = GetCommentsCallback()

		var service: LRPushnotificationsentryService_v62 = getService(callback)

		var error: NSError?

		service.getPushNotificationsEntriesWithParentPushNotificationsEntryId(
			Int64(alertId), lastAccessTime:0, start:-1, end:-1, error:&error)
	}

	class func likeAlert(alertId: Int, like: Bool) {
		var callback: AddLikeCallback = AddLikeCallback(
			alertId: alertId, like:like)

		var service: LRPushnotificationsentryService_v62 = getService(callback)

		var error: NSError?

		if (like) {
			service.likePushNotificationsEntryWithPushNotificationsEntryId(
				Int64(alertId), error:&error)
		}
		else {
			service.unlikePushNotificationsEntryWithPushNotificationsEntryId(
				Int64(alertId), error:&error)
		}
	}

	class func getService(callback: LRCallback)
		-> LRPushnotificationsentryService_v62 {

		var session: LRSession = SettingsUtil.getSession()
		session.callback = callback

		return	LRPushnotificationsentryService_v62(session:session)
	}

}