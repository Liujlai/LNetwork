//
//  Api.h
//  LNetwork
//
//  Created by idea on 2018/4/11.
//  Copyright © 2018年 idea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestWithCache.h"
@interface Api : NSObject

@property (nonatomic,strong)  HttpRequestWithCache *httpRequest;

-(instancetype)init:(id)delegate tag:(NSString *)tag;


#pragma mark 接口管理

-(void)gethello;

-(void)getList:(NSString*)goodId;
@end
