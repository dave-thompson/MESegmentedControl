//
//  MEViewController.m
//  MESegmentedControl
//
//  Created by David Thompson on 22/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MEViewController.h"
#import "CustomBadge.h"

@implementation MEViewController

@synthesize segmentedControl;
@synthesize button;
@synthesize label;

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)viewDidUnload
{
    [self setButton:nil];
    [self setLabel:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // To set standard white on red badges:
    [segmentedControl setBadgeNumber:1 forSegmentAtIndex:0];
    [segmentedControl setBadgeNumber:22 forSegmentAtIndex:1];

    // To set a badge with custom colours:
    [segmentedControl setBadgeNumber:333 forSegmentAtIndex:2 usingBlock:^(CustomBadge *badge)
     {
         // See CustomBadge.h for other badge properties that can be changed here
         badge.badgeFrameColor = [UIColor blackColor]; // default is white
         badge.badgeInsetColor = [UIColor yellowColor]; // default is red
         badge.badgeTextColor = [UIColor blackColor]; // default is white
     }
     ];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Clear the badge numbers
    [segmentedControl clearBadges];
}

/** Puts the badge of the first segment into the label. */
- (IBAction)onClick:(UIButton *)sender {
    MESegmentedControl* sc=self.segmentedControl;
    NSUInteger i=[sc getBadgeNumberForSegmentAtIndex:0];
    NSString* text=[NSString stringWithFormat:@"%d", i];
    self.label.text=text;
}

@end
