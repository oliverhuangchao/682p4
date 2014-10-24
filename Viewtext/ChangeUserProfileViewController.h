//
//  ChangeUserProfileViewController.h
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeUserProfileViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSString* currentUserName;
@property (nonatomic) NSInteger currentUserID;

@property (weak, nonatomic) IBOutlet UITableView *currentUserDetailProfileTableView;

@end
