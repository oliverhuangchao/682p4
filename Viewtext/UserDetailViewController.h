//
//  UserDetailViewController.h
//  Viewtext
//
//  Created by Chao Huang on 10/5/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *currentUserName;
@property (nonatomic, strong) NSString *currentUserID;

@property (weak, nonatomic) IBOutlet UITableView *searchedBookHistoryTableView;

@property (nonatomic) NSMutableArray *selectedBookInfo;


@end
