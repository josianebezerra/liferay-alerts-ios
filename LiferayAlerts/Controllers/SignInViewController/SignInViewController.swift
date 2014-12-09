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
class SignInViewController: UIViewController {

	override init() {
		super.init(nibName:"SignInViewController", bundle:nil)
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	@IBAction func signInAction() {
		let login = loginTextField.text
		let password = passwordTextField.text

		let operation = SignInOperation(login: login, password: password) {
			(error) -> Void in

			if (error == nil) {
				self.navigationController!.pushViewController(
					MainViewController(), animated: true)
			}
			else {
				var window: UIWindow =
					UIApplication.sharedApplication().keyWindow!

				var hud = MBProgressHUD.showHUDAddedTo(window, animated: true)

				hud.labelText = error!.description

				hud.mode = MBProgressHUDModeText
				hud.hide(true, afterDelay:1.5)
			}
		}

		queue.addOperation(operation)
	}

	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

	lazy var queue: NSOperationQueue = {
		var queue = NSOperationQueue()
		queue.maxConcurrentOperationCount = 1

		return queue
	}()

}