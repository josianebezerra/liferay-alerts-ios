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
* @author Josiane Bezerra
*/
class ComposeViewController: UIViewController, UITextViewDelegate {

	override init() {
		super.init(nibName:"ComposeViewController", bundle:nil)
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	override func viewDidLoad() {
		messageTextView.becomeFirstResponder()
		messageTextView.selectedRange = NSMakeRange(0, 0)

		NotificationUtil.register(UIKeyboardWillHideNotification,
			observer: self, selector: Selector("keyboardWillHide:"))

		NotificationUtil.register(UIKeyboardWillChangeFrameNotification,
			observer: self, selector: Selector("keyboardWillShow:"))
	}

	@IBAction func backAction() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

	@IBAction func createAction() {
		if (messageTextView.tag == 0) {
			return
		}

		let message = messageTextView.text

		var payload = [String: String]()
		payload["message"] = message
		payload["type"] = AlertType.TEXT.rawValue

		PushNotificationsEntryServiceUtil.addPushNotificationsEntry(
			JsonUtil.toString(payload)!)

		println(payload)
	}

	func keyboardWillHide(notification: NSNotification) {
		let userInfo = notification.userInfo!
		let frame = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()

		keyboradHeightConstraint.constant = 0
		view.layoutIfNeeded()
	}

	func keyboardWillShow(notification: NSNotification) {
		let userInfo = notification.userInfo!
		let frame = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()

		keyboradHeightConstraint.constant = frame.size.height
		view.layoutIfNeeded()
	}

	func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
		replacementText text: String) -> Bool {

		if(textView.tag == 0) {
			textView.tag = 1
			textView.text = ""
			textView.textColor = UIColors.COMPOSE_TEXT
		}

		return true
	}

	func textViewDidEndEditing(textView: UITextView) {
		if(Validator.isNull(textView.text)) {
			textView.tag = 0
			textView.text = _placeholder
			textView.textColor = UIColors.COMPOSE_PLACEHOLDER
		}
	}

	@IBOutlet weak var keyboradHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var messageTextView: UITextView!

	let _placeholder = NSLocalizedString("say-something-nice", comment:"")
}