//
//  Toast.m
//  iToast
//
//  Created by Damodar on 09/09/14.
//  Copyright (c) 2014 itsdamslife. All rights reserved.
//

#import "Toast.h"
#import <QuartzCore/QuartzCore.h>

@interface Toast (private)
@end

@implementation Toast

static Toast *_instance = nil;

#pragma mark - Singleton class Implementation

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self initialize];
    }
    return self;
}


+ (Toast*)sharedInstance
{
    if(_instance == nil)
    {
        _instance = [[Toast alloc] init];
    };
    return _instance;
}

- (void)initialize
{

    self.toastView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 21.0f)];
    self.toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 21.0f)];
    self.toastLabel.textColor = [UIColor whiteColor];
    self.toastLabel.font = [UIFont systemFontOfSize:10];
    self.toastLabel.textAlignment = NSTextAlignmentCenter;
    self.toastLabel.tag = 9999;
    
    self.toastLabel.text = @"Toast text not set!";

    [self.toastView addSubview:self.toastLabel];

    self.toastView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.toastView.layer.masksToBounds = NO;
    self.toastView.layer.cornerRadius = 10; // if you like rounded corners
    
    self.toastView.alpha = 0.0f;
    
    self.toastView.tag = 7777;
}

- (void)toastWithText:(NSString*)text inView:(UIView*)view forDuration:(ToastDuration)length
{
    if ((view.frame.size.height < 40) || (view.frame.size.width < 40)) {
        NSLog(@"Toast cannot be displayed!");
        return;
    }
    
    self.superViewRef = view;
    self.toastText = text;
    self.toastLength = length;


    UIFont *font = [UIFont systemFontOfSize:17];
    UIColor *color = [UIColor whiteColor];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          color, NSForegroundColorAttributeName,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
    
     CGRect rect = [string boundingRectWithSize:CGSizeMake(40, 21)
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        context:nil];
     
    CGRect superViewFrame = view.frame;
    
    CGFloat y = superViewFrame.size.height;
    CGFloat w = rect.size.width;
    if(rect.size.width < 120.0f)
        w = 120.0f;
    
    self.toastView.frame = CGRectMake((CGRectGetMidX(superViewFrame) - w/2), y - 40, w, 21.0f);
    self.toastLabel.frame = CGRectMake(0, 0, w, 21.0f);
    
    [(UILabel*)[self.toastView viewWithTag:9999] setText:self.toastText];
    
    [view addSubview:self.toastView];
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)show
{
    // Show toast here...
    
    [UIView beginAnimations:@"showtoast" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.25f];
    self.toastView.alpha = 1.0f;
    [UIView commitAnimations];

    
    
    [NSTimer scheduledTimerWithTimeInterval:self.toastLength
                                     target:self
                                   selector:@selector(hideToast:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)hideToast:(NSTimer*)timer
{
    [timer invalidate];
    
    // Hide toast here...
    [UIView beginAnimations:@"showtoast" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.25f];
    self.toastView.alpha = 0.0f;
    [UIView commitAnimations];

    self.toastText = @"";
    
    
    if(self.superViewRef)
    {
        UIView *vw = [self.superViewRef viewWithTag:7777];
        [vw removeFromSuperview];
    }
    
}
@end
