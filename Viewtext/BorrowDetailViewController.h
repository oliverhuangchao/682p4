//
//  BorrowDetailViewController.h
//  Viewtext
//
//  Created by Chao Huang on 10/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BorrowDetailViewController : UIViewController


@property (nonatomic) NSInteger borrowDate;
@property (nonatomic,strong) NSString* currentUserName;
@property (nonatomic) NSInteger currentUserID;
@property (nonatomic) NSMutableArray *searchedBookInfo;
@property (nonatomic) NSInteger bookID;
@property (nonatomic) NSInteger keepDays;

@end
