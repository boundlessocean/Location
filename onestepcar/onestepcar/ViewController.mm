//
//  ViewController.m
//  onestepcar
//
//  Created by boundlessocean on 2017/8/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import "UIImage+Rotate.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "RouteAnnotation.h"
#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Search/BMKSuggestionSearch.h>

#import "OTPlansInfoView.h"
#import "OTPlaceView.h"
@interface ViewController ()<BMKMapViewDelegate,
BMKLocationServiceDelegate,
BMKRouteSearchDelegate,
BMKGeneralDelegate,
BMKPoiSearchDelegate,
UITextFieldDelegate,
BMKSuggestionSearchDelegate>

// 认证中心-认证状态
typedef NS_ENUM (NSInteger, OTDeiverType){
    
    OTDeiverTypeOne = 100,                        // 方案一
    OTDeiverTypeTwo = 101,                        // 方案二
    OTDeiverTypeThree = 102                       // 方案三
};


@property (strong, nonatomic) IBOutlet BMKMapView *mapView;

/**  */
@property (nonatomic ,strong) OTPlansInfoView *planInfoView;

/**  */
@property (nonatomic ,strong)OTPlaceView *placeView;
@end

@implementation ViewController{
    
    BMKLocationService *_locService;
    BMKRouteSearch *_routesearch;
    NSMutableArray *_plans;
    OTDeiverType _type;
    BMKSuggestionSearch  *_searcher;
    BOOL _isStart;
    NSString *_startName;
    NSString *_endName;
    
}
- (void)viewDidLoad {
    self.title = @"一步专车";
    _plans = [NSMutableArray arrayWithCapacity:0];
    [super viewDidLoad];
    // 定位 位置
    [self locationAddress];
    [self setUpPlaceView];
    // 检索驾车路线
//    [self onClickDriveSearch];
    
    
}

- (void)setUpPlaceView{
    _placeView = [[OTPlaceView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 60)];
    [self.view addSubview:_placeView];
    [_placeView.search addTarget:self action:@selector(searchStart) forControlEvents:UIControlEventTouchUpInside];
    _placeView.startPlace.delegate = self;
    _placeView.endPlace.delegate = self;
}

- (void)searchStart{
    _routesearch = [[BMKRouteSearch alloc]init];
    
    _routesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = _startName;
    start.cityName = @"成都市";
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = _endName;
    end.cityName = @"成都市";
    [self seachPlaceWithName:end.name];
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    drivingRouteSearchOption.drivingRequestTrafficType = BMK_DRIVING_REQUEST_TRAFFICE_TYPE_NONE;//不获取路况信息
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.text != nil && textField == _placeView.startPlace) {
        _isStart = YES;
        [self seachPlaceWithName:textField.text];
    }
    
    if (textField.text != nil && textField == _placeView.endPlace) {
        _isStart = NO;
        [self seachPlaceWithName:textField.text];
    }
}

- (void)setUpPlansInfoView{
    _planInfoView = [[OTPlansInfoView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 100, self.view.bounds.size.width, 100)];
    _planInfoView.dataList = _plans;
    [self.view addSubview:_planInfoView];
}

- (void)dealloc {
    if (_routesearch != nil) {
        _routesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError{
    if(iError ==0){
        
    }
}

#pragma mark - - 定位 位置
- (void)locationAddress{
    //以下_mapView为BMKMapView对象
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.zoomLevel = 17;
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
     [_mapView updateLocationData:userLocation];
}
-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _routesearch.delegate = nil; // 不用时，置nil
    _searcher.delegate = nil;
}


- (void)seachPlaceWithName:(NSString *)name {
//    _searcher =[[BMKPoiSearch alloc]init];
//    _searcher.delegate = self;
//    //发起检索
//    BMKCitySearchOption *option = [[BMKCitySearchOption alloc]init];
////    option.pageIndex = 0;
////    option.pageCapacity = 1;
//    option.keyword = name;
//    option.city = @"成都市";
//    BOOL flag = [_searcher poiSearchInCity:option];
////    [option release];
//    if(flag)
//    {
//        NSLog(@"周边检索发送成功");
//    }
//    else
//    {
//        NSLog(@"周边检索发送失败");
//    }
    
    _searcher =[[BMKSuggestionSearch alloc]init];
    _searcher.delegate = self;
    BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
    option.cityname = @"成都市";
    option.keyword  = name;
    BOOL flag = [_searcher suggestionSearch:option];
//    [option release];
    if(flag)
    {
        NSLog(@"建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
    
}


//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        //在此处理正常结果
        if (_isStart) {
            
            _startName = [result.keyList lastObject];
        }else{
            
            _endName = [result.keyList lastObject];
        }
        
        if (_endName != nil && _endName != nil) {
            _placeView.search.enabled = YES;
        }else{
            _placeView.search.enabled = NO;
        }
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}


//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    
    
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        if (_isStart) {
            _startName = ((BMKPoiInfo *)poiResultList.poiInfoList[0]).name;
        }else{
            
            _endName = ((BMKPoiInfo *)poiResultList.poiInfoList[0]).name;
        }
        
        if (_endName != nil && _endName != nil) {
            _placeView.search.enabled = YES;
        }else{
            _placeView.search.enabled = NO;
        }
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - - 检索驾车路线
-(void)onClickDriveSearch{
    
    
}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [(RouteAnnotation*)annotation getRouteAnnotationView:view];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1];

        polylineView.strokeColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:0.5];
        
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}
#pragma mark - BMKRouteSearchDelegate

- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{

    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        // 计算路线方案中的路段数目
       [result.routes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           if (idx == 3) {
               *stop = YES;
           }
           [self drawDriverLineWithPlan:(BMKDrivingRouteLine *)obj];
           [_plans addObject:obj];
       }];
        
        [self setUpPlansInfoView];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
        //检索地址有歧义,返回起点或终点的地址信息结果：BMKSuggestAddrInfo，获取到推荐的poi列表
        NSLog(@"检索地址有岐义，请重新输入。");
        [self showGuide];
    }
}



// 画驾驶路线
- (void)drawDriverLineWithPlan:(BMKDrivingRouteLine *)plan{

    NSLog(@"plan.distance = %d",plan.distance);
    NSInteger size = [plan.steps count];
    int planPointCounts = 0;
    for (int i = 0; i < size; i++) {
        BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
        if(i==0){
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = plan.starting.location;
            item.title = @"起点";
            item.type = 0;
            [_mapView addAnnotation:item]; // 添加起点标注
            
        }
        if(i==size-1){
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = plan.terminal.location;
            item.title = @"终点";
            item.type = 1;
            [_mapView addAnnotation:item]; // 添加起点标注
        }
        //添加annotation节点
        RouteAnnotation* item = [[RouteAnnotation alloc]init];
        item.coordinate = transitStep.entrace.location;
        item.title = transitStep.entraceInstruction;
        item.degree = transitStep.direction * 30;
        item.type = 4;
        [_mapView addAnnotation:item];
        
        NSLog(@"\n%@  \n %@   \n %@", transitStep.entraceInstruction, transitStep.exitInstruction, transitStep.instruction);
        
        //轨迹点总数累计
        planPointCounts += transitStep.pointsCount;
    }
    // 添加途经点
    if (plan.wayPoints) {
        for (BMKPlanNode* tempNode in plan.wayPoints) {
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item = [[RouteAnnotation alloc]init];
            item.coordinate = tempNode.pt;
            item.type = 5;
            item.title = tempNode.name;
            [_mapView addAnnotation:item];
        }
    }
    //轨迹点
    BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
    int i = 0;
    for (int j = 0; j < size; j++) {
        BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
        int k=0;
        for(k=0;k<transitStep.pointsCount;k++) {
            temppoints[i].x = transitStep.points[k].x;
            temppoints[i].y = transitStep.points[k].y;
            i++;
        }
        
    }
    // 通过points构建BMKPolyline
    BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
    [_mapView addOverlay:polyLine]; // 添加路线overlay
    delete []temppoints;
    [self mapViewFitPolyLine:polyLine];
}

#pragma mark - 私有

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat leftTopX, leftTopY, rightBottomX, rightBottomY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    // 左上角顶点
    leftTopX = pt.x;
    leftTopY = pt.y;
    // 右下角顶点
    rightBottomX = pt.x;
    rightBottomY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        leftTopX = pt.x < leftTopX ? pt.x : leftTopX;
        leftTopY = pt.y < leftTopY ? pt.y : leftTopY;
        rightBottomX = pt.x > rightBottomX ? pt.x : rightBottomX;
        rightBottomY = pt.y > rightBottomY ? pt.y : rightBottomY;
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(leftTopX, leftTopY);
    rect.size = BMKMapSizeMake(rightBottomX - leftTopX, rightBottomY - leftTopY);
    UIEdgeInsets padding = UIEdgeInsetsMake(30, 0, 100, 0);
    BMKMapRect fitRect = [_mapView mapRectThatFits:rect edgePadding:padding];
    [_mapView setVisibleMapRect:fitRect];
}

//检索提示
-(void)showGuide{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检索提示"
                                                    message:@"检索地址有岐义，请重新输入。"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

@end


