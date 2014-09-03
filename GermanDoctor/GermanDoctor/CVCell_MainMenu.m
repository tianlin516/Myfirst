//
//  CVCell_MainMenu.m
//  GermanDoctor
//
//  Created by rose on 9/3/14.
//  Copyright (c) 2014 TianLin. All rights reserved.
//

#import "CVCell_MainMenu.h"

@implementation CVCell_MainMenu
@synthesize m_viewContent, m_ivBack, m_labelDate,m_labelDescription,m_labelDuration,m_labelName,m_labelSeparator,m_labelTime,m_labelTitle, m_ivPhoto;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CVCell_MainMenu" owner:self options:nil];
        if ([arrayOfViews count] < 1)
            return nil;
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
            return nil;
        
        self = [arrayOfViews objectAtIndex:0];
        // Initialization code
        float title_font_size  = 18.0f;
        float name_font_size   = 15.0f;
        float description_font_size = 12.0f;
        float date_font_size  = 15.0f;
        float separator_font_size  = 15.0f;
        float duration_font_size  = 15.0f;
        float time_font_size  = 15.0f;
        
        NSString* title_font_family       =  @"AgfaRotisSansSerif-Bold";
        NSString* name_font_family        =  @"AgfaRotisSansSerif-Bold";
        NSString* description_font_family =  @"AgfaRotisSansSerif";
        NSString* date_font_family        =  @"AgfaRotisSansSerif";
        NSString* separator_font_family   =  @"AgfaRotisSansSerif";
        NSString* duration_font_family    =  @"AgfaRotisSansSerif-Bold";
        NSString* time_font_family        =  @"AgfaRotisSansSerif";
        
        { //title
            UIColor *c = [UIColor colorWithRed:0.0/255.0 green:63.0/255.0 blue:114.0/255.0 alpha:1.0];
            [self setPropertyToLabel:m_labelTitle font:[UIFont fontWithName:title_font_family size:title_font_size] color:c];
        }
        { //name
            UIColor *c = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
            [self setPropertyToLabel:m_labelName font:[UIFont fontWithName:name_font_family size:name_font_size] color:c];
        }
        { //description
            UIColor *c = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
            [self setPropertyToLabel:m_labelDescription font:[UIFont fontWithName:description_font_family size:description_font_size] color:c];
        }
        { //date
            UIColor *c = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
            [self setPropertyToLabel:m_labelDate font:[UIFont fontWithName:date_font_family size:date_font_size] color:c];
        }
        { //separator
            UIColor *c = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
            [self setPropertyToLabel:m_labelSeparator font:[UIFont fontWithName:separator_font_family size:separator_font_size] color:c];
        }
        { //duration
            UIColor *c = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
            [self setPropertyToLabel:m_labelDuration font:[UIFont fontWithName:duration_font_family size:duration_font_size] color:c];
        }
        { //time
            UIColor *c = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
            [self setPropertyToLabel:m_labelTime font:[UIFont fontWithName:time_font_family size:time_font_size] color:c];
        }
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
#pragma mark - LabelProperties
- (void) setPropertyToLabel:(UILabel*)label font:(UIFont*)font color:(UIColor*)c
{
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [label setNumberOfLines:0];
    
    label.textColor = c;
    [label setFont:font];
}

@end
