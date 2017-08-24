//
//  OTPlaceView.m
//  onestepcar
//
//  Created by boundlessocean on 2017/8/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "OTPlaceView.h"

@interface OTPlaceView ()

/**  */
@property (nonatomic ,strong)UILabel *label;

/**  */
@end

#define width self.bounds.size.width/3
#define height self.bounds.size.height
@implementation OTPlaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.startPlace];
        [self addSubview:self.endPlace];
        [self addSubview:self.label];
        [self addSubview:self.search];
    }
    return self;
}

- (UITextField *)startPlace{
    if (!_startPlace) {
        _startPlace = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, 100, height)];
        _startPlace.placeholder = @"请输入开始位置";
        _startPlace.textColor = [UIColor darkGrayColor];
        _startPlace.font = [UIFont systemFontOfSize:13];
        _startPlace.textAlignment = NSTextAlignmentCenter;
        _startPlace.returnKeyType = UIReturnKeyNext;
    }
    return _startPlace;
}

- (UITextField *)endPlace{
    if (!_endPlace) {
        _endPlace = [[UITextField alloc] initWithFrame:CGRectMake(200+ 30, 0, 100, height)];
        _endPlace.placeholder = @"请输入结束位置";
        _endPlace.textColor = [UIColor darkGrayColor];
        _endPlace.font = [UIFont systemFontOfSize:13];
        _endPlace.textAlignment = NSTextAlignmentCenter;
        _endPlace.returnKeyType = UIReturnKeyNext;
    }
    return _endPlace;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100+30, 0, 100, height)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:15];
        _label.text = @"————";
    }
    return _label;
}


- (UIButton *)search{
    if (!_search) {
        _search = [UIButton buttonWithType:UIButtonTypeCustom];
        _search.frame = CGRectMake(300+30 , 0, 100, height);
        _search.titleLabel.font = [UIFont systemFontOfSize:15];
        [_search setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_search setTitle:@"搜索" forState:UIControlStateNormal];
    }
    return _search;
}
@end
