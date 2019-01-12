//
//  VETSuperViewController.h
//  
//
//  Created by JAY on 2018/7/28.
//  Copyright © 2018 . All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CheckPhoneCallback)(BOOL registered);

@interface VETSuperViewController : UIViewController


- (void)setupUI;

- (void)setupLayout;

- (void)setupData;

- (void)setNavWithWhiteBackground;
 

@end
