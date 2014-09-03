//
//  AppDelegate.m
//  GermanDoctor
//
//  Created by rose on 8/28/14.
//  Copyright (c) 2014 TianLin. All rights reserved.
//
/* Imported Font Names
    AgfaRotisSansSerif-Bold
    AgfaRotisSansSerif-Italic
    AgfaRotisSansSerif
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
*/

#import "AppDelegate.h"
#import "MainMenuViewController.h"
#import "MainMenuViewController_ipad.h"
@implementation AppDelegate
@synthesize m_navMain, m_vcMainMenu;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        m_vcMainMenu = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    else
        m_vcMainMenu = [[MainMenuViewController_ipad alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    m_navMain = [[UINavigationController alloc] initWithRootViewController:m_vcMainMenu];
    [m_navMain setNavigationBarHidden:YES];
    self.window.rootViewController = m_navMain;
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end