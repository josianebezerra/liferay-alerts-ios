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
class NotificationUtil {

	class func register(
		destination:String, observer: AnyObject, selector: Selector) {

		var notificationCenter = NSNotificationCenter.defaultCenter()

		notificationCenter.removeObserver(
			observer, name:destination, object:nil)

		notificationCenter.addObserver(
			observer, selector:selector, name:destination, object:nil)
	}

	class func send(destination: String, data: [String: AnyObject]? = nil) {
		var notificationCenter = NSNotificationCenter.defaultCenter()

		notificationCenter.postNotificationName(
			destination, object:self, userInfo:data)
	}

	class func unregister(observer: AnyObject) {
		var notificationCenter = NSNotificationCenter.defaultCenter()

		notificationCenter.removeObserver(observer)
	}

}