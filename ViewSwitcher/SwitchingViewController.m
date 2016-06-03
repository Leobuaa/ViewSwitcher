//
//  ViewController.m
//  ViewSwitcher
//
//  Created by Leo Peng on 6/3/16.
//  Copyright © 2016 Leo Peng. All rights reserved.
//

#import "SwitchingViewController.h"

#import "BlueViewController.h"
#import "YellowViewController.h"

@interface SwitchingViewController ()

@property (strong, nonatomic) YellowViewController *yellowViewController;
@property (strong, nonatomic) BlueViewController *blueViewController;

@end

@implementation SwitchingViewController

- (IBAction)switchViews:(id)sender {
    // Initilize the view controllers.
    if (!self.yellowViewController.view.superview) {
        if (!self.yellowViewController) {
            self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Yellow"];
        }
    } else {
        if (!self.blueViewController) {
            self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
        }
    }
    
    // Switch view controllers.
    // Animation setting
    [UIView beginAnimations:@"View Flip" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if (!self.yellowViewController.view.superview) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        self.yellowViewController.view.frame = self.view.frame;
        [self switchViewFormViewController:self.blueViewController toViewController:self.yellowViewController];
    } else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        self.blueViewController.view.frame = self.view.frame;
        [self switchViewFormViewController:self.yellowViewController toViewController:self.blueViewController];
    }
    // All actions will be made animation until send this message(commitAnimations) to UIView.
    [UIView commitAnimations];
}

- (void)switchViewFormViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (fromVC != nil) {
        [fromVC willMoveToParentViewController:nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    
    if (toVC != nil) {
        [self addChildViewController:toVC];
        [self.view insertSubview:toVC.view atIndex:0];
        [toVC didMoveToParentViewController:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
    
    self.blueViewController.view.frame = self.view.frame;
    [self switchViewFormViewController:nil toViewController:self.blueViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (!self.blueViewController.view.superview) {
        self.blueViewController = nil;
    } else {
        self.yellowViewController = nil;
    }
}

@end
