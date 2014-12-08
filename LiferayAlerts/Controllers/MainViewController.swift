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
class MainViewController: UIViewController, UICollectionViewDataSource,
	UICollectionViewDelegate {

	override init() {
		super.init(nibName:"MainViewController", bundle:nil)
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		alerts = AlertDAO.getAll()

		_initCollectionView()
		_initTopBar()

		NotificationUtil.register(
			"commentButtonClick", observer:self,
			selector: "didCommentButtonClickNotification:")
	}

	func collectionView(collectionView: UICollectionView,
		cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

		var alert: Alert = alerts![indexPath.row]

		var cell: UICollectionViewCell = AlertViewCellFactory.create(
			collectionView, indexPath:indexPath, alert:alert)

		return cell
	}

	func collectionView(collectionView: UICollectionView,
		numberOfItemsInSection section: Int) -> Int {

		return alerts!.count
	}

	func didCommentButtonClickNotification(
		notification: NSNotification) {

		var values: [NSObject: AnyObject] = notification.userInfo!
		var alert: Alert = values["alert"] as Alert

		presentViewController(
			CommentsViewController(alert:alert), animated: true,
			completion: nil)
	}

	private func _initCollectionView() {
		var backgroundView: UIView = UIView(frame: collectionView.frame)
		let backgroundImage = UIImage(named:"background")!

		var line: UIView = UIView(frame: CGRect(
			x: UIDimensions.VERTICAL_LINE_X,
			y: UIDimensions.VERTICAL_LINE_Y,
			width: UIDimensions.VERTICAL_LINE_WIDTH,
			height: backgroundView.frame.height
		))

		line.backgroundColor = UIColors.VERTICAL_LINE_COLOR
		backgroundView.backgroundColor = UIColor(patternImage:backgroundImage)
		backgroundView.addSubview(line)

		collectionView.backgroundView = backgroundView

		var layout: UICollectionViewFlowLayout =
			collectionView.collectionViewLayout as UICollectionViewFlowLayout

		let top = topBar.frame.height
		layout.sectionInset.top = top
		layout.minimumLineSpacing = 0

		let width: CGFloat = UIScreen.mainScreen().bounds.width
		let height: CGFloat = layout.itemSize.height

		layout.estimatedItemSize = CGSize(width: width, height: height)

		AlertViewCellFactory.register(collectionView)
	}

	private func _initTopBar() {
		_setTopBarGradient()

		divider.backgroundColor = UIColors.TOP_BAR_DIVIDER
		dividerHeight.constant = (1 / UIScreen.mainScreen().scale)

		topBarLastAlert.textColor = UIColors.TOP_BAR_LAST_ALERT
		userName.textColor = UIColors.TOP_BAR_USER_NAME
		userName.shadowColor = UIColors.TOP_BAR_USER_NAME_SHADOW
	}

	private func _setTopBarGradient() {
		var colors: [CGColor] = [
			(UIColors.TOP_BAR_BACKGROUND).CGColor,
			(UIColors.TOP_BAR_BACKGROUND_CENTER).CGColor,
			(UIColors.TOP_BAR_BACKGROUND).CGColor
		]

		GradientUtil.setGradientBackground(topBar, colors:colors)
	}

	var alerts: [Alert]?

	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var dividerHeight: NSLayoutConstraint!
	@IBOutlet var divider: UIView!
	@IBOutlet var topBar: UIView!
	@IBOutlet var topBarLastAlert: UILabel!
	@IBOutlet var userName: UILabel!

}
