//
//  MEViewController.h
//  MESegmentedControl
//
//  Created by David Thompson on 22/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MESegmentedControl.h"

@interface MEViewController : UIViewController

@property (nonatomic, strong) IBOutlet MESegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UILabel *label;

/** Puts the badge of the first segment into the label. */
- (IBAction)onClick:(UIButton *)sender;

@end
