//
//  NSString+LYXExtension.h
//  MobileVoip
//
//  Created by Liu Yang on 03/06/2017.
//  Copyright © 2017 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LYXExtension)

- (BOOL)isPhoneNumCharacter;

- (CIImage *)generateQRCodeImage;

@end
