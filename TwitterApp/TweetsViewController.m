//
//  TweetsViewController.m
//  TwitterApp
//
//  Created by Prasannakumar Jobigenahally on 2/8/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"

@interface TweetsViewController ()

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet *tweet in tweets) {
            NSLog(@"tweet: %@", tweet.text);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogout:(id)sender {
    
    [User logout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
