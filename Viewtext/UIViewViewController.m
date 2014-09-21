//
//  UIViewViewController.m
//  Viewtext
//
//  Created by Chao Huang on 9/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "UIViewViewController.h"
#import <UIKit/UIKit.h>




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
    self.IsRent = YES;
    [self setBackground];
    self.isRentLabel.backgroundColor = [UIColor colorWithPatternImage:[self returnRentImage:self.IsRent]];
    self.bookFacePic.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"book1"]];
    self.ownerProfilepic.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"superman"]];
    self.borrowerProfilePic.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"garfield"]];
    
    /*MysqlConnection *connection = [MysqlConnection connectToHost:@"mysql1.cs.clemson.edu"
                                                            user:@"chaoh"
                                                        password:@"hc"
                                                          schema:@"chaoh_201308_cpsc462"
                                                           flags:0.0];*/
    
    /* ------ test example code -----*/
    NSURL *url = [NSURL URLWithString:@"http://people.cs.clemson.edu/~chaoh/ios/example.php"];
    NSMutableURLRequest *requests = [[NSMutableURLRequest alloc]initWithURL:url
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:50];
    
    [requests setHTTPMethod:@"POST"];
    NSDictionary *jsonDic=[NSDictionary dictionaryWithObjectsAndKeys:@"ios_json_data",@"token",@"testid",@"account",@"testid",@"password",nil];
    
    
    
    NSData *data;
    if ([NSJSONSerialization isValidJSONObject:jsonDic])
    {
        NSError *error;
        data = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:&error];
    }
   
    
    [requests setValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
    [requests setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    [requests setHTTPBody:data];

 
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:requests delegate:self];

   // [connection start];
    
    NSHTTPURLResponse *response;
    NSData *respondData = [NSURLConnection sendSynchronousRequest:requests returningResponse:&response error:nil];
    
    if([response respondsToSelector:@selector(allHeaderFields)])
    {
       // NSDictionary *dictionary =  [response allHeaderFields];
        //NSLog([dictionary description]);
        NSLog(@"%@",[[response MIMEType] lowercaseString]);
        NSString *respondBody = [[NSString alloc] initWithData:respondData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",respondBody);
    }
    
    
}


- (NSString *) Json2String: (NSData *) data{
    NSString *jsonstring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Json is %@", jsonstring);
    return jsonstring;

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
