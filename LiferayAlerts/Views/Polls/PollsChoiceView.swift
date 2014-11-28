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
class PollsChoiceView: UIView {

	deinit {
		NotificationUtil.unregister(self)
	}

	override func awakeFromNib() {
		choiceLabel.textColor = UIColors.POLLS_CARD_CHOICE_TEXT

		voteSwitch.layer.cornerRadius = 16.0
		voteSwitch.backgroundColor = UIColors.POLLS_CARD_CHOICE_SWITCH_OFF
		voteSwitch.tintColor = UIColors.POLLS_CARD_CHOICE_SWITCH_OFF
		voteSwitch.thumbTintColor = UIColor.whiteColor()
	}

	override func intrinsicContentSize() -> CGSize {
		return CGSize(
			width: UIViewNoIntrinsicMetric,
			height: UIDimensions.POLLS_CARD_CHOICE_HEIGHT)
	}

	@IBAction func voteChanged() {
		if (!voteSwitch.on) {
			return
		}

		superview!.userInteractionEnabled = false

		var choiceContainer: PollsChoiceContainerView =
		superview as PollsChoiceContainerView

		choiceContainer.voteChanged(choice!)
	}

	class func update(choiceId: Int, checked: Bool) {
		var destination: String = PollsChoiceView._getDestination(choiceId)

		NotificationUtil.send(destination, data:["checked": checked])
	}

	private class func _getDestination(choiceId: Int) -> String {
		return "updatePollsChoice" + String(choiceId)
	}

	func setChoice(choice: PollsChoice) {
		self.choice = choice

		choiceLabel.text = choice.description
		voteSwitch.on = choice.checked

		var choiceId: Int = choice.choiceId
		var destination: String = PollsChoiceView._getDestination(choiceId)

		NotificationUtil.register(
			destination, observer:self, selector:"updateChoice:")
	}

	func updateChoice(notification: NSNotification) {
		var values: [NSObject: AnyObject] = notification.userInfo!
		var checked: Bool = values["checked"] as Bool

		voteSwitch.setOn(checked, animated:true)

		if (!voteSwitch.on) {
			superview!.userInteractionEnabled = true
		}
	}

	var choice: PollsChoice?

	@IBOutlet var choiceLabel: UILabel!
	@IBOutlet var voteSwitch: UISwitch!

}