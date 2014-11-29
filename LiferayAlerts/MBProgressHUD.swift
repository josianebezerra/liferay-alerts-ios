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

import Foundation

/**
 * @author Silvio Santos
 */
extension MBProgressHUD {

	class func showMessageOnWindow(var key: String) {
		var window: UIWindow = UIApplication.sharedApplication().keyWindow!

		var hud = MBProgressHUD.showHUDAddedTo(window, animated: true)

		hud.labelText = NSLocalizedString(key, comment:"")
		hud.mode = MBProgressHUDModeText
		hud.hide(true, afterDelay:1.5)
	}
	
}