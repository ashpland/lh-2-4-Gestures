//
//  SwipeViewController.m
//  Gestures
//
//  Created by Andrew on 2017-10-12.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "SwipeViewController.h"

@interface SwipeViewController ()

@property (nonatomic, assign) bool isOpen;
@property (nonatomic, strong) NSLayoutConstraint *frontViewWidthConstraint;

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isOpen = NO;

    //
    // BehindView
    //
    
    UIView *behindView = [[UIView alloc] initWithFrame:CGRectZero];
    behindView.translatesAutoresizingMaskIntoConstraints = NO;
    behindView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:behindView];
    
    [[behindView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.9] setActive:YES];
    [[behindView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.1] setActive:YES];
    [[behindView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[behindView.centerYAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-((self.view.frame.size.height - self.view.safeAreaInsets.bottom) / 3.0)] setActive:YES];
    
    
    //
    // InFrontView
    //
    
    UIView *inFrontView = [[UIView alloc] initWithFrame:CGRectZero];
    inFrontView.translatesAutoresizingMaskIntoConstraints = NO;
    inFrontView.backgroundColor = [UIColor blueColor];
    [behindView addSubview:inFrontView];
    
    [[inFrontView.heightAnchor constraintEqualToAnchor:behindView.heightAnchor] setActive:YES];
    [[inFrontView.centerYAnchor constraintEqualToAnchor:behindView.centerYAnchor] setActive:YES];
    [[inFrontView.leftAnchor constraintEqualToAnchor:behindView.leftAnchor constant:0.0] setActive:YES];
    self.frontViewWidthConstraint = [inFrontView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.9];
    [self.frontViewWidthConstraint setActive:YES];
    
    
    //
    // SwipeRecognizer
    //
    
    UISwipeGestureRecognizer *leftSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewSwiped:)];
    leftSwiper.direction = UISwipeGestureRecognizerDirectionLeft;
    [inFrontView addGestureRecognizer:leftSwiper];
    UISwipeGestureRecognizer *rightSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewSwiped:)];
    rightSwiper.direction = UISwipeGestureRecognizerDirectionRight;
    [inFrontView addGestureRecognizer:rightSwiper];
}

-(void)viewSwiped:(UISwipeGestureRecognizer *)sender {
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            if (!self.isOpen) {
                [self.frontViewWidthConstraint setActive:NO];
                self.frontViewWidthConstraint = [sender.view.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.5];
                [self.frontViewWidthConstraint setActive:YES];
                self.isOpen = YES;
            }
            break;
        case UISwipeGestureRecognizerDirectionRight:
            if (self.isOpen) {
                [self.frontViewWidthConstraint setActive:NO];
                self.frontViewWidthConstraint = [sender.view.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.9];
                [self.frontViewWidthConstraint setActive:YES];
                self.isOpen = NO;
            }
            break;
        default:
            break;
    }
    
    
    
}

@end
