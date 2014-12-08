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
class UserDAO {

	class func createUser(jsonObj: [NSObject: AnyObject]) -> User {
		var id: NSNumber = jsonObj["userId"] as NSNumber
		var fullName: String = jsonObj["fullName"] as String
		var portraitId: NSNumber = jsonObj["portraitId"] as NSNumber
		var uuid: String = jsonObj["uuid"] as String

		var user: User = UserDAO.insert(
			id, fullName:fullName, portraitId:portraitId, uuid:uuid,
			commit:false)

		return user;
	}

	class func get(id : NSNumber) -> User? {
		var context = DatabaseHelper.getInstance().getContext()!

		var request: NSFetchRequest = NSFetchRequest()
		request.entity = _getEntityDescription()
		request.predicate = NSPredicate(format:"id = %@", id)

		var error: NSError?

		var users = context.executeFetchRequest(request, error:&error)

		if (error != nil) {
			NSLog("Coldn't get user \(error), \(error!.userInfo)")

			return nil
		}

		if (users!.count > 0) {
			return users![0] as? User
		}

		return nil
	}

	class func insert(
		id: NSNumber, fullName: String, portraitId: NSNumber, uuid: String,
		commit: Bool)
		-> User {

		var database = DatabaseHelper.getInstance();
		var context = database.getContext()!
		var user: User? = get(id)

		if (user == nil) {
			user = NSEntityDescription.insertNewObjectForEntityForName(
				"User", inManagedObjectContext:context) as? User

			user!.id = id
		}

		user!.fullName = fullName
		user!.portraitId = portraitId
		user!.uuid = uuid

		if (commit) {
			database.commit()
		}

		return user!
	}

	private class func _getEntityDescription() -> NSEntityDescription? {
		var database : DatabaseHelper = DatabaseHelper.getInstance()
		var context: NSManagedObjectContext? = database.getContext()

		return NSEntityDescription.entityForName(
			"User", inManagedObjectContext:context!)
	}

	let	FULL_NAME: String = "fullName"
	let PORTRAIT_ID: String = "portraitId"
	let USER_ID: String = "userId"
	let UUID: String = "uuid"

}