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

#import <Foundation/Foundation.h>

/**
 * @author Silvio Santos
 */

// Liferay services
#import "LRCallback.h"
#import "LRSession.h"
#import "LRError.h"
#import "LRGroupService_v62.h"
#import "LRHttpUtil.h"
#import "LRJSONObjectWrapper.h"
#import "LRPortraitUtil.h"
#import "LRPollsVoteService_v62.h"
#import "LRPushnotificationsdeviceService_v62.h"
#import "LRPushnotificationsentryService_v62.h"
#import "LRServiceFactory.h"
#import "LRUserService_v62.h"
#import "MBProgressHUD.h"

//SDWebImage
#import "UIImageView+WebCache.h"
