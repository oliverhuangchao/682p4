//
//  ConvenientTools.m
//  Viewtext
//
//  Created by Chao Huang on 10/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "ConvenientTools.h"
#import "GetMethodsConnect.h"
@implementation ConvenientTools


+(UIImage *) getUserProFileByUserIDFromGlobalDatabase:(NSInteger) userid
{
    NSString *userProfileURLString =[NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/getUserInfoByID.php?userID=%d",userid];
    NSData *userProfileData = [GetMethodsConnect getContentFromPhp:userProfileURLString];
    
    NSMutableArray *userProfileArray = [NSJSONSerialization JSONObjectWithData:userProfileData
                                                                       options:kNilOptions
                                                                         error:nil];
    
    NSString *stringProfilePicName = [userProfileArray objectAtIndex:3];
    
    NSString* commonPicString = @"http://people.cs.clemson.edu/~chaoh/ios/pic/";
    
    NSString *picUrlString = [commonPicString stringByAppendingString: stringProfilePicName];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: picUrlString]];
    
    UIImage * returnImage = [UIImage imageWithData:imageData];
    
    return returnImage;
}


+(NSString *) getUserInfoByUserIDFromGlobalDatabase:(NSInteger) userid:(NSInteger) column;
{
    NSString *userProfileURLString =[NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/getUserInfoByID.php?userID=%d",userid];
    NSData *userProfileData = [GetMethodsConnect getContentFromPhp:userProfileURLString];
    
    NSMutableArray *userProfileArray = [NSJSONSerialization JSONObjectWithData:userProfileData
                                                                       options:kNilOptions
                                                                         error:nil];
    
    NSString *resultString = [userProfileArray objectAtIndex:column];
    
    return resultString;
}


@end
