//
//  ChangeUserNameViewController.h
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeUserNameViewControllerDelegate

-(void)editingInfoWasFinished;

@end


@interface ChangeUserNameViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic,strong) NSString *currentUserName;
@property(nonatomic) NSInteger currentUserID;
@property (nonatomic, strong) id<ChangeUserNameViewControllerDelegate> delegate;

@end
