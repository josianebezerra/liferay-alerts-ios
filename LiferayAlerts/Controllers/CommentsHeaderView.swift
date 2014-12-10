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
class CommentsHeaderView: UITableViewCell {

	override func awakeFromNib() {
		messageTextView.textColor = UIColors.COMMENT_TEXT
		divider.backgroundColor = UIColors.COMMENTS_DIVIDER
	}

	func setAlert(alert: Alert) {
		var typeColor: UIColor = alert.getType()!.getColor()

		userNameLabel.text = alert.user.fullName
		userNameLabel.textColor = typeColor

		messageTextView.text = alert.getMessage()
		messageTextView.textContainer.lineFragmentPadding = 0

		var URL: NSURL = PortraitUtil.getPortraitURL(alert.user)
		portraitView.setPortraitURL(URL)
		portraitView.typeBadge.backgroundColor = typeColor
	}


	@IBOutlet var divider: UIView!
	@IBOutlet var messageTextView: UITextView!
	@IBOutlet var portraitView: PortraitView!
	@IBOutlet var userNameLabel: UILabel!

}