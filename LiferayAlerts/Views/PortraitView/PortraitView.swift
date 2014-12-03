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
class PortraitView: UIView {

	required init(coder aDecoder: NSCoder) {
		super.init(coder:aDecoder)

		var view: UIView = NSBundle.mainBundle().loadNibNamed(
			"PortraitView", owner:self, options:nil)[0] as UIView

		addSubview(view)

		view.setTranslatesAutoresizingMaskIntoConstraints(false)
		view.setFrameConstraints(equalsToView:self)

		layoutIfNeeded()

		_setRadius(portraitImageView)
		_setRadius(typeBadge)
	}

	func setPortraitURL(URL: NSURL) {
		portraitImageView.sd_setImageWithURL(URL)
	}

	private func _setRadius(view: UIView) {
		let radius = view.frame.size.width / 2

		view.layer.cornerRadius = radius
		view.clipsToBounds = true
	}

	@IBOutlet var portraitImageView: UIImageView!
	@IBOutlet var typeBadge: UIView!

}