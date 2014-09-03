//
//  TopHeader.m
//  GermanDoctor
//
//  Created by rose on 8/29/14.
//  Copyright (c) 2014 TianLin. All rights reserved.
//

#import "TopHeader.h"
#import "AppDelegate.h"
#import "MainMenuViewController.h"
#import "MainMenuViewController_ipad.h"
@implementation TopHeader
@synthesize m_ivTopHeader;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews;//
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TopHeader_iphone" owner:self options:nil];
        }else
            arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TopHeader_ipad" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UIView class]]) {
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - button handlers
-(IBAction)showMainMenu:(id)sender
{
    AppDelegate* appdelegate = [[UIApplication sharedApplication] delegate];
    if ( [[appdelegate.m_navMain topViewController] isKindOfClass:[MainMenuViewController class]] ) {
        MainMenuViewController* mainmenu = (MainMenuViewController*)[appdelegate.m_navMain topViewController];
        [mainmenu showMainMenu];
    }else if ( [[appdelegate.m_navMain topViewController] isKindOfClass:[MainMenuViewController_ipad class]] ) {
        MainMenuViewController_ipad* mainmenu = (MainMenuViewController_ipad*)[appdelegate.m_navMain topViewController];
        [mainmenu showMainMenu];
    }
}
@end
