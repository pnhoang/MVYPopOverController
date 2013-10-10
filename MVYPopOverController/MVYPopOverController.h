//
//  MVYPopOverController.h
//  MVYPopOverExample
//
//  Created by Álvaro Murillo del Puerto on 09/10/13.
//  Copyright (c) 2013 Mobivery. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MVYPresentPopOverAnimation) {
    MVYPresentPopOverAnimationSlideInFromBottom,
	MVYPresentPopOverAnimationSlideInFromTop,
	MVYPresentPopOverAnimationSlideInFromLeft,
	MVYPresentPopOverAnimationSlideInFromRight,
    MVYPresentPopOverAnimationFadeIn,
    MVYPresentPopOverAnimationZoomIn
};

typedef NS_ENUM(NSInteger, MVYDismissPopOverAnimation) {
    MVYDismissPopOverAnimationSlideOutToBottom,
	MVYDismissPopOverAnimationSlideOutToTop,
	MVYDismissPopOverAnimationSlideOutToLeft,
	MVYDismissPopOverAnimationSlideOutToRight,
    MVYDismissPopOverAnimationFadeOut,
    MVYDismissPopOverAnimationZoomOut
};

@interface MVYPopOverController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic) BOOL dismissOnTapOut;
@property (nonatomic) MVYDismissPopOverAnimation dismissAnimation;
@property (nonatomic, copy) void (^onPresented)(void);
@property (nonatomic, copy) void (^onDismissed)(void);

- (id)initWithRootViewController:(UIViewController *)rootViewController;

- (void)presentPopOverInViewController:(UIViewController *)viewController atFrame:(CGRect)frame withAnimation:(MVYPresentPopOverAnimation)animation;

- (void)dismissPopOver;

- (void)dismissPopOverWithAnimation:(MVYDismissPopOverAnimation)animation;

@end
