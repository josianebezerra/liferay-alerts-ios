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
 * @author Josiane Bzerra
 */
class TextCardView: BaseCardView {

	deinit {
		NotificationUtil.unregister(self)
	}

	override func awakeFromNib() {
		commentLabel.textColor = UIColors.CARD_BOTTOM_BAR_TEXT
		likeLabel.textColor = UIColors.CARD_BOTTOM_BAR_TEXT
	}

	override init(coder: NSCoder) {
		super.init(coder: coder)

		containerView = NSBundle.mainBundle().loadNibNamed("TextCardView",
			owner: self, options: nil)[0] as UIView

		self.addSubview(containerView)

		containerView.setTranslatesAutoresizingMaskIntoConstraints(false)
		containerView.setFrameConstraints(equalsToView: self)

		self.layoutIfNeeded()
	}

	@IBAction func commentButtonAction() {
		NotificationUtil.send("commentButtonClick", data: ["alert": alert!])
	}

	@IBAction func likeButtonAction(sender: UIButton) {
		var alertId: Int = self.alert!.alertId.integerValue
		var like: Bool = !self.alert!.like

		_updateLike(like)

		PushNotificationsEntryServiceUtil.likeAlert(alertId, like:like)
	}

	class func loadFromNib(name: String) -> TextCardView? {
		let nib: UINib = UINib(nibName: name, bundle: NSBundle.mainBundle())

		return nib.instantiateWithOwner(nil, options: nil)[0] as? TextCardView
	}

	class func updateLike(alertId: Int, liked: Bool) {
		var destination: String = TextCardView._getDestination(alertId)

		NotificationUtil.send(destination, data:["liked": liked])
	}

	private class func _getDestination(alertId: Int) -> String {
		return "updateLike" + String(alertId)
	}

	func didReceiveLikeNotification(notification: NSNotification) {
		var values: [NSObject: AnyObject] = notification.userInfo!
		var liked: Bool = values["liked"] as Bool

		_updateLike(liked)
	}

	func setAlert(alert: Alert) {
		self.contentMode = UIViewContentMode.Redraw
		self.alert = alert

		_updateLike(alert.like)
		_setMessage()

		var alertId: Int = alert.alertId.integerValue
		var destination: String = TextCardView._getDestination(alertId)

		NotificationUtil.register(
			destination, observer: self,
			selector: "didReceiveLikeNotification:")
	}

	private func _setMessage() {
		if (!alert!.hasMessage()) {
			messageTextView.removeFromSuperview()

			return
		}

		messageTextView.text = alert!.getMessage()
		messageTextView.textColor = UIColors.CARD_MESSAGE
		messageTextView.font = TEXT_FONT
	}

	private func _updateLike(like: Bool) {
		var name: String = "icon_like"

		if (like) {
			name = "icon_like_selected"
		}

		var image: UIImage? = UIImage(named: name)
		likeButton.setImage(image, forState: UIControlState.Normal)

		alert!.like = like
	}

	let TEXT_FONT: UIFont = UIFont(
		name: "Helvetica-Light", size: UIDimensions.CARD_TEXT_SIZE)!

	var alert: Alert?

	@IBOutlet var commentLabel: UILabel!
	@IBOutlet var containerView: UIView!
	@IBOutlet var likeButton: UIButton!
	@IBOutlet var likeLabel: UILabel!
	@IBOutlet var messageTextView: UITextView!

}