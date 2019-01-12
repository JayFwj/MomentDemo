//
//  NSDictionary+API.m
//  
//
//  Created by JAY on 2018/8/2.
//  Copyright © 2018 . All rights reserved.
//

#import "NSDictionary+API.h"

@implementation NSDictionary (API)

- (BOOL)isStatus200
{
    NSString *status = [NSString stringWithFormat:@"%@",self[@"status"]];
    if([@"200" isEqualToString:status])
    {
        return YES;
    }else
    {
        return NO;
    }
}

- (NSString *)errorMsg
{
    return self[@"msg"];
}

- (NSDictionary *)dataDic
{
    return self[@"data"];
}



@end
