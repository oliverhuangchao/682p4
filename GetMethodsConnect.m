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
    /*
     [requests setHTTPMethod:@"GET"];
     NSDictionary *jsonDic=[NSDictionary dictionaryWithObjectsAndKeys:@"ios_json_data",@"token",@"testid",@"account",@"testpd",@"password",nil];
     
     NSData *inputData;
     if ([NSJSONSerialization isValidJSONObject:jsonDic])
     {
     NSError *error;
     inputData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:&error];
     }
     
     NSLog(@"%@",[self data2String:inputData]);
     
     [requests setValue:[NSString stringWithFormat:@"%lu",(unsigned long)inputData.length] forHTTPHeaderField:@"Content-Length"];
     [requests setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
     [requests setHTTPBody:inputData];
     
     
     //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:requests delegate:self]; // how to use this function???
     //[connection start];
     */
    
    NSHTTPURLResponse *response;
    NSData *respondData = [NSURLConnection sendSynchronousRequest:requests returningResponse:&response error:nil];
    /*
    if([response respondsToSelector:@selector(allHeaderFields)])
    {
        // NSDictionary *dictionary =  [response allHeaderFields];
        //NSLog([dictionary description]);
        NSLog(@"%@",[[response MIMEType] lowercaseString]);
        NSString *respondBody = [self data2String:respondData];
        NSLog(@"%@",respondBody);
    }
     */
    return respondData;
}

+ (NSString *) data2String: (NSData *) data{
    NSString *jsonstring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonstring;
    
}


@end
