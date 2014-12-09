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
enum AlertType: String {

	case IMAGE = "image"
	case LINK = "link"
	case POLLS = "polls"
	case TEXT = "text"

	func getColor() -> UIColor {
		var color: UIColor

		switch (self) {
			case .IMAGE:
				color = UIColors.ALERT_TYPE_IMAGE_COLOR

			case .LINK:
				color = UIColors.ALERT_TYPE_LINK_COLOR

			case .POLLS:
				color = UIColors.ALERT_TYPE_POLLS_COLOR

			default:
				color = UIColors.ALERT_TYPE_TEXT_COLOR
		}

		return color
	}

}