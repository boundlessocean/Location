//
//  OTPlansInfoView.m
//  onestepcar
//
//  Created by boundlessocean on 2017/8/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "OTPlansInfoView.h"
#import "OTInfoDetaiView.h"
@interface OTPlansInfoView ()
/**  */
@property (nonatomic ,strong)OTInfoDetaiView *one;
/**  */
@property (nonatomic ,strong)OTInfoDetaiView *two;
/**  */
@property (nonatomic ,strong)OTInfoDetaiView *three;
@end
@implementation OTPlansInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.one];
        [self addSubview:self.two];
        [self addSubview:self.three];
    }
    return self;
}

- (void)setDataList:(NSArray<BMKDrivingRouteLine *> *)dataList{
    _dataList = dataList;
    if (_dataList.count > 0) {
        self.one.lineInfo = _dataList[0];
    }
    if (_dataList.count > 1) {
        self.two.lineInfo = _dataList[1];
    }
    if (_dataList.count > 2) {
        self.three.lineInfo = _dataList[2];
    }
}

- (OTInfoDetaiView *)one{
    if (!_one) {
        _one = [[OTInfoDetaiView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width/3, self.bounds.size.height)];
        _one.name = @"方案一";
    }
    return _one;
}

- (OTInfoDetaiView *)two{
    if (!_two) {
        _two = [[OTInfoDetaiView alloc] initWithFrame:CGRectMake(self.bounds.size.width/3, 0, self.bounds.size.width/3, self.bounds.size.height)];
        _two.name = @"方案二";
    }
    return _two;
}

- (OTInfoDetaiView *)three{
    if (!_three) {
        _three = [[OTInfoDetaiView alloc] initWithFrame:CGRectMake(2 * self.bounds.size.width/3, 0, self.bounds.size.width/3, self.bounds.size.height)];
        _three.name = @"方案三";
    }
    return _three;
}

@end
