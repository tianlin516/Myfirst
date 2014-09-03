//  MainMenuViewController.m
//  GermanDoctor
//
//  Created by rose on 8/29/14.
//  Copyright (c) 2014 TianLin. All rights reserved.
#import <QuartzCore/QuartzCore.h>
#import "MainMenuViewController.h"
#import "ManuMenuContentTableViewCell.h"
#import "TopHeader.h"

//#define FONT_SIZE                  15.0f
////#define CELL_CONTENT_WIDTH         310.0f
//#define CELL_CONTENT_HEIGHT_MARGIN 5.0f
//#define CELL_CONTENT_WIDTH_MARGIN  5.0f
//
//#define CONTENT_HEIGHT_MARGIN  5.0f
//#define CONTENT_WIDTH_MARGIN   10.0f
//
//#define PHOTO_WIDTH_VER_MARGIN     10.0f
//#define PHOTO_HEIGHT_RIGHT_MARGIN    10.0f
//
//#define PHOTO_SIZE 70.0f

#define ARRAY_WIDTH @[ 310, 215, 215, 86, 7, 56, 69]

@interface MainMenuViewController () <UITableViewDataSource, UITableViewDelegate>
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
    float CELL_CONTENT_WIDTH_MARGIN;

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

@implementation MainMenuViewController
@synthesize m_viewTopHeader, m_tblContent;
@synthesize m_viewActionSide,m_viewActionEntire;
@synthesize m_ivFooter, m_labelFooter, m_btnHidBigButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString* str = [NSString stringWithFormat:@"%@_iphone", nibNameOrNil];

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

