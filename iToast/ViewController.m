//
//  ViewController.m
//  iToast
//
//  Created by Damodar on 09/09/14.
//  Copyright (c) 2014 itsdamslife. All rights reserved.
//

#import "ViewController.h"
#import "Toast.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTapped:(id)sender
{
    NSString *toastText = [NSString stringWithFormat:@"Button %d tapped",[sender tag]];
    NSLog(@"%@",toastText);
    
    [[Toast sharedInstance] toastWithText:toastText inView:self.view forDuration:Duration_Short];
    [[Toast sharedInstance] show];
}

@end
