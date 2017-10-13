//
//  EdgeViewController.m
//  Gestures
//
//  Created by Andrew on 2017-10-12.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "EdgeViewController.h"

@interface EdgeViewController ()

@property (nonatomic, strong) NSLayoutConstraint *edgeBoxLeftConstraint;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgeRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;


@end

@implementation EdgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIView *edgeBox = [[UIView alloc] initWithFrame:CGRectZero];
    edgeBox.translatesAutoresizingMaskIntoConstraints = NO;
    edgeBox.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:edgeBox];
    
    [[edgeBox.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.75] setActive:YES];
    [[edgeBox.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[edgeBox.widthAnchor constraintEqualToAnchor:self.view.widthAnchor] setActive:YES];
    self.edgeBoxLeftConstraint = [edgeBox.leadingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16.0];
    [self.edgeBoxLeftConstraint setActive:YES];

    self.edgeRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(viewEdged:)];
    self.edgeRecognizer.edges = UIRectEdgeRight;
    [edgeBox addGestureRecognizer:self.edgeRecognizer];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPanned:)];
    //[edgeBox addGestureRecognizer:self.panRecognizer];

    
}

- (void)viewEdged:(UIScreenEdgePanGestureRecognizer *)sender {
    CGPoint translationInView = [sender translationInView:self.view];
    CGPoint oldCenter = sender.view.center;
    CGPoint newCenter = CGPointMake(oldCenter.x + translationInView.x, oldCenter.y);
    
    if ((newCenter.x - sender.view.frame.size.width / 2)  < (self.view.frame.size.width - 100)) {
        [self.edgeBoxLeftConstraint setActive:NO];
        self.edgeBoxLeftConstraint = [sender.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:self.view.frame.size.width/4.0];
        [self.edgeBoxLeftConstraint setActive:YES];
        [sender.view removeGestureRecognizer:self.edgeRecognizer];
        [sender.view addGestureRecognizer:self.panRecognizer];

    } else {
        sender.view.center = newCenter;
        
        [sender setTranslation:CGPointZero inView:self.view];
    }
    
}

- (void)viewPanned:(UIPanGestureRecognizer *)sender {
    CGPoint translationInView = [sender translationInView:self.view];
    CGPoint oldCenter = sender.view.center;
    CGPoint newCenter = CGPointMake(oldCenter.x + translationInView.x, oldCenter.y);
    
    sender.view.center = newCenter;
    
    [sender setTranslation:CGPointZero inView:self.view];

    
    NSLog(@"Panned");
}


@end
