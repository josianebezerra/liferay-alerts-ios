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
class PortraitUtil {

	class func getPortraitURL(user: User) -> NSURL {
		var URL: String = String()

		URL = SettingsUtil.getServer()
		URL = URL + "/image/user_male/_portrait?img_id="
		URL = URL + user.portraitId.stringValue

		_appendToken(URL, uuid: user.uuid)

		return NSURL(string: URL)!
	}

	private class func _appendToken(URL: String, uuid: String) -> String {
		var URL = URL + "&img_id_token=" + getSHA1(uuid)

		return URL
	}

	private class func getSHA1(input: String) -> String {
		var digestLength: Int = Int(CC_SHA1_DIGEST_LENGTH)

		var result: [UInt8] = [Byte](count: digestLength, repeatedValue: 0)

		CC_SHA1(input, CC_LONG(countElements(input)), &result)

		var data: NSData = NSData(bytes: result, length: result.count)

		var encodedString: String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))

		var SHA1 = LRHttpUtil.encodeURL(encodedString)

		return SHA1
	}

}