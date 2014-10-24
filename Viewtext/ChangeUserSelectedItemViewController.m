//
//  ChangeUserSelectedItemViewController.m
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import "ChangeUserSelectedItemViewController.h"
#import "ChangeUserNameViewController.h"
#import "ChangeUserPasswordViewController.h"
#import "ChangeUserPictureViewController.h"

@interface ChangeUserSelectedItemViewController ()

@end



@implementation ChangeUserSelectedItemViewController
@synthesize currentUserName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tab=[[UITabBarController alloc]init];
    
    ChangeUserNameViewController *first=[[ChangeUserNameViewController alloc]initWithNibName:nil bundle:nil];
    
    first.title=@"NAME";
    
    //first.currentUserName = self.currentUserName;
    
    //fvc.tabBarItem.image=[UIImage imageNamed:@"i.png"];
    
    
    
    ChangeUserPasswordViewController *second=[[ChangeUserPasswordViewController alloc]initWithNibName:nil bundle:nil];
    second.title=@"PASSWORD";
    
    
    ChangeUserPictureViewController *third=[[ChangeUserPictureViewController alloc]initWithNibName:nil bundle:nil];
    third.title=@"PROFILE";

    
    self.tab.viewControllers=[NSArray arrayWithObjects:first, second, third,nil];
    
    [self.view addSubview:self.tab.view];
    
    //self.selectedViewController = [self.viewControllers objectAtIndex:1];
    self.selectedIndex = 2;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
