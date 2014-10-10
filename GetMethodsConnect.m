//
//  GetMethodsConnect.m
//  Viewtext
//
//  Created by Chao Huang on 9/20/14.
//  Copyright (c) 2014 Clemson. All rights reserved.
//

#import "GetMethodsConnect.h"

@implementation GetMethodsConnect

+ (NSData *) getContentFromPhp:(NSString *)urlstring
{
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *requests = [[NSMutableURLRequest alloc]initWithURL:url
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:50];
    
    NSHTTPURLResponse *response;
    NSData *respondData = [NSURLConnection sendSynchronousRequest:requests returningResponse:&response error:nil];
       return respondData;
}

+ (NSString *) data2String: (NSData *) data{
    NSString *jsonstring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonstring;
    
}


@end
