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
 */
class AddVoteCallback : NSObject, LRCallback {

	init(alert: Alert, choiceId: Int) {
		self.alert = alert
		self.choiceId = choiceId
	}

	func onFailure(error: NSError!) {
		println(error)
	}

	func onSuccess(result: AnyObject!) {
		alert.setPollsVote(choiceId)

		var database: DatabaseHelper = DatabaseHelper.getInstance()
		database.commit()
	}

	var alert: Alert
	var choiceId: Int

}