//
//  OTInfoDetaiView.h
//  onestepcar
//
//  Created by boundlessocean on 2017/8/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Search/BMKRouteSearch.h>
@interface OTInfoDetaiView : UIView
/**  */
@property(nonatomic,copy) void(^OTInfoDeailViewActionBlock)();

/**  */
@property (nonatomic ,strong)BMKDrivingRouteLine *lineInfo;
/**  */
@property (nonatomic ,strong)NSString *name;
@end
