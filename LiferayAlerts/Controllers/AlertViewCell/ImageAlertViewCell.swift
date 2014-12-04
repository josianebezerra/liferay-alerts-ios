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

import UIKit

/**
* @author Josiane Bezerra
*/
class ImageAlertViewCell: BaseAlertViewCell {

	override func setAlert(alert: Alert) {
		super.setAlert(alert)

		nameLabel.text = alert.user.fullName
		textCardView.leftArrow = false
		textCardView.setAlert(alert)

		self._setGradient()
		self._getImage(alert)

		self.layoutIfNeeded()
	}

	func _getImage(alert: Alert) {
		let URL = NSURL(string: alert.getURL()!)
		let size = CGSize(width: UIScreen.mainScreen().bounds.width,
			height: self.imageView.bounds.size.height)

		SDWebImageDownloader.sharedDownloader().downloadImageWithURL(
			URL, options: SDWebImageDownloaderOptions.UseNSURLCache,
			progress: nil) {
				(image: UIImage!, data: NSData!, error: NSError!,finished: Bool)
					-> Void in

				self._resizeImage(image, size: size)
			}
	}

	func _resizeImage(var image: UIImage, size: CGSize) {
		if (image.size.width > size.width) {
			let scale = size.width / image.size.width

			let newSize = CGSizeApplyAffineTransform(
				image.size, CGAffineTransformMakeScale(scale, scale))

			UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
			image.drawInRect(CGRect(origin: CGPointZero, size: newSize))

			image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
		}

		self.imageView.image = image
	}

	func _setGradient() {
		var colors: [CGColor] = [
			(UIColors.IMAGE_CARD_GRADIENT).CGColor,
			(UIColors.IMAGE_CARD_GRADIENT_CENTER).CGColor,
			(UIColors.IMAGE_CARD_GRADIENT).CGColor
		]

		var frame: CGRect = imageGradient.bounds
		var startPoint: CGPoint = CGPointMake(0.5, 0.0)
		var endPoint: CGPoint = CGPointMake(0.5, 1.0)

		var gradient = GradientUtil .createGradient(colors, frame: frame,
			startPoint: startPoint, endPoint: endPoint)

		imageGradient.layer.addSublayer(gradient)
	}

	@IBOutlet weak var backgroundImageView: UIImageView!
	@IBOutlet weak var imageContainer: UIView!
	@IBOutlet weak var imageGradient: UIView!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var overlayView: UIView!
	@IBOutlet weak var textCardView: TextCardView!

}