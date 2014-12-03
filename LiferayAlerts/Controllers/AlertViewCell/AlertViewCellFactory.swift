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
class AlertViewCellFactory {

	class func create(
		collectionView: UICollectionView, indexPath: NSIndexPath, alert: Alert)
		-> UICollectionViewCell {

		var id: String
		var type: AlertType = alert.getType()!

		switch (type) {
			case .IMAGE:
				id = "ImageAlertViewCellId"
			case .POLLS:
				id = "PollsAlertViewCellId"
			default:
				id = "TextAlertViewCellId"
		}

		var cell: BaseAlertViewCell =
			collectionView.dequeueReusableCellWithReuseIdentifier(
			id, forIndexPath:indexPath) as BaseAlertViewCell

		cell.setAlert(alert)

		return cell
	}

	class func register(collectionView: UICollectionView) {
		var nib: UINib = UINib(nibName: "TextAlertViewCell", bundle:nil)
		collectionView.registerNib(
			nib, forCellWithReuseIdentifier: "TextAlertViewCellId")

		nib = UINib(nibName: "ImageAlertViewCell", bundle: nil)
		collectionView.registerNib(
			nib, forCellWithReuseIdentifier: "ImageAlertViewCellId")

		nib = UINib(nibName: "PollsAlertViewCell", bundle:nil)
		collectionView.registerNib(
			nib, forCellWithReuseIdentifier: "PollsAlertViewCellId")
	}

}