//    self.m_tblContent.estimatedRowHeight = UITableViewAutomaticDimension;
//    self.m_tblContent.allowsSelection = NO;
    m_tblContent.layer.borderWidth = 1;
    m_tblContent.layer.borderColor = [UIColor lightGrayColor].CGColor;
    

    self.m_viewActionEntire.hidden = YES;
    self.m_btnHidBigButton.hidden = YES;

    self.m_viewActionEntire.layer.masksToBounds = NO;
    self.m_viewActionEntire.layer.shadowOpacity = 0.5;
    self.m_viewActionEntire.layer.shadowOffset = CGSizeMake(3*m_fscaleX, 0);
    self.m_btnHidBigButton.frame = CGRectMake(self.m_btnHidBigButton.frame.origin.x, 0, self.m_btnHidBigButton.frame.size.width, self.m_btnHidBigButton.frame.size.height);

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
    [m_arrContentTableDatas addObject:dict1];
    [m_arrContentTableDatas addObject:dict2];

    if ( self.interfaceOrientation == UIInterfaceOrientationPortrait  )
    {
        NSLog(@"Portrait");
        m_fScreenWidth  = 768;
        m_fScreenHeight = 1024;
    }
    else if ( self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
    {
        NSLog(@"Portrait up down");
        m_fScreenWidth  = 768;
        m_fScreenHeight = 1024;
    }
    else if ( self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft )
    {
        NSLog(@"LandscapeLeft");
        m_fScreenWidth  = 1024;
        m_fScreenHeight = 768;
    }
    else if ( self.interfaceOrientation == UIInterfaceOrientationLandscapeRight )
    {
        NSLog(@"LandscapeRight");
        m_fScreenWidth  = 1024;
        m_fScreenHeight = 768;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGSize screenSize      = [[UIScreen mainScreen] bounds].size;
        m_fScreenWidth  = 320;
        m_fScreenHeight = screenSize.height;
    }

    m_fscaleX = m_fScreenWidth  / 320;
    m_fscaleY = m_fScreenHeight / 480;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        m_fscaleY = 1.0f;
    m_fscale = MIN(m_fscaleX, m_fscaleY);

    FONT_SIZE = 18.0f * m_fscale;
    TITLE_FONT_SIZE       = 18.0f * m_fscale;
    NAME_FONT_SIZE        = 15.0f * m_fscale;
    DESCRIPTION_FONT_SIZE = 12.0f * m_fscale;
    DATE_FONT_SIZE        = 15.0f * m_fscale;
    SEPARATOR_FONT_SIZE   = 15.0f * m_fscale;
    DURATION_FONT_SIZE    = 15.0f * m_fscale;
    TIME_FONT_SIZE        = 15.0f * m_fscale;

    TITLE_FONT_FAMILY           =  @"AgfaRotisSansSerif-Bold";
    NAME_FONT_FAMILY            =  @"AgfaRotisSansSerif-Bold";
    DESCRIPTION_FONT_FAMILY     =  @"AgfaRotisSansSerif";
    DATE_FONT_FAMILY            =  @"AgfaRotisSansSerif";
    SEPARATOR_FONT_FAMILY       =  @"AgfaRotisSansSerif";
    DURATION_FONT_FAMILY        =  @"AgfaRotisSansSerif-Bold";
    TIME_FONT_FAMILY            =  @"AgfaRotisSansSerif";
    //#define CELL_CONTENT_WIDTH         310.0f
    CELL_CONTENT_TOP_MARGIN = 5.0f * m_fscaleY;
    CELL_CONTENT_BOTTOM_MARGIN = 0.0f * m_fscaleY;
    CELL_CONTENT_WIDTH_MARGIN = 5.0f * m_fscaleX;
    CONTENT_TOP_MARGIN = 5.0f * m_fscaleY;
    CONTENT_BOTTOM_MARGIN = 5.0f * m_fscaleY;
    CONTENT_WIDTH_MARGIN = 10.0f * m_fscaleX;
    PHOTO_HEIGHT_VER_MARGIN = 10.0f * m_fscaleX;
    PHOTO_WIDTH_RIGHT_MARGIN = 10.0f * m_fscaleY;
    PHOTO_SIZE = 70.0f * m_fscale;

    m_fAvailableHeight = 0;
    m_farrWidths[0] = 320*m_fscaleX-(CELL_CONTENT_WIDTH_MARGIN + CONTENT_WIDTH_MARGIN)*2;
    m_farrWidths[1] = 320*m_fscaleX-(CELL_CONTENT_WIDTH_MARGIN + CONTENT_WIDTH_MARGIN)*2-PHOTO_SIZE-PHOTO_WIDTH_RIGHT_MARGIN;
    m_farrWidths[2] = 320*m_fscaleX-(CELL_CONTENT_WIDTH_MARGIN + CONTENT_WIDTH_MARGIN)*2-PHOTO_SIZE-PHOTO_WIDTH_RIGHT_MARGIN;
    m_farrWidths[3] = 86 * m_fscaleX;
    m_farrWidths[4] = 10 * m_fscaleX;
    m_farrWidths[5] = 56 * m_fscaleX;
    m_farrWidths[6] = 69 * m_fscaleX;

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
    self.view.frame = CGRectMake(0, 0, 587, self.view.frame.size.height);
    double delayInSeconds = 0.01;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(267, 0, 587, self.view.frame.size.height);
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
        self.view.frame = CGRectMake(0, 0, 587, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        m_viewActionEntire.hidden = YES;
        self.m_btnHidBigButton.hidden = YES;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [m_arrContentTableDatas count];
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManuMenuContentTableViewCell* cell;
    NSString *nibName;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
        nibName = @"ManuMenuContentTableViewCell_iphone";
    else
        nibName = @"ManuMenuContentTableViewCell_iphone"; //ipad
    UIViewController *viewController = [[UIViewController alloc] initWithNibName:nibName bundle:nil];
    cell = (ManuMenuContentTableViewCell *)viewController.view;
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 1024, cell.frame.size.height);
    /////////////initializing cell values
    NSDictionary* dict = [m_arrContentTableDatas objectAtIndex:indexPath.row];
    m_fAvailableHeight = CONTENT_TOP_MARGIN;
    if (indexPath.row == 0) {
        m_fAvailableHeight = 0;
    }
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
    [label setFrame:CGRectMake(x, m_fAvailableHeight, width, size.height)];
    
    if (plusable == YES) {
        m_fAvailableHeight += size.height;
    }
}
-(float) getUILabelHeight:(UILabel*)label str:(NSString*)str width:(CGFloat)width font_family:(NSString*)font_family font_size:(float)font_size
{
    NSString *text = str;
    //int width1 = (width * 100) / 100;
    CGSize constraint = CGSizeMake(width, 20000.0f);
//    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{
//                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]
//                                                                                                     }];

    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
        //NSFontAttributeName:[UIFont fontWithName:@"AgfaRotisSansSerif-Bold" size:FONT_SIZE]
        NSFontAttributeName:[UIFont fontWithName:font_family size:font_size]
        //NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]
     }];

    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    return size.height;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
    if (photo_height < 70 * m_fscaleY + PHOTO_HEIGHT_VER_MARGIN * 2 ) {
        height += (70 * m_fscaleY + PHOTO_HEIGHT_VER_MARGIN * 2 - photo_height);
    }else height += PHOTO_HEIGHT_VER_MARGIN;
    height += CELL_CONTENT_TOP_MARGIN + CELL_CONTENT_BOTTOM_MARGIN + CONTENT_TOP_MARGIN + CONTENT_BOTTOM_MARGIN;
    return height;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManuMenuContentTableViewCell* cell1 = (ManuMenuContentTableViewCell*)cell;
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.x, m_fScreenWidth,cell.frame.size.height);

    cell1.m_viewContent.frame = CGRectMake(CELL_CONTENT_WIDTH_MARGIN, CELL_CONTENT_TOP_MARGIN, m_fScreenWidth-CELL_CONTENT_WIDTH_MARGIN*2, cell.frame.size.height-CELL_CONTENT_BOTTOM_MARGIN-CELL_CONTENT_TOP_MARGIN);

    cell1.m_viewContent.layer.borderWidth   = 1;
    cell1.m_viewContent.layer.borderColor   = [UIColor lightGrayColor].CGColor;
    cell1.m_viewContent.layer.cornerRadius  = 4*m_fscaleX;
    cell1.m_viewContent.layer.shadowOpacity = 0;

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
            topimage.frame = CGRectMake(m_viewTopHeader.frame.origin.x + m_fScreenWidth - topimage.frame.size.width*1.2f, topimage.frame.origin.y, topimage.frame.size.width, topimage.frame.size.height);

            m_btnHidBigButton.frame = CGRectMake(
                0, m_btnHidBigButton.frame.origin.y,
                m_fScreenWidth - m_viewActionEntire.frame.size.width, m_fScreenHeight );
        }
        { // sidemenu position

        }
        { // table redrawing
            [m_tblContent reloadData];
        }
        { //
            if (m_bMenuShowing) {
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
                    self.view.frame = CGRectMake(480, 0, 588*m_fscaleX, m_fScreenHeight);
                else
                    self.view.frame = CGRectMake(268, 0, 588, m_fScreenHeight);
            }
            //self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, m_fScreenWidth, m_fScreenHeight);
        }
    });
}
/*
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
//    NSLog(@"2");

    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}
-(NSUInteger) supportedInterfaceOrientations{
//    NSLog(@"3");
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation{
//    NSLog(@"4");
    return UIInterfaceOrientationLandscapeRight;
}
 */
/*
 //- (UIImage *) imageWithView:(UIView *)view
 //{
 //    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [UIScreen mainScreen].scale);
 //    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
 //
 //    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
 //
 //    UIGraphicsEndImageContext();
 //    return img;
 //    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0f);
 //    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
 //    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
 //    UIGraphicsEndImageContext();
 //    return snapshotImage;
 //}
 */
@end