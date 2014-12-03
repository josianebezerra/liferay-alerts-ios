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
 * @author Josiane Bezerra
 */
class TextAlertViewCell: BaseAlertViewCell {

	override func prepareForReuse() {
		for view in cardViewContainer.subviews {
			view.removeFromSuperview()
		}
	}

	override func setAlert(alert: Alert) {
		super.setAlert(alert)

		_setPortrait(alert.user)

		var cardView: TextCardView = TextCardView.loadFromNib("TextCardView")!

		cardView.setAlert(alert)
		cardViewContainer.addSubview(cardView)
		cardView.setTranslatesAutoresizingMaskIntoConstraints(false)
		cardView.setFrameConstraints(equalsToView: cardViewContainer)

		self.layoutIfNeeded()
	}

	private func _setPortrait(user: User) {
		let session = LRSession(server: SettingsUtil.getServer())

		let portraitURL = LRPortraitUtil.getPortraitURL(session, male: true,
			portraitId: user.portraitId.longLongValue, uuid: user.uuid)

		let URL: NSURL = NSURL(string: portraitURL)!

		portraitView.setPortraitURL(URL)
	}

	@IBOutlet var cardViewContainer: UIView!
	@IBOutlet var portraitView: PortraitView!

}