//
//  UIViewViewController.h
//  Viewtext
//
//  Created by Chao Huang on 9/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewViewController : UIViewController

@property (nonatomic) NSMutableArray *searchedBookInfo;
@property (nonatomic,strong) NSString *localUserName;
@property (nonatomic) NSInteger localUserID;

@end
