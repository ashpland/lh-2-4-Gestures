//
//  RotateViewController.m
//  Gestures
//
//  Created by Andrew on 2017-10-12.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "RotateViewController.h"

@interface RotateViewController ()

@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = 200;
    CGFloat height = 200;
    CGRect frame = CGRectMake(CGRectGetMidX(self.view.bounds) - width/2, CGRectGetMidY(self.view.bounds) - height/2, width, height);
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(viewRotated:)];
    [view addGestureRecognizer:rotateGesture];

}

-(void)viewRotated:(UIRotationGestureRecognizer *)sender {
    CGFloat rotation = sender.rotation;
    sender.view.transform = CGAffineTransformRotate(sender.view.transform, rotation);
    sender.rotation = 0.0;
}


@end
