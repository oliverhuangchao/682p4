//
//  UIViewViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "UIViewViewController.h"
#import <UIKit/UIKit.h>
#import "GetMethodsConnect.h"

#import "SearchBookViewController.h"


@interface UIViewViewController ()

/* ------ label field --------*/
@property (weak, nonatomic) IBOutlet UILabel *LoveCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *isRentLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookFacePic;
@property (weak, nonatomic) IBOutlet UIButton *ownerProfilepic;
@property (weak, nonatomic) IBOutlet UIButton *borrowerProfilePic;
@property (weak, nonatomic) IBOutlet UINavigationItem *searchedBookName;




@property (nonatomic) NSInteger LoveCount;

@property (nonatomic) NSString* commonPicString;
@end

@implementation UIViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.commonPicString = @"http://people.cs.clemson.edu/~chaoh/ios/pic/";
    
    self.searchedBookName.title = [NSString stringWithFormat:@"%@", [self.searchedBookInfo objectAtIndex:1]];
    
    if ([[self.searchedBookInfo objectAtIndex:7] isEqualToString:@"1"])
        self.isRentLabel.backgroundColor =[UIColor colorWithPatternImage:[self returnRentImage:YES]];
    else
        self.isRentLabel.backgroundColor =[UIColor colorWithPatternImage:[self returnRentImage:NO]];

    

    self.LoveCount = 0;
    [self setBackground];
    
    
    self.bookFacePic.backgroundColor = [UIColor colorWithPatternImage:[self getUIImageFromUrlString:[self.searchedBookInfo objectAtIndex:4]]];
    
    
    self.ownerProfilepic.backgroundColor = [UIColor colorWithPatternImage:[self getUIImageFromUrlString:                                   [self getImageStringFromDatabaseUsingUserID:3]]];
    
    self.borrowerProfilePic.backgroundColor = [UIColor colorWithPatternImage:[self getUIImageFromUrlString:                                   [self getImageStringFromDatabaseUsingUserID:6]]];

}

-(NSString *) getImageStringFromDatabaseUsingUserID:(NSInteger) num;
{
    NSString *userProfileURLString = @"http://people.cs.clemson.edu/~chaoh/ios/getUserProfile.php?id=";
    NSData *userProfileData = [GetMethodsConnect getContentFromPhp:[userProfileURLString stringByAppendingString:[self.searchedBookInfo objectAtIndex:num]]];
    NSMutableArray *userProfileArray = [NSJSONSerialization JSONObjectWithData:userProfileData
                                                                       options:kNilOptions
                                                                         error:nil];
    
    NSString *stringProfilePicName = [userProfileArray objectAtIndex:0];
    return stringProfilePicName;
}

-(UIImage *) getUIImageFromUrlString: (NSString *) tmpURLString;
{
    NSString *picUrlString = [self.commonPicString stringByAppendingString: tmpURLString];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: picUrlString]];
    UIImage * returnImage = [UIImage imageWithData:imageData];
    return returnImage;
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
    //self.LoveCountLabel.text = @"hello wolrd";
    self.LoveCountLabel.text = [NSString stringWithFormat:@"😍: %d 😡: %d", self.LoveCount, 0];
}


@end
