//
//  MainMenuViewController.h
//  GermanDoctor
//
//  Created by rose on 8/29/14.
//  Copyright (c) 2014 TianLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController_ipad : UIViewController

@property(strong, nonatomic) IBOutlet UIView* m_viewTopHeader;
@property(strong, nonatomic) IBOutlet UITableView* m_tblContent;
@property(strong, nonatomic) IBOutlet UIImageView* m_viewActionSide;
@property(strong, nonatomic) IBOutlet UIView* m_viewActionEntire;

/// for ipad in landscape & potrait
@property(strong, nonatomic) IBOutlet UIImageView*      m_ivFooter;
@property(strong, nonatomic) IBOutlet UILabel*          m_labelFooter;
@property(strong, nonatomic) IBOutlet UIButton*         m_btnHidBigButton;

@property(strong, nonatomic) IBOutlet UIView*           m_viewVideoIntroducion;
@property(strong, nonatomic) IBOutlet UICollectionView* m_cvContent;
@property(strong, nonatomic) IBOutlet UILabel*          m_lblRecentVideoTitleList;
@property(strong, nonatomic) IBOutlet UILabel*          m_lblVideoTitle;
@property(strong, nonatomic) IBOutlet UILabel*          m_lblVideoDescription;

@property(strong, nonatomic) IBOutlet UIImageView*      m_ivTitleImageBack;
@property(strong, nonatomic) IBOutlet UIView*           m_viewVideo;

-(void) showMainMenu;
-(IBAction)hideMenu:(id)sender;
@end
