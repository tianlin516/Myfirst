//  MainMenuViewController.m
//  GermanDoctor
//
//  Created by rose on 8/29/14.
//  Copyright (c) 2014 TianLin. All rights reserved.
#import <QuartzCore/QuartzCore.h>
#import "MainMenuViewController_ipad.h"
#import "ManuMenuContentTableViewCell.h"
#import "TopHeader.h"
#import "CVCell_MainMenu.h"
#import "CHTCollectionViewWaterfallLayout.h"
#define ARRAY_WIDTH @[ 310, 215, 215, 86, 7, 56, 69]

@interface MainMenuViewController_ipad () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CHTCollectionViewDelegateWaterfallLayout>
{
    NSMutableArray* m_arrContentTableDatas;
    float           m_fAvailableHeight;
    float           m_farrWidths[7];

    float FONT_SIZE;

    float TITLE_FONT_SIZE;
    float NAME_FONT_SIZE;
    float DESCRIPTION_FONT_SIZE;

    float DATE_FONT_SIZE;
    float SEPARATOR_FONT_SIZE;
    float DURATION_FONT_SIZE;
    float TIME_FONT_SIZE;

    NSString* TITLE_FONT_FAMILY;
    NSString* NAME_FONT_FAMILY;
    NSString* DESCRIPTION_FONT_FAMILY;

    NSString* DATE_FONT_FAMILY;
    NSString* SEPARATOR_FONT_FAMILY;
    NSString* DURATION_FONT_FAMILY;
    NSString* TIME_FONT_FAMILY;

    //#define CELL_CONTENT_WIDTH         310.0f
    float CELL_CONTENT_TOP_MARGIN;
    float CELL_CONTENT_BOTTOM_MARGIN;
    float CELL_CONTENT_RIGHT_MARGIN;
    float CELL_CONTENT_LEFT_MARGIN;

    float CONTENT_TOP_MARGIN;
    float CONTENT_WIDTH_MARGIN;
    float CONTENT_BOTTOM_MARGIN;

    float PHOTO_HEIGHT_VER_MARGIN;
    float PHOTO_WIDTH_RIGHT_MARGIN;

    float PHOTO_SIZE;
    float CELL_WIDTH;
    float CELL_HEIGHT;

    float m_fscale;
    float m_fscaleX;
    float m_fscaleY;

    UIInterfaceOrientation m_enOrientation;
    float m_fScreenWidth;
    float m_fScreenHeight;

    BOOL  m_bMenuShowing;
}
@end

