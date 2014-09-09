//
//  Toast.h
//  iToast
//
//  Created by Damodar on 09/09/14.
//  Copyright (c) 2014 itsdamslife. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Duration_Short = 3,
    Duration_Long = 10
}ToastDuration;

@interface Toast : NSObject

@property (nonatomic, strong) UIView *toastView;
@property (nonatomic, strong) UILabel *toastLabel;

@property (nonatomic, strong) NSString *toastText;
@property (nonatomic, assign) ToastDuration toastLength;

@property (nonatomic, assign) UIView *superViewRef;

+ (Toast*)sharedInstance;

- (void)toastWithText:(NSString*)text inView:(UIView*)view forDuration:(ToastDuration)length;
- (void)show;

@end
