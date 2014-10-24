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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tab=[[UITabBarController alloc]init];
    
    ChangeUserNameViewController *first=[[ChangeUserNameViewController alloc]initWithNibName:nil bundle:nil];
    first.title=@"NAME";
    //fvc.tabBarItem.image=[UIImage imageNamed:@"i.png"];
    
    
    
    ChangeUserPasswordViewController *second=[[ChangeUserPasswordViewController alloc]initWithNibName:nil bundle:nil];
    second.title=@"PASSWORD";
    
    ChangeUserPictureViewController *third=[[ChangeUserPictureViewController alloc]initWithNibName:nil bundle:nil];
    second.title=@"Profile";

    
    self.tab.viewControllers=[NSArray arrayWithObjects:first, second, third,nil];
    
    [self.view addSubview:self.tab.view];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