@implementation  MainMenuViewController_ipad
@synthesize      m_viewTopHeader, m_tblContent;
@synthesize      m_viewActionSide,m_viewActionEntire;
@synthesize      m_ivFooter, m_labelFooter, m_btnHidBigButton;
@synthesize      m_viewVideoIntroducion, m_cvContent;
@synthesize      m_lblRecentVideoTitleList;
@synthesize      m_lblVideoTitle, m_lblVideoDescription;
@synthesize      m_ivTitleImageBack, m_viewVideo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString* str = [NSString stringWithFormat:@"%@_ipad", nibNameOrNil];

    self = [super initWithNibName:str bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_bMenuShowing = false;
    [self initMemberVariables];

    // Do any additional setup after loading the view from its nib.

    [m_viewTopHeader removeFromSuperview];
    m_viewTopHeader = [[TopHeader alloc] init];
    [self.view addSubview:m_viewTopHeader];

    self.m_viewActionEntire.hidden = YES;
    self.m_btnHidBigButton.hidden = YES;

    self.m_viewActionEntire.layer.masksToBounds = NO;
    self.m_viewActionEntire.layer.shadowOpacity = 0.5;
    self.m_viewActionEntire.layer.shadowOffset = CGSizeMake(7, 0);

    self.m_viewVideoIntroducion.layer.borderWidth   = 0.5;
    self.m_viewVideoIntroducion.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    self.m_viewVideoIntroducion.layer.cornerRadius  = 5;

    //self.m_btnHidBigButton.hidden = YES;
    self.m_btnHidBigButton.frame = CGRectMake(self.m_btnHidBigButton.frame.origin.x, 0, self.m_btnHidBigButton.frame.size.width, self.m_btnHidBigButton.frame.size.height);
    //m_viewTopHeader.frame = CGRectMake( m_viewTopHeader.frame.origin.x, 0, m_fScreenWidth, 102 );
    {  ////////collection view layout
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];

        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.headerHeight = 0;
        layout.footerHeight = 0;
        layout.minimumColumnSpacing = 0;
        layout.minimumInteritemSpacing = 0;

        m_cvContent.collectionViewLayout = layout;
        [m_cvContent registerClass:[CVCell_MainMenu class] forCellWithReuseIdentifier:@"CVContentID"];
    }
    { // Recent Video, Text
        float RECENT_TITLE_FONT_SIZE = 23;
        UIColor *c = [UIColor colorWithRed:0.0/255.0 green:63.0/255.0 blue:114.0/255.0 alpha:1.0];
        m_lblRecentVideoTitleList.textColor = c;
        [m_lblRecentVideoTitleList setFont:[UIFont fontWithName:@"AgfaRotisSansSerif-Bold" size:RECENT_TITLE_FONT_SIZE]];
        
        float VIDEO_TITLE_FONT_SIZE = 23;
        m_lblVideoTitle.textColor = c;
        [m_lblVideoTitle setFont:[UIFont fontWithName:@"AgfaRotisSansSerif-Bold" size:VIDEO_TITLE_FONT_SIZE]];
        
        float VIDEO_DESCRIPTION_FONT_SIZE = 20;
        c = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        m_lblVideoDescription.textColor = c;
        [m_lblVideoDescription setFont:[UIFont fontWithName:@"AgfaRotisSansSerif" size:VIDEO_DESCRIPTION_FONT_SIZE]];
    }
    [self configureConstraintsForContentViewsForInterfaceOrientation:self.interfaceOrientation duration:0.5]; //0.5 has not meaning
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - init
- (void)initMemberVariables
{
    m_arrContentTableDatas = [[NSMutableArray alloc] init];
    NSDictionary* dict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Einleitung aus radiologischer Sicht",@"title",
                          @"Walter Hruby", @"name",
                          @"(Institut für Röntgendiagnostik, SMZ-Ost - Donauspital)", @"description",
                          @"15.01.2014", @"date",
                          @"Dauer:", @"duration",
                          @"09:55", @"time",
                          nil];
    NSDictionary* dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Wege und Irrwege in der Therapiekontrolle zielgerichteter Therapien mittels PET",@"title",
                           @"Thomas Leitha", @"name",
                           @"(Abteilung für Nuklearmedizinische Diagnostik und Therapie, SMZ-Ost - Donauspital)",@"description",
                           @"15.01.2014", @"date",
                           @"Dauer:", @"duration",
                           @"20:19", @"time",
                           nil];
    NSDictionary* dict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Einleitung aus radiologischer Sicht",@"title",
                           @"Walter Hruby", @"name",
                           @"(Institut für Röntgendiagnostik, SMZ-Ost - Donauspital)", @"description",
                           @"15.01.2014", @"date",
                           @"Dauer:", @"duration",
                           @"09:55", @"time",
                           nil];
    NSDictionary* dict4 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Wege und Irrwege in der Therapiekontrolle zielgerichteter Therapien mittels PET",@"title",
                           @"Thomas Leitha", @"name",
                           @"(Abteilung für Nuklearmedizinische Diagnostik und Therapie, SMZ-Ost - Donauspital)",@"description",
                           @"15.01.2014", @"date",
                           @"Dauer:", @"duration",
                           @"20:19", @"time",
                           nil];
    [m_arrContentTableDatas addObject:dict1];
    [m_arrContentTableDatas addObject:dict2];
    [m_arrContentTableDatas addObject:dict3];
    [m_arrContentTableDatas addObject:dict4];

    if ( self.interfaceOrientation == UIInterfaceOrientationPortrait  )
    {
        m_fScreenWidth  = 768;
        m_fScreenHeight = 1024;
    }
    else if ( self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
    {
        m_fScreenWidth  = 768;
        m_fScreenHeight = 1024;
    }
    else if ( self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft )
    {
        m_fScreenWidth  = 1024;
        m_fScreenHeight = 768;
    }
    else if ( self.interfaceOrientation == UIInterfaceOrientationLandscapeRight )
    {
        m_fScreenWidth  = 1024;
        m_fScreenHeight = 768;
    }
//    m_fscaleX = m_fScreenWidth  / 320;
//    m_fscaleY = m_fScreenHeight / 480;
//    m_fscale = MIN(m_fscaleX, m_fscaleY);

    FONT_SIZE = 18;
    TITLE_FONT_SIZE       = 18.0f;
    NAME_FONT_SIZE        = 15.0f;
    DESCRIPTION_FONT_SIZE = 12.0f;
    DATE_FONT_SIZE        = 15.0f;
    SEPARATOR_FONT_SIZE   = 15.0f;
    DURATION_FONT_SIZE    = 15.0f;
    TIME_FONT_SIZE        = 15.0f;

    TITLE_FONT_FAMILY           =  @"AgfaRotisSansSerif-Bold";
    NAME_FONT_FAMILY            =  @"AgfaRotisSansSerif-Bold";
    DESCRIPTION_FONT_FAMILY     =  @"AgfaRotisSansSerif";
    DATE_FONT_FAMILY            =  @"AgfaRotisSansSerif";
    SEPARATOR_FONT_FAMILY       =  @"AgfaRotisSansSerif";
    DURATION_FONT_FAMILY        =  @"AgfaRotisSansSerif-Bold";
    TIME_FONT_FAMILY            =  @"AgfaRotisSansSerif";
    //#define CELL_CONTENT_WIDTH         310.0f
    CELL_CONTENT_TOP_MARGIN = 15.0f;  //// cell margin
    CELL_CONTENT_BOTTOM_MARGIN = 0.0f;
    CELL_CONTENT_LEFT_MARGIN = 10.0f;
    CELL_CONTENT_RIGHT_MARGIN = 5.0f;
    CONTENT_TOP_MARGIN = 5.0f;  //// content margin
    CONTENT_BOTTOM_MARGIN = 5.0f;
    CONTENT_WIDTH_MARGIN = 10.0f;
    PHOTO_HEIGHT_VER_MARGIN = 10.0f;
    PHOTO_WIDTH_RIGHT_MARGIN = 10.0f;
    PHOTO_SIZE = 70.0f;

    m_fAvailableHeight = 0;
    m_fscaleX = m_fScreenWidth  / 768;
    m_fscaleY = m_fScreenHeight / 1024;
    m_farrWidths[0] = 369*m_fscaleX-( CONTENT_WIDTH_MARGIN )*2 - CELL_CONTENT_LEFT_MARGIN-CELL_CONTENT_RIGHT_MARGIN;
    m_farrWidths[1] = 369*m_fscaleX-( CONTENT_WIDTH_MARGIN )*2
            - CELL_CONTENT_LEFT_MARGIN-CELL_CONTENT_RIGHT_MARGIN
            -PHOTO_SIZE-PHOTO_WIDTH_RIGHT_MARGIN;
    m_farrWidths[2] = 369*m_fscaleX-(CONTENT_WIDTH_MARGIN)*2- CELL_CONTENT_LEFT_MARGIN-CELL_CONTENT_RIGHT_MARGIN -PHOTO_SIZE-PHOTO_WIDTH_RIGHT_MARGIN;
    m_farrWidths[3] = 95 * m_fscaleX;
    m_farrWidths[4] = 10 * m_fscaleX;
    m_farrWidths[5] = 60 * m_fscaleX;
    m_farrWidths[6] = 75 * m_fscaleX;

    m_tblContent.frame = CGRectMake(m_tblContent.frame.origin.x, m_tblContent.frame.origin.y, m_fScreenWidth, m_fScreenHeight);
}
#pragma mark - event methods
-(void) showMainMenu
{
    if (m_bMenuShowing) {
        return;
    }
    m_bMenuShowing = true;

    m_viewActionEntire.hidden = NO;
    m_viewActionSide.hidden = YES;
    //[m_viewActionSide setImage:[self imageWithView:m_viewActionSide]];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    double delayInSeconds = 0.01;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(480, 0, m_fScreenWidth, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            self.m_btnHidBigButton.hidden = NO;
        }];
    });
}
-(IBAction)hideMenu:(id)sender
{
    if (!m_bMenuShowing) {
        return;
    }
    m_bMenuShowing = false;
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = CGRectMake(0, 0, m_fScreenWidth, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        m_viewActionEntire.hidden = YES;
        self.m_btnHidBigButton.hidden = YES;
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [m_arrContentTableDatas count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    /////if you are using uncustom class
    CVCell_MainMenu* cell = (CVCell_MainMenu*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CVContentID" forIndexPath:indexPath];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    /////////////initializing cell values
    NSDictionary* dict = [m_arrContentTableDatas objectAtIndex:indexPath.row];
    m_fAvailableHeight = CONTENT_TOP_MARGIN;

    float f_x = CONTENT_WIDTH_MARGIN;
    [self fitUILabel:cell.m_labelTitle text:[dict objectForKey:@"title"] x:f_x width:(float)m_farrWidths[0] heightplusable:YES font_size:TITLE_FONT_SIZE font_family:TITLE_FONT_FAMILY];
    cell.m_ivPhoto.frame = CGRectMake( f_x, m_fAvailableHeight + PHOTO_HEIGHT_VER_MARGIN, PHOTO_SIZE, PHOTO_SIZE );
    f_x = CONTENT_WIDTH_MARGIN + PHOTO_WIDTH_RIGHT_MARGIN + PHOTO_SIZE;
    m_fAvailableHeight = m_fAvailableHeight + PHOTO_HEIGHT_VER_MARGIN;
    [self fitUILabel:cell.m_labelName text:[dict objectForKey:@"name"] x:f_x  width:m_farrWidths[1] heightplusable:YES
           font_size:NAME_FONT_SIZE font_family:NAME_FONT_FAMILY];
    [self fitUILabel:cell.m_labelDescription text:[dict objectForKey:@"description"] x:f_x width:m_farrWidths[2]  heightplusable:YES font_size:DESCRIPTION_FONT_SIZE font_family:DESCRIPTION_FONT_FAMILY];
    [self fitUILabel:cell.m_labelDate text:[dict objectForKey:@"date"] x:f_x width:m_farrWidths[3] heightplusable:NO
           font_size:DATE_FONT_SIZE font_family:DATE_FONT_FAMILY];
    [cell.m_labelDate sizeToFit];
    f_x += cell.m_labelDate.frame.size.width;
    [self fitUILabel:cell.m_labelSeparator text:@"|" x:f_x  width:m_farrWidths[4] heightplusable:NO
           font_size:SEPARATOR_FONT_SIZE font_family:SEPARATOR_FONT_FAMILY];
    cell.m_labelSeparator.textAlignment = NSTextAlignmentCenter;
    f_x += m_farrWidths[4];
    [self fitUILabel:cell.m_labelDuration text:[dict objectForKey:@"duration"] x:f_x width:m_farrWidths[5] heightplusable:NO
           font_size:DURATION_FONT_SIZE font_family:DURATION_FONT_FAMILY];
    [cell.m_labelDuration sizeToFit];
    f_x += cell.m_labelDuration.frame.size.width;
    [self fitUILabel:cell.m_labelTime text:[dict objectForKey:@"time"] x:f_x width:m_farrWidths[6] heightplusable:NO
           font_size:TIME_FONT_SIZE font_family:TIME_FONT_FAMILY];

    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    if (indexPath.row%2 == 0) {
        cell.m_viewContent.frame = CGRectMake(CELL_CONTENT_LEFT_MARGIN, CELL_CONTENT_TOP_MARGIN, cell.frame.size.width-CELL_CONTENT_LEFT_MARGIN-CELL_CONTENT_RIGHT_MARGIN, cell.frame.size.height-CELL_CONTENT_BOTTOM_MARGIN-CELL_CONTENT_TOP_MARGIN);
    }
    else
    {
        cell.m_viewContent.frame = CGRectMake(CELL_CONTENT_RIGHT_MARGIN, CELL_CONTENT_TOP_MARGIN, cell.frame.size.width-CELL_CONTENT_LEFT_MARGIN-CELL_CONTENT_RIGHT_MARGIN, cell.frame.size.height-CELL_CONTENT_BOTTOM_MARGIN-CELL_CONTENT_TOP_MARGIN);
    }

    cell.m_viewContent.layer.borderWidth   = 0.5;
    cell.m_viewContent.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    cell.m_viewContent.layer.cornerRadius  = 9;
    cell.m_viewContent.layer.shadowOpacity = 0;
    return cell;
}
-(void) fitUILabel:(UILabel*)label text:(NSString*)text x:(float)x width:(float)width heightplusable:(BOOL)plusable font_size:(float)font_size font_family:(NSString*)font_family
{
    CGSize constraint = CGSizeMake( width, 20000.0f );
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:[UIFont fontWithName:font_family size:font_size]}];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    //    if (!cell.m_labelTitle)
    //        cell.m_labelTitle = (UILabel*)[cell viewWithTag:1];
    label.text       = text;
    [label setFrame:CGRectMake(x, m_fAvailableHeight, width, size.height)];//

    //[label sizeToFit];
    if (plusable == YES)
        m_fAvailableHeight += size.height;//size.height;
}
-(float) getUILabelHeight:(UILabel*)label str:(NSString*)str width:(CGFloat)width font_family:(NSString*)font_family font_size:(float)font_size
{
    NSString *text = str;
    CGSize constraint = CGSizeMake(width, 20000.0f);
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
         NSFontAttributeName:[UIFont fontWithName:font_family size:font_size]
     }];

    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    return size.height;
}

