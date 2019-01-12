//
//  MainViewController.h
//  GDMapPlaceAroundDemo
//
//  Created by Mr.JJ on 16/6/14.
//  Copyright © 2016年 Mr.JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "VETSuperViewController.h"
@protocol VETLocationViewControllerDelegate<NSObject>
- (void)didReceivedSelectedLoc:(AMapPOI *)mapPOI;
@end

@interface VETLocationViewController : VETSuperViewController

@property (nonatomic,assign) id<VETLocationViewControllerDelegate> delegate;

@end
