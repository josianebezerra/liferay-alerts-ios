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
class AddLikeCallback : NSObject, LRCallback {

	init(alertId: Int, like: Bool) {
		self.alertId = alertId
		self.like = like
	}

	func onFailure(error: NSError!) {
		TextCardView.updateLike(alertId, liked:!like)

		MBProgressHUD.showMessageOnWindow("failed-to-like-alert")
	}

	func onSuccess(result: AnyObject!) {
		TextCardView.updateLike(alertId, liked:like)

		var database: DatabaseHelper = DatabaseHelper.getInstance()
		database.commit()
	}

	var alertId: Int
	var like: Bool

}