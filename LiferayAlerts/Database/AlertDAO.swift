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

import CoreData

/**
 * @author Silvio Santos
 */
class AlertDAO {

	class func get(alertId: Int) -> Alert? {
		var predicate: NSPredicate? = NSPredicate(
			format: "alertId = %d", alertId)

		var alerts: [Alert]? = _get(predicate)

		if ((alerts != nil) && (alerts!.count > 0)) {
			return alerts![0]
		}

		return nil
	}

	class func getAll() -> [Alert]? {
		return getChildren(0)
	}

	class func getChildren(parentAlertId: Int) -> [Alert]? {
		var predicate: NSPredicate? = NSPredicate(
			format: "parentAlertId = %d", parentAlertId)

		return _get(predicate)
	}

	class func insert(json: [NSObject: AnyObject]) {
		var alertId: String = json["pushNotificationsEntryId"] as String
		var parentAlertId: String = json["parentPushNotificationsEntryId"]
			as String

		var createTime: NSNumber? = json["createTime"] as? NSNumber

		var alertJsonObj: [NSObject: AnyObject] =
			json["aps"] as [NSObject: AnyObject]

		var userJson: [NSObject: AnyObject] =
			JsonUtil.parse(json["user"] as String)

		var user: User = UserDAO.createUser(userJson)

		alertJsonObj = alertJsonObj + JsonUtil.parse(json["payload"] as String)

		AlertDAO._insert(
			alertId.toInt()!, parentAlertId:parentAlertId.toInt()!,
			createTime:createTime, payload:alertJsonObj, user:user, commit:true)
	}

	class func insertComment(json: [NSObject: AnyObject]) {
		var alertId: Int = json["pushNotificationsEntryId"] as Int
		var parentAlertId: Int = json["parentPushNotificationsEntryId"]
			as Int

		var createTime: NSNumber? = json["createTime"] as? NSNumber

		var alertJsonObj: [NSObject: AnyObject] =
			JsonUtil.parse(json["payload"] as String)

		var userJson = json["user"] as [NSObject: AnyObject]
		var user: User = UserDAO.createUser(userJson)

		AlertDAO._insert(
			alertId, parentAlertId: parentAlertId, createTime: createTime,
			payload: alertJsonObj, user: user, commit:true)
	}

	class func _insert(
		alertId: Int, parentAlertId: Int, createTime:  NSNumber?,
		payload: [NSObject: AnyObject], user: User, commit: Bool) -> Alert {

		var database: DatabaseHelper = DatabaseHelper.getInstance()
		var context: NSManagedObjectContext = database.getContext()!

		var alert: Alert? = get(alertId)

		if (alert == nil) {
			alert = NSEntityDescription.insertNewObjectForEntityForName(
				"Alert", inManagedObjectContext:context) as? Alert
		}

		alert!.alertId = alertId
		alert!.parentAlertId = parentAlertId
		alert!.payload = payload
		alert!.user = user

		if (createTime != nil) {
			alert!.createTime = createTime!
		}
		else {
			alert!.createTime = 0
		}

		if (commit) {
			database.commit()
		}

		return alert!
	}

	private class func _get(predicate: NSPredicate?) -> [Alert]? {
		var context = DatabaseHelper.getInstance().getContext()!

		var request: NSFetchRequest = NSFetchRequest()
		request.entity = NSEntityDescription.entityForName(
			"Alert", inManagedObjectContext:context)

		request.predicate = predicate

		var error: NSError?

		let alerts: [Alert] = context.executeFetchRequest(request, error:&error)
			as [Alert]

		if (error != nil) {
			NSLog("Coldn't get users \(error), \(error!.userInfo)")

			return nil
		}

		return alerts
	}

}