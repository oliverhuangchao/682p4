//
//  ChangeUserPictureViewController.h
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeUserPictureViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


//@property(nonatomic,strong) NSString *currentUserName;
@property(nonatomic) NSInteger currentUserID;

@end
