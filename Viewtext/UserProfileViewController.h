//
//  UserProfileViewController.h
//  Viewtext
//
//  Created by Chao Huang on 10/9/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface UserProfileViewController : UIViewController

@property (nonatomic,strong) NSString *userName;
@property (nonatomic) NSInteger userID;

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;


@end