#pragma mark - UICollectionViewDelegate
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    int h = 150+rand()%100;
//    return CGSizeMake(364, h);
//}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str[4] = {
        [[m_arrContentTableDatas objectAtIndex:[indexPath row]] objectForKey:@"title"],
        [[m_arrContentTableDatas objectAtIndex:[indexPath row]] objectForKey:@"name"],
        [[m_arrContentTableDatas objectAtIndex:[indexPath row]] objectForKey:@"description"],
        [[m_arrContentTableDatas objectAtIndex:[indexPath row]] objectForKey:@"date"]};
    CGFloat height = 0;//MAX(size.height, 100.0f);
    CGFloat photo_height = 0;

    float font_size[4]       = { TITLE_FONT_SIZE, NAME_FONT_SIZE, DESCRIPTION_FONT_SIZE, DATE_FONT_SIZE };
    NSString* font_family[4] = { TITLE_FONT_FAMILY, NAME_FONT_FAMILY, DESCRIPTION_FONT_FAMILY, DATE_FONT_FAMILY };
    for (int i=0; i < 4; i++) {
        float f_height = [self getUILabelHeight:nil str:str[i] width:m_farrWidths[i] font_family:font_family[i] font_size:font_size[i]];
        height += f_height;

        if (i>0)
            photo_height += f_height;
    }
    if (photo_height < 70 + PHOTO_HEIGHT_VER_MARGIN * 2 ) {
        height += (70 + PHOTO_HEIGHT_VER_MARGIN * 2 - photo_height);
    }else height += PHOTO_HEIGHT_VER_MARGIN;
    height += CELL_CONTENT_TOP_MARGIN + CELL_CONTENT_BOTTOM_MARGIN + CONTENT_TOP_MARGIN + CONTENT_BOTTOM_MARGIN;

    return CGSizeMake(369*m_fscaleX, height);//m_fScreenWidth*0.5f
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark orientation - deleagate
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //REDRAWING
    [self configureConstraintsForContentViewsForInterfaceOrientation:toInterfaceOrientation duration:duration];
}
- (void)configureConstraintsForContentViewsForInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration
{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//        return;
    //REDRAWING
    [self initMemberVariables];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001f *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        { //Footer & Header
            float header_height, footer_height;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            {
                header_height = 102; footer_height = 82;
            }
            else{
                header_height = 57; footer_height = 46;
            }
            m_viewTopHeader.frame = CGRectMake( m_viewTopHeader.frame.origin.x, 0, m_fScreenWidth, header_height );
            m_ivFooter.frame      = CGRectMake( m_viewTopHeader.frame.origin.x, m_fScreenHeight - footer_height, m_fScreenWidth, footer_height );

            m_labelFooter.frame   = CGRectMake( m_viewTopHeader.frame.origin.x, m_fScreenHeight - footer_height, m_fScreenWidth, footer_height );
        }

        { //hide menu, big button resizing
            UIImageView* topimage = [(TopHeader*)m_viewTopHeader m_ivTopHeader];
            topimage.frame = CGRectMake(m_viewTopHeader.frame.origin.x + m_fScreenWidth - topimage.frame.size.width - 18, topimage.frame.origin.y, topimage.frame.size.width, topimage.frame.size.height);
            
//            float kBorderWidth= 3.0;
//            float kCornerRadius= 1.0;
//            CALayer *borderLayer = [CALayer layer];
//            CGRect borderFrame = CGRectMake(0, 0, (topimage.frame.size.width), (topimage.frame.size.height));
//            [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
//            [borderLayer setFrame:borderFrame];
//            [borderLayer setCornerRadius:kCornerRadius];
//            [borderLayer setBorderWidth:kBorderWidth];
//            [borderLayer setBorderColor:[[UIColor redColor] CGColor]];
//            [topimage.layer addSublayer:borderLayer];

//            topimage.layer.borderWidth = 5;
//            topimage.layer.borderColor = [UIColor lightGrayColor].CGColor;

            m_btnHidBigButton.frame = CGRectMake(
                0, m_btnHidBigButton.frame.origin.y,
                m_fScreenWidth - m_viewActionEntire.frame.size.width, m_fScreenHeight );
        }
        { // recent videos
            m_ivTitleImageBack.frame = CGRectMake( m_ivTitleImageBack.frame.origin.x, m_ivTitleImageBack.frame.origin.y, m_fScreenWidth+6, m_ivTitleImageBack.frame.size.height );

            m_ivTitleImageBack.layer.borderWidth = 1.0f;
            m_ivTitleImageBack.layer.borderColor = [UIColor lightGrayColor].CGColor;

//            m_ivTitleImageBack.layer.shadowColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
//            m_ivTitleImageBack.layer.shadowOffset = CGSizeMake(5, 5);
//            m_ivTitleImageBack.layer.shadowOpacity = 1;
//            m_ivTitleImageBack.layer.shadowRadius = 1.0;
//            m_ivTitleImageBack.layer.masksToBounds = NO;
            //m_ivTitleImageBack.clipsToBounds = YES;
            m_ivTitleImageBack.layer.masksToBounds = NO;
            m_ivTitleImageBack.layer.shadowOpacity = 0.3;
            m_ivTitleImageBack.layer.shadowOffset = CGSizeMake(0, 2);
        }
        { // video introduction
            if (m_fScreenWidth == 1024)
                m_viewVideo.frame = CGRectMake(m_viewVideo.frame.origin.x, m_viewVideo.frame.origin.y, m_fScreenWidth, m_viewVideo.frame.size.height);
            else
                m_viewVideo.frame = CGRectMake(m_viewVideo.frame.origin.x, m_viewVideo.frame.origin.y, m_fScreenWidth, m_viewVideo.frame.size.height);

        }
        { // sidemenu position

        }
        { // table redrawing
            [m_cvContent reloadData];
        }
        { //
            if (m_bMenuShowing) {
               self.view.frame = CGRectMake(480, 0, 1400, m_fScreenHeight);
            }
            //self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, m_fScreenWidth, m_fScreenHeight);
        }
    });
}

