//
//  OTInfoDetaiView.m
//  onestepcar
//
//  Created by boundlessocean on 2017/8/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "OTInfoDetaiView.h"
@interface OTInfoDetaiView ()
/** 距离 */
@property (nonatomic ,strong)UILabel *distance;
/** 价格 */
@property (nonatomic ,strong)UILabel *price;

/**  */
@property (nonatomic ,strong)UILabel *planName;

/**  */
@property (nonatomic ,strong)UILabel *time;
@end

#define height self.bounds.size.height/4
@implementation OTInfoDetaiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.distance];
        [self addSubview:self.price];
        [self addSubview:self.time];
        [self addSubview:self.planName];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)viewClick{
    !_OTInfoDeailViewActionBlock ? : _OTInfoDeailViewActionBlock();
}

- (UILabel *)distance{
    if (!_distance) {
        _distance = [[UILabel alloc] initWithFrame:CGRectMake(0, height , self.bounds.size.width, height)];
        _distance.textColor = [UIColor darkGrayColor];
        _distance.font = [UIFont boldSystemFontOfSize:13];
        _distance.textAlignment = NSTextAlignmentCenter;
    }
    return _distance;
}

- (UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc] initWithFrame:CGRectMake(0, 2 * height, self.bounds.size.width, height)];
        _price.textColor = [UIColor redColor];
        _price.font = [UIFont systemFontOfSize:15];
        _price.textAlignment = NSTextAlignmentCenter;
    }
    return _price;
}

- (UILabel *)planName{
    if (!_planName) {
        _planName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, height)];
        
        _planName.textColor = [UIColor darkGrayColor];
        _planName.font = [UIFont systemFontOfSize:16];
        _planName.textAlignment = NSTextAlignmentCenter;
    }
    return _planName;
}

- (UILabel *)time{

    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(0, 3 * height, self.bounds.size.width, height)];
        
        _time.textColor = [UIColor darkGrayColor];
        _time.font = [UIFont systemFontOfSize:13];
        _time.textAlignment = NSTextAlignmentCenter;
    }
    
    return _time;
}

//- (void)setPrice:(NSString *)price distance:(CGFloat )distance{
//    
//    if (distance - 1 < 0) {
//        _price.text = @"5元";
//    }else{
//        (distance - 1)
//    }
//    
//    _price.text = price;
//}

- (void)setLineInfo:(BMKDrivingRouteLine *)lineInfo{
    CGFloat distance = lineInfo.distance/1000.0;
    CGFloat secend = lineInfo.duration.minutes;
    _distance.text = [NSString stringWithFormat:@"%.2f公里",distance];
    NSInteger price = ceilf(distance)*5 + secend*2;
    _price.text = [NSString stringWithFormat:@"%ld元",(long)price];
    _time.text = [NSString stringWithFormat:@"%ld分钟",(long)secend];
}


- (void)setName:(NSString *)name{
    _planName.text = name;
    
}
@end
