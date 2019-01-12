
//
//  VETMapUtil.m
//  
//
//  Created by JAY on 2019/1/10.
//  Copyright © 2019 . All rights reserved.
//
 //https://lbs.amap.com/api/ios-sdk/guide/map-data/poi/

#import "VETMapUtil.h"

@interface VETMapUtil()<AMapLocationManagerDelegate,AMapNearbySearchManagerDelegate,AMapSearchDelegate>{
    CLLocationCoordinate2D currentCoordinate;
}
@property (nonatomic, strong) AMapLocationManager *locationManager; 

@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *searchPoiArray;
@end
@implementation VETMapUtil

- (instancetype)init{
    self = [super init];
    if (self) {
        self.locationManager = [[AMapLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        //设置不允许系统暂停定位
        [self.locationManager setPausesLocationUpdatesAutomatically:NO];
        //设置允许在后台定位
        [self.locationManager setAllowsBackgroundLocationUpdates:NO];
        //设置允许连续定位逆地理
        [self.locationManager setLocatingWithReGeocode:YES];
    }
    return self;
}

- (void)startUpdateLocation{
    [self.locationManager startUpdatingLocation];
}
- (void)stop{
     [self.locationManager stopUpdatingLocation];
}
- (AMapSearchAPI *)search{
    if(!_search){
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}
// 装载数据坐标
-(NSMutableArray *)searchPoiArray{
    if (!_searchPoiArray) {
        _searchPoiArray = [[NSMutableArray alloc]init];
    }
    return _searchPoiArray;
}

#pragma -mark AMapSearchAPIDelegate
/**
 * @brief 根据中心点坐标来搜周边的POI.
 */
- (void)searchPoiWithCenterCoordinate:(CLLocationCoordinate2D )coord{
    if(self.searchPoiArray.count == 0){
        AMapPOIAroundSearchRequest*request = [[AMapPOIAroundSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:coord.latitude  longitude:coord.longitude];
        request.radius   = 500;             /// 搜索范围
        request.types = @"住宅|学校|楼宇|商场";   ///搜索类型
        request.sortrule = 0;               ///排序规则
        [self.search AMapPOIAroundSearch:request];
    }
}

/**
 * @brief 逆地址编码查询接口
 */
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regeo];
}
/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    [self.searchPoiArray removeAllObjects];
    if (response.pois.count == 0){
        return;
    }
    //解析response获取POI信息，具体解析见 Demo
    NSLog(@" >>> %@",response.pois);
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        // 这里使用了自定义的坐标是为了区分系统坐标 不然蓝点会被替代
//        CurrentLocationAnnotation *annotation = [[CurrentLocationAnnotation alloc] init];
//        [annotation setCoordinate:CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude)];
//        annotation.title = [NSString stringWithFormat:@"%@ - %ld米", obj.name, (long)obj.distance];
//        annotation.subtitle = obj.address;
//        
//        [self.searchPoiArray addObject:annotation];
    }];
    [self.delegate didReceivedPOISearchResults:self.searchPoiArray];
}

#pragma mark - AMapLocationManager Delegate
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
    
    if (error.code == AMapLocationErrorRiskOfFakeLocation) {
        NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.userInfo);
        //存在虚拟定位的风险的定位结果
        __unused CLLocation *riskyLocateResult = [error.userInfo objectForKey:@"AMapLocationRiskyLocateResult"];
        //存在外接的辅助定位设备
        __unused NSDictionary *externalAccressory = [error.userInfo objectForKey:@"AMapLocationAccessoryInfo"];
        [self.delegate didLocationOccurError];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    [self.delegate didUpdateLocation:location.coordinate withAddress:reGeocode.formattedAddress];
    [self searchPoiWithCenterCoordinate:location.coordinate];
    currentCoordinate = location.coordinate;
    [manager stopUpdatingHeading];
}


@end
