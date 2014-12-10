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
class CommentsViewController: UIViewController, UITableViewDataSource,
	UITableViewDelegate {

	init(alert: Alert) {
		super.init(nibName:"CommentsViewController", bundle:nil)

		self.alert = alert
		self.comments = []
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	class func reloadData() {
		NotificationUtil.send("reloadEntries")
	}

	override func viewDidLoad() {
		_initBottomBar()
		_initTableView()
		_initTopBar()

		NotificationUtil.register(
			"reloadEntries", observer: self,
			selector: "reloadEntriesNotification")

		var alertId = alert!.alertId.integerValue

		PushNotificationsEntryServiceUtil.getComments(alertId)

		NotificationUtil.register(
			"UIKeyboardWillShowNotification", observer: self,
			selector: "willShowKeyboardNotification:")

		NotificationUtil.register(
			"UIKeyboardWillHideNotification", observer: self,
			selector: "willHideKeyboardNotification:")

		comments = AlertDAO.getChildren(alertId)
	}

	func reloadEntriesNotification() {
		var alertId = alert!.alertId.integerValue

		comments = AlertDAO.getChildren(alertId)

		tableView.reloadData()
	}

	func willHideKeyboardNotification(notification: NSNotification) {
		var params: [NSObject: AnyObject] = notification.userInfo!

		_animateView(false, params: params)
	}

	func willShowKeyboardNotification(notification: NSNotification) {
		var params: [NSObject: AnyObject] = notification.userInfo!

		_animateView(true, params: params)
	}

	@IBAction func backButtonClick(recognizer: UITapGestureRecognizer) {
		dismissViewControllerAnimated(true, completion:nil)
	}

	@IBAction func tableViewClick(recognizer: UITapGestureRecognizer) {
		commentTextField.resignFirstResponder()
	}

	@IBAction func sendCommentAction() {
		var comment: String = commentTextField.text

		if (comment.isEmpty) {
			return
		}

		PushNotificationsEntryServiceUtil.addComment(alert!, comment: comment)

		commentTextField.resignFirstResponder()
	}

	func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		if (indexPath.row == 0) {
			var cell: CommentsHeaderView =
				tableView.dequeueReusableCellWithIdentifier(
				"CommentHeaderViewId") as CommentsHeaderView

			cell.setAlert(alert!)

			return cell

		}
		else {
			var cell: CommentViewCell =
				tableView.dequeueReusableCellWithIdentifier(
				"CommentCellId") as CommentViewCell

			var comment: Alert = comments![indexPath.row - 1]

			cell.setAlert(comment)

			return cell
		}
	}

	func tableView(
		tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return comments!.count + 1
	}

	private func _animateView(up: Bool, params: [NSObject: AnyObject]) {
		var size: CGSize =
			params[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size

		var duration: Double =
			params[UIKeyboardAnimationDurationUserInfoKey] as Double

		var rawAnimationCurve =
			(params[UIKeyboardAnimationCurveUserInfoKey]
			as NSNumber).unsignedIntValue << 16

		var curve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
		var distance: CGFloat = (up ? -size.height : size.height)

		UIView.animateWithDuration(
			duration,
			delay: 0,
			options: curve,
			animations: {
				self.view.frame = CGRectOffset(self.view.frame, 0, distance)
			},
			completion: nil)
	}

	private func _initBottomBar() {
		bottomBar.backgroundColor = UIColors.COMMENTS_BAR_BACKGROUND

		sendButton.backgroundColor = UIColors.COMMENTS_BAR_SEND_BUTTON
		sendButton.layer.borderWidth =
			UIDimensions.COMMENTS_BAR_SEND_BUTTON_BORDER

		sendButton.layer.borderColor =
			UIColors.COMMENTS_BAR_SEND_BUTTON_BORDER.CGColor

		sendButton.layer.cornerRadius =
			UIDimensions.COMMENTS_BAR_SEND_BUTTON_RADIUS

		sendButton.setTitleColor(
			UIColors.COMMENTS_BAR_SEND_BUTTON_TEXT,
			forState:UIControlState.Normal)

		commentTextField.borderStyle = UITextBorderStyle.None
		commentTextField.backgroundColor =
			UIColors.COMMENTS_BAR_INPUT_BACKGROUND

		commentTextField.layer.cornerRadius =
			UIDimensions.COMMENTS_BAR_INPUT_RADIUS

		commentTextField.textColor = UIColors.COMMENTS_BAR_INPUT_TEXT

		commentTextField.placeholder = NSLocalizedString(
			"write-something-nice", comment: "")
	}

	private func _initTableView() {
		var commentNib: UINib = UINib(nibName: "CommentViewCell", bundle:nil)
		var headerNib: UINib = UINib(nibName: "CommentsHeaderView", bundle: nil)

		tableView.registerNib(
			commentNib, forCellReuseIdentifier: "CommentCellId")

		tableView.registerNib(
			headerNib, forCellReuseIdentifier: "CommentHeaderViewId")

		tableView.estimatedRowHeight = 44.0
		tableView.contentInset.top = topBar.frame.size.height
		tableView.separatorStyle = UITableViewCellSeparatorStyle.None
	}

	private func _initTopBar() {
		var colors: [CGColor] = [
			(UIColors.TOP_BAR_BACKGROUND).CGColor,
			(UIColors.TOP_BAR_BACKGROUND_CENTER).CGColor,
			(UIColors.TOP_BAR_BACKGROUND).CGColor
		]

		GradientUtil.setGradientBackground(topBar, colors:colors)

		topBarBackIcon.textColor = UIColors.TOP_BAR_TEXT

		topBarTitle.text = NSLocalizedString("comments", comment:"")
		topBarTitle.textColor = UIColors.TOP_BAR_TEXT
	}

	var alert: Alert?
	var comments: [Alert]?

	@IBOutlet var backButon: UIView!
	@IBOutlet var bottomBar: UIView!
	@IBOutlet var commentTextField: UITextField!
	@IBOutlet var sendButton: UIButton!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var topBar: UIView!
	@IBOutlet var topBarBackIcon: UILabel!
	@IBOutlet var topBarTitle: UILabel!

}