//
//  NSString+LYXExtension.m
//  MobileVoip
//
//  Created by Liu Yang on 03/06/2017.
//  Copyright © 2017 . All rights reserved.
//

#import "NSString+LYXExtension.h"

#define ellipsis @"…"

@implementation NSString (LYXExtension)

- (BOOL)isPhoneNumCharacter
{
    if ([self isEqualToString:@""] || //退格
        [self isEqualToString:@"0"] ||
        [self isEqualToString:@"1"] ||
        [self isEqualToString:@"2"] ||
        [self isEqualToString:@"3"] ||
        [self isEqualToString:@"4"] ||
        [self isEqualToString:@"5"] ||
        [self isEqualToString:@"6"] ||
        [self isEqualToString:@"7"] ||
        [self isEqualToString:@"8"] ||
        [self isEqualToString:@"9"] ||
        [self isEqualToString:@"+"] ||
        [self isEqualToString:@"#"] ||
        [self isEqualToString:@"*"] ) {
        return YES;
    }
    return NO;
}

- (CIImage *)generateQRCodeImage{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
    return filter.outputImage;
    
}



@end
