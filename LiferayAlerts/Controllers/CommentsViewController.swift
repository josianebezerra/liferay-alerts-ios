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
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	override func viewDidLoad() {
		_initBottomBar()
		_initTableView()
		_initTopBar()
	}

	func tableView(tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		var cell: CommentViewCell = tableView.dequeueReusableCellWithIdentifier(
			"CommentCellId") as CommentViewCell

		return cell
	}

	func tableView(
		tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return 1
	}

	private func _getCommentsHeaderView() -> CommentsHeaderView {
		var nib: UINib = UINib(
			nibName: "CommentsHeaderView", bundle: NSBundle.mainBundle())

		var view: CommentsHeaderView = nib.instantiateWithOwner(
			nil, options: nil)[0] as CommentsHeaderView

		view.setAlert(alert!)

		return view
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
	}

	private func _initTableView() {
		var nib: UINib = UINib(nibName: "CommentViewCell", bundle:nil)

		tableView.registerNib(nib, forCellReuseIdentifier: "CommentCellId")
		tableView.estimatedRowHeight = 44.0
		tableView.contentInset.top = topBar.frame.size.height
		tableView.tableHeaderView = _getCommentsHeaderView()
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

	@IBAction func backButtonClick(recognizer: UITapGestureRecognizer) {
		dismissViewControllerAnimated(true, completion:nil)
	}

	var alert: Alert?

	@IBOutlet var backButon: UIView!
	@IBOutlet var bottomBar: UIView!
	@IBOutlet var commentTextField: UITextField!
	@IBOutlet var sendButton: UIButton!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var topBar: UIView!
	@IBOutlet var topBarBackIcon: UILabel!
	@IBOutlet var topBarTitle: UILabel!

}