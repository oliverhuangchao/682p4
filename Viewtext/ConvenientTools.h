//
//  ConvenientTools.h
//  Viewtext
//
//  Created by Chao Huang on 10/8/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvenientTools : NSObject
+(UIImage *) getUserProFileByUserIDFromGlobalDatabase:(NSInteger) userid;
+(NSString *) getUserInfoByUserIDFromGlobalDatabase:(NSInteger) userid:(NSInteger) column;

@end
