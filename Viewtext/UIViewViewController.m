//
//  UIViewViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "UIViewViewController.h"

@interface UIViewViewController ()

/* ------ label field --------*/
@property (weak, nonatomic) IBOutlet UILabel *LoveCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *isRentLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookFacePic;
@property (weak, nonatomic) IBOutlet UIButton *ownerProfilepic;
@property (weak, nonatomic) IBOutlet UIButton *borrowerProfilePic;



@property (nonatomic) NSInteger LoveCount;
@property (nonatomic) BOOL IsRent;
@end

@implementation UIViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.LoveCount = 0;
    self.IsRent = NO;
    [self setBackground];
    self.isRentLabel.backgroundColor = [UIColor colorWithPatternImage:[self returnRentImage:self.IsRent]];
    self.bookFacePic.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"book1"]];
    self.ownerProfilepic.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"superman"]];
    self.borrowerProfilePic.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"garfield"]];

}


- (void) setBackground
{
    UIImage *img_back = [UIImage imageNamed:@"wood2"];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [img_back drawInRect:CGRectMake(0, 0, width, height)];
    img_back = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:img_back];
}

- (UIImage *) returnRentImage:(BOOL)isRent{
    return [UIImage imageNamed:isRent? @"availablePattern": @"alreadyRentPattern"];
}


- (IBAction)addMoreLikePeopleNumber:(UIButton *)sender {
    self.LoveCount++;
    self.LoveCountLabel.text = [NSString stringWithFormat:@"😍: %d 😡: %d", self.LoveCount, 0];
}

- (IBAction)testButton:(UIButton *)sender {
    self.IsRent = !self.IsRent;
}

/*
- (IBAction)TouchToChangeTextContents:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

@end
