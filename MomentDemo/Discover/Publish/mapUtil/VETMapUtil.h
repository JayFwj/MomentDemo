//
//  VETMapUtil.h
//  
//
//  Created by JAY on 2019/1/10.
//  Copyright © 2019 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol VETMapUtilDelegate <NSObject>
- (void)didLocationOccurError;
- (void)didUpdateLocation:(CLLocationCoordinate2D)location withAddress:(NSString *)address;
- (void)didReceivedPOISearchResults:(NSArray *)result;
@end

@interface VETMapUtil : NSObject

@property(nonatomic,assign) id<VETMapUtilDelegate> delegate;

- (void)startUpdateLocation;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
