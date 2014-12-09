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
class UserServiceUtil: NSObject {

	class func getUser(companyId: Int64, error: NSErrorPointer)
		-> [NSObject: AnyObject] {

		var json: [NSObject: AnyObject]
		let session: LRSession = SettingsUtil.getSession()
		let username: String = session.username
		let service:LRUserService_v62 = LRUserService_v62(session: session)

		if (Validator.isEmailAddress(session.username)) {
			json = service.getUserByEmailAddressWithCompanyId(companyId,
				emailAddress:username , error: error)
		}
		else {
			json = service.getUserByScreenNameWithCompanyId(companyId,
				screenName: username, error: error)
		}

		return json
	}

}