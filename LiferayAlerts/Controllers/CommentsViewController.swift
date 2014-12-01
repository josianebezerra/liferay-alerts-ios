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

	override init() {
		super.init(nibName:"CommentsViewController", bundle:nil)
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	override func viewDidLoad() {
		var nib: UINib = UINib(nibName: "CommentViewCell", bundle:nil)

		tableView.registerNib(nib, forCellReuseIdentifier: "CommentCellId")
		tableView.estimatedRowHeight = 44.0
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

	@IBOutlet var tableView: UITableView!

}