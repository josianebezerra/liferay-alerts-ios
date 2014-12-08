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
class CommentViewCell: UITableViewCell {

	override func awakeFromNib() {
		commentLabel.textColor = UIColors.COMMENT_TEXT
		dateLabel.textColor = UIColors.COMMENT_DATE
		divider.backgroundColor = UIColors.COMMENTS_DIVIDER

		portraitView.typeBadge.hidden = true
	}

	func setAlert(comment: Alert) {
		self.comment = comment

		_setComment()
		_setDate()
	}

	private func _getAttributedString(
		text: String, font: UIFont, color: UIColor)
		 -> NSMutableAttributedString {

		var attributes = [
			NSFontAttributeName: font,
			NSForegroundColorAttributeName: color
		]

		var attributedString = NSMutableAttributedString(
			string:text, attributes:attributes)

		return attributedString
	}

	private func _setComment() {
		var userName: NSMutableAttributedString = _getAttributedString(
			comment!.user.fullName + " ", font:USER_NAME_FONT,
			color:UIColors.COMMENT_USER_NAME)

		var text = _getAttributedString(
			comment!.getMessage()!, font:COMMENT_FONT,
			color:UIColors.COMMENT_TEXT)

		text.insertAttributedString(userName, atIndex: 0)

		commentLabel.attributedText = text
	}

	private func _setDate() {
		dateLabel.text = DateUtil.format(comment!.createTime.longLongValue)
	}

	let USER_NAME_FONT: UIFont = UIFont(
		name: "HelveticaNeue-Medium", size: UIDimensions.CARD_TEXT_SIZE)!

	let COMMENT_FONT: UIFont = UIFont(
		name: "HelveticaNeue-Light", size: UIDimensions.CARD_TEXT_SIZE)!

	var comment: Alert?

	@IBOutlet var commentLabel: UILabel!
	@IBOutlet var dateLabel: UILabel!
	@IBOutlet var divider: UIView!
	@IBOutlet var portraitView: PortraitView!

}
