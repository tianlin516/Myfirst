//
//  ManuMenuContentTableViewCell.h
//  GermanDoctor
//
//  Created by rose on 8/29/14.
//  Copyright (c) 2014 TianLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManuMenuContentTableViewCell : UITableViewCell

@property(strong, nonatomic) IBOutlet UIView*      m_viewContent;
@property(strong, nonatomic) IBOutlet UIImageView* m_ivBack;
@property(strong, nonatomic) IBOutlet UIImageView* m_ivPhoto;
@property(strong, nonatomic) IBOutlet UILabel*     m_labelTitle;
@property(strong, nonatomic) IBOutlet UILabel*     m_labelName;
@property(strong, nonatomic) IBOutlet UILabel*     m_labelDescription;
@property(strong, nonatomic) IBOutlet UILabel*     m_labelDate;
@property(strong, nonatomic) IBOutlet UILabel*     m_labelDuration;
@property(strong, nonatomic) IBOutlet UILabel*     m_labelTime;
@property(strong, nonatomic) IBOutlet UILabel*     m_labelSeparator;


@end