@end
//#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *str[4] = {
//        [[m_arrContentTableDatas objectAtIndex:[indexPath row]] objectForKey:@"title"],
//        [[m_arrContentTableDatas objectAtIndex:[indexPath row]] objectForKey:@"name"],
//        [[m_arrContentTableDatas objectAtIndex:[indexPath row]] objectForKey:@"description"],
//        [[m_arrContentTableDatas objectAtIndex:[indexPath row]] objectForKey:@"date"]};
//    CGFloat height = 0;//MAX(size.height, 100.0f);
//    CGFloat photo_height = 0;
//
//    float font_size[4]       = { TITLE_FONT_SIZE, NAME_FONT_SIZE, DESCRIPTION_FONT_SIZE, DATE_FONT_SIZE };
//    NSString* font_family[4] = { TITLE_FONT_FAMILY, NAME_FONT_FAMILY, DESCRIPTION_FONT_FAMILY, DATE_FONT_FAMILY };
//    for (int i=0; i < 4; i++) {
//        float f_height = [self getUILabelHeight:nil str:str[i] width:m_farrWidths[i] font_family:font_family[i] font_size:font_size[i]];
//        height += f_height;
//
//        if (i>0)
//            photo_height += f_height;
//    }
//    if (photo_height < 70 + PHOTO_HEIGHT_VER_MARGIN * 2 ) {
//        height += (70 + PHOTO_HEIGHT_VER_MARGIN * 2 - photo_height);
//    }else height += PHOTO_HEIGHT_VER_MARGIN;
//    height += CELL_CONTENT_TOP_MARGIN + CELL_CONTENT_BOTTOM_MARGIN + CONTENT_TOP_MARGIN + CONTENT_BOTTOM_MARGIN;
//    return height;
//}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ManuMenuContentTableViewCell* cell1 = (ManuMenuContentTableViewCell*)cell;
//    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.x, m_fScreenWidth,cell.frame.size.height);
//
//    cell1.m_viewContent.frame = CGRectMake(CELL_CONTENT_WIDTH_MARGIN, CELL_CONTENT_TOP_MARGIN, m_fScreenWidth-CELL_CONTENT_WIDTH_MARGIN*2, cell.frame.size.height-CELL_CONTENT_BOTTOM_MARGIN-CELL_CONTENT_TOP_MARGIN);
//
//    cell1.m_viewContent.layer.borderWidth   = 0.5;
//    cell1.m_viewContent.layer.borderColor   = [UIColor lightGrayColor].CGColor;
//    cell1.m_viewContent.layer.cornerRadius  = 9;
//    cell1.m_viewContent.layer.shadowOpacity = 0;
//
//}