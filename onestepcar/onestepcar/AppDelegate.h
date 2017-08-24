//
//  AppDelegate.h
//  onestepcar
//
//  Created by boundlessocean on 2017/8/24.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : NSObject <UIApplicationDelegate, BMKGeneralDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}

@end
