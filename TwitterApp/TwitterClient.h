//
//  TwitterClient.h
//  TwitterApp
//
//  Created by Prasannakumar Jobigenahally on 2/7/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

@end
