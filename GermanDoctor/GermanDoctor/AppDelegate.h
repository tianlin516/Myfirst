//
//  AppDelegate.h
//  GermanDoctor
//
//  Created by rose on 8/28/14.
//  Copyright (c) 2014 TianLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController       *m_navMain;
@property (strong, nonatomic) UIViewController             *m_vcMainMenu;


//-(void) getAllCacheData:(void (^)(NSString *data))block;
@end
