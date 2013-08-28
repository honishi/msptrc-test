//
//  SomeViewController.m
//  PTRC
//
//  Created by Hiroyuki Onishi on 8/28/13.
//  Copyright (c) 2013 Hiroyuki Onishi. All rights reserved.
//

#import "SomeViewController.h"
#import "MSPullToRefreshController.h"

@interface SomeViewController () <MSPullToRefreshDelegate>

@property (nonatomic) UIScrollView* sv;
@property (nonatomic) UIView* ptrv;
@property (nonatomic) MSPullToRefreshController* ptrc;

@end

@implementation SomeViewController

#pragma mark - UIViewController Overrides

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // scroll view
    self.sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.sv.backgroundColor = UIColor.blueColor;
    self.sv.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*2);
    [self.view addSubview:self.sv];
    
    // ptr view
    self.ptrv = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -50.0f, self.view.bounds.size.width, 50.0f)];
    self.ptrv.backgroundColor = UIColor.redColor;
    [self.sv addSubview:self.ptrv];
    
    // ptr controller
    self.ptrc = [[MSPullToRefreshController alloc] initWithScrollView:self.sv delegate:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"scrollview's content inset: %@", NSStringFromUIEdgeInsets(self.sv.contentInset));
    NSLog(@"scrollview's content offset: %@", NSStringFromCGPoint(self.sv.contentOffset));
}

#pragma mark - MSPullToRefreshController Methods

-(BOOL)pullToRefreshController:(MSPullToRefreshController*)controller canRefreshInDirection:(MSRefreshDirection)direction
{
    return (direction == MSRefreshDirectionTop);
}

-(CGFloat)pullToRefreshController:(MSPullToRefreshController*)controller refreshableInsetForDirection:(MSRefreshDirection)direction
{
    return 50.0f;
}

-(CGFloat)pullToRefreshController:(MSPullToRefreshController*)controller refreshingInsetForDirection:(MSRefreshDirection)direction
{
    return 100.0f;
}

-(void)pullToRefreshController:(MSPullToRefreshController*)controller canEngageRefreshDirection:(MSRefreshDirection)direction
{
    self.ptrv.backgroundColor = UIColor.greenColor;
}

-(void)pullToRefreshController:(MSPullToRefreshController*)controller didDisengageRefreshDirection:(MSRefreshDirection)direction
{
    self.ptrv.backgroundColor = UIColor.redColor;
}

-(void)pullToRefreshController:(MSPullToRefreshController*)controller didEngageRefreshDirection:(MSRefreshDirection)direction
{
    double delayInSeconds = 2.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [self.ptrc finishRefreshingDirection:direction animated:YES];
        self.ptrv.backgroundColor = UIColor.redColor;
    });
}

@end
