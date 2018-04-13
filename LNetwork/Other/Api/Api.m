//
//  Api.m
//  LNetwork
//
//  Created by idea on 2018/4/11.
//  Copyright © 2018年 idea. All rights reserved.
//

#import "Api.h"

@implementation Api

#define isLoginFlag httpRequest.isLoginFlag  //是否需要token
@synthesize httpRequest;

-(instancetype)init:(id)delegate tag:(NSString *)tag
{
    if (self=[super init]) {
        httpRequest=[[HttpRequestWithCache alloc]initWithDelegate:delegate bindTag:tag];
    }
    return self;
}

-(void)gethello
{
    NSLog(@"🙇‍♀️");
    [httpRequest httpGetCacheRequest:@"hello" params:nil];
}
-(void)getList:(NSString*)goodId
{
    NSMutableDictionary * params =[NSMutableDictionary dictionary];
    [params setObject:goodId forKey:@"id"];
    [httpRequest httpGetRequest:@"aaa" params:params];
}
@end
