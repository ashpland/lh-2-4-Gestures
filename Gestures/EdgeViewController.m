//
//  EdgeViewController.m
//  Gestures
//
//  Created by Andrew on 2017-10-12.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "EdgeViewController.h"

@interface EdgeViewController ()

@property (nonatomic, strong) UIView *edgeBox;
@property (nonatomic, strong) NSLayoutConstraint *edgeBoxLeftConstraint;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgeRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;


@end

@implementation EdgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.edgeBox = [[UIView alloc] initWithFrame:CGRectZero];
    self.edgeBox.translatesAutoresizingMaskIntoConstraints = NO;
    self.edgeBox.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.edgeBox];
    
    [[self.edgeBox.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.75] setActive:YES];
    [[self.edgeBox.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.edgeBox.widthAnchor constraintEqualToAnchor:self.view.widthAnchor] setActive:YES];
    self.edgeBoxLeftConstraint = [self.edgeBox.leadingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16.0];
    [self.edgeBoxLeftConstraint setActive:YES];

    self.edgeRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(viewEdged:)];
    self.edgeRecognizer.edges = UIRectEdgeRight;
    [self.edgeBox addGestureRecognizer:self.edgeRecognizer];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPanned:)];
    //[self.edgeBox addGestureRecognizer:self.panRecognizer];

    
}

- (void)viewEdged:(UIScreenEdgePanGestureRecognizer *)sender {
    CGPoint translationInView = [sender translationInView:self.view];
    CGPoint oldCenter = sender.view.center;
    CGPoint newCenter = CGPointMake(oldCenter.x + translationInView.x, oldCenter.y);
    
    if ((newCenter.x - sender.view.frame.size.width / 2)  < (self.view.frame.size.width - 100)) {
        [self.edgeBoxLeftConstraint setActive:NO];
        self.edgeBoxLeftConstraint = [sender.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:self.view.frame.size.width/4.0];
        [self.edgeBoxLeftConstraint setActive:YES];
        [self.edgeBox removeGestureRecognizer:self.edgeRecognizer];
        [self.edgeBox addGestureRecognizer:self.panRecognizer];
    } else {
        sender.view.center = newCenter;
        
        [sender setTranslation:CGPointZero inView:self.view];
    }
    
}

- (void)viewPanned:(UIPanGestureRecognizer *)sender {
    CGPoint translationInView = [sender translationInView:self.view];
    CGPoint oldCenter = sender.view.center;
    CGPoint newCenter = CGPointMake(oldCenter.x + translationInView.x, oldCenter.y);
    
    if ((newCenter.x - sender.view.frame.size.width / 2) < self.view.frame.size.width/4.0) {
        return;
    } else if ((newCenter.x - sender.view.frame.size.width / 2) > (self.view.frame.size.width / 2.0)) {
        [self.edgeBoxLeftConstraint setActive:NO];
        self.edgeBoxLeftConstraint = [self.edgeBox.leadingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16.0];
        [self.edgeBoxLeftConstraint setActive:YES];
        [self.edgeBox removeGestureRecognizer:self.panRecognizer];
        [self.edgeBox addGestureRecognizer:self.edgeRecognizer];
        
    } else {
        sender.view.center = newCenter;
        [sender setTranslation:CGPointZero inView:self.view];
    }
    
}


@end
