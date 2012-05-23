//
//  MEViewController.m
//  MESegmentedControl
//
//  Created by David Thompson on 22/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MEViewController.h"

@implementation MEViewController

@synthesize segmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Set badge numbers on segmented control
    [segmentedControl setBadgeNumber:1 forSegmentAtIndex:0];
    [segmentedControl setBadgeNumber:22 forSegmentAtIndex:1];
    [segmentedControl setBadgeNumber:333 forSegmentAtIndex:2];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Clear the badge numbers
    [segmentedControl clearBadges];
}

@end
