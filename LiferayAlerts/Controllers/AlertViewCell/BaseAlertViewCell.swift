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
class BaseAlertViewCell: UICollectionViewCell {

	override func preferredLayoutAttributesFittingAttributes(
		attributes: UICollectionViewLayoutAttributes)
		-> UICollectionViewLayoutAttributes! {

		return super.preferredLayoutAttributesFittingAttributes(attributes)
	}

	override func systemLayoutSizeFittingSize(targetSize: CGSize,
		withHorizontalFittingPriority horizontalPriority: UILayoutPriority,
		verticalFittingPriority: UILayoutPriority) -> CGSize {

		let horizontalPriority = UIDimensions.ALERT_HORIZONTAL_FITTING_PRIORITY

		let size =  super.systemLayoutSizeFittingSize(targetSize,
			withHorizontalFittingPriority: horizontalPriority,
			verticalFittingPriority: verticalFittingPriority)

		return size
	}

	func setAlert(alert: Alert) {
		self.alert = alert

		_setPortrait(alert.user)
	}

	private func _setPortrait(user: User) {
		let URL: NSURL = PortraitUtil.getPortraitURL(user)

		portraitView.setPortraitURL(URL)
	}

	var alert: Alert?

	@IBOutlet var portraitView: PortraitView!

}