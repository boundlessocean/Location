//
//  OTPlaceView.h
//  onestepcar
//
//  Created by boundlessocean on 2017/8/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTPlaceView : UIView

/** 开始点 */
@property (nonatomic ,strong)UITextField *startPlace;
/** 结束点 */
@property (nonatomic ,strong)UITextField *endPlace;

@property (nonatomic ,strong)UIButton *search;
@end
