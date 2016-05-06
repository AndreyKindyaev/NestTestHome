//
//  SCNLockView.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNLockView.h"

static const CGFloat kDarkViewCornerRadius = 10.f;

@interface SCNLockView ()

@property (weak, nonatomic) IBOutlet UIView *darkView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SCNLockView

+ (instancetype)viewWithTitle:(NSString *)title {
    SCNLockView *view = [self scnViewFromXib];
    view.titleLabel.text = title;
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.darkView.layer.cornerRadius = kDarkViewCornerRadius;
    self.titleLabel.textColor = [UIColor whiteColor];
}

@end
