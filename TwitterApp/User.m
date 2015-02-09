//
//  User.m
//  TwitterApp
//
//  Created by Prasannakumar Jobigenahally on 2/8/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];

    }
    
    return self;
}

@end
