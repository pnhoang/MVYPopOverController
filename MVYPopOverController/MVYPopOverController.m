//
//  MVYPopOverController.m
//  MVYPopOverExample
//
//  Created by Álvaro Murillo del Puerto on 09/10/13.
//  Copyright (c) 2013 Mobivery. All rights reserved.
//

#import "MVYPopOverController.h"

@interface MVYPopOverController ()

@property (nonatomic) CGRect popOverFrame;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

- (void)presentSlideInFromBottom;
- (void)presentSlideInFromTop;
- (void)presentSlideInFromLeft;
- (void)presentSlideInFromRight;
- (void)presentFadeIn;
- (void)presentZoomIn;

- (void)dismissSlideOutToBottom;
- (void)dismissSlideOutToTop;
- (void)dismissSlideOutToLeft;
- (void)dismissSlideOutToRight;
- (void)dismissFadeOut;
- (void)dismissZoomOut;

@end

@implementation MVYPopOverController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
	
	self = [super init];
	if (self) {
		_rootViewController = rootViewController;
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[self.view setBackgroundColor:[UIColor blackColor]];
	[self removeOpacity];
	
	[self setUpRootViewController];
	[self addGestures];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRootViewController:(UIViewController *)rootViewController {
	
	_rootViewController = rootViewController;
	
	if (rootViewController) {
		[self setUpRootViewController];
	}
}

- (void)setUpRootViewController {
	
	if (self.rootViewController) {
		[self addChildViewController:self.rootViewController];
		self.rootViewController.view.frame = self.view.bounds;
		[self.view addSubview:self.rootViewController.view];
		[self.rootViewController didMoveToParentViewController:self];
	}
}

- (void)addGestures {
	
	if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopOver)];
        [_tapGesture setDelegate:self];
		[self.view addGestureRecognizer:_tapGesture];
    }
}

- (void)presentPopOverInViewController:(UIViewController *)viewController atFrame:(CGRect)frame withAnimation:(MVYPresentPopOverAnimation)animation {
	
	[viewController addChildViewController:self];
	self.view.frame = viewController.view.bounds;
	[viewController.view addSubview:self.view];
	[self didMoveToParentViewController:viewController];
	self.popOverFrame = frame;
	
	[self presentAnimationWillBegin];
	
	switch (animation) {
		case MVYPresentPopOverAnimationSlideInFromBottom:
			[self presentSlideInFromBottom];
			break;
		case MVYPresentPopOverAnimationSlideInFromTop:
			[self presentSlideInFromTop];
			break;
		case MVYPresentPopOverAnimationSlideInFromLeft:
			[self presentSlideInFromLeft];
			break;
		case MVYPresentPopOverAnimationSlideInFromRight:
			[self presentSlideInFromRight];
			break;
		case MVYPresentPopOverAnimationFadeIn:
			[self presentFadeIn];
			break;
		case MVYPresentPopOverAnimationZoomIn:
			[self presentZoomIn];
			break;
			
		default:
			[self presentSlideInFromBottom];
			break;
	}
}

- (void)dismissPopOver {
	
	[self dismissPopOverWithAnimation:self.dismissAnimation];
}

- (void)dismissPopOverWithAnimation:(MVYDismissPopOverAnimation)animation {
	
	[self dismissAnimitationWillBegin];
	
	switch (animation) {
		case MVYDismissPopOverAnimationSlideOutToBottom:
			[self dismissSlideOutToBottom];
			break;
		case MVYDismissPopOverAnimationSlideOutToTop:
			[self dismissSlideOutToTop];
			break;
		case MVYDismissPopOverAnimationSlideOutToLeft:
			[self dismissSlideOutToLeft];
			break;
		case MVYDismissPopOverAnimationSlideOutToRight:
			[self dismissSlideOutToRight];
			break;
		case MVYDismissPopOverAnimationFadeOut:
			[self dismissFadeOut];
			break;
		case MVYDismissPopOverAnimationZoomOut:
			[self dismissZoomOut];
			break;
			
		default:
			[self dismissSlideOutToBottom];
			break;
	}
}

- (void)addOpacity {
	[self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
}

- (void)removeOpacity {
	[self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
}

- (void)presentAnimationBegan {
	
	[self addOpacity];
}

- (void)dismissAnimationBegan {
	
	[self removeOpacity];
}

- (void)presentAnimationWillBegin {
	if (self.onWillAppear) {
		self.onWillAppear();
	}
}

- (void)presentAnimationCompleted {
	[self.rootViewController didMoveToParentViewController:self];
	if (self.onDidAppear) {
		self.onDidAppear();
	}
}

- (void)dismissAnimitationWillBegin {
	if (self.onWillDisappear) {
		self.onWillDisappear();
	}
}

- (void)dismissAnimationCompleted {
	
	[self.rootViewController.view removeFromSuperview];
	[self.rootViewController removeFromParentViewController];
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
	
	if (self.onDidDisappear) {
		self.onDidDisappear();
	}
}

- (void)setPopOverHidden:(BOOL)hidden {
	
	[self.rootViewController.view setHidden:hidden];
}

#pragma mark – Present Animations

- (void)presentSlideInFromBottom {
	
	CGRect initialFrame = self.popOverFrame;
	initialFrame.origin.y = self.view.frame.size.height;
	self.rootViewController.view.frame = initialFrame;
	[self setPopOverHidden:NO];
	[UIView animateWithDuration:0.3 animations:^{
		[self presentAnimationBegan];
		self.rootViewController.view.frame = self.popOverFrame;
	} completion:^(BOOL finished) {
		[self presentAnimationCompleted];
	}];
}

- (void)presentSlideInFromTop {
	
	CGRect initialFrame = self.popOverFrame;
	initialFrame.origin.y = - self.view.frame.size.height;
	self.rootViewController.view.frame = initialFrame;
	[self setPopOverHidden:NO];
	[UIView animateWithDuration:0.3 animations:^{
		[self presentAnimationBegan];
		self.rootViewController.view.frame = self.popOverFrame;
	} completion:^(BOOL finished) {
		[self presentAnimationCompleted];
	}];
}

- (void)presentSlideInFromLeft {
	
	CGRect initialFrame = self.popOverFrame;
	initialFrame.origin.x = - self.view.frame.size.width;
	self.rootViewController.view.frame = initialFrame;
	[self setPopOverHidden:NO];
	[UIView animateWithDuration:0.3 animations:^{
		[self presentAnimationBegan];
		self.rootViewController.view.frame = self.popOverFrame;
	} completion:^(BOOL finished) {
		[self presentAnimationCompleted];
	}];
}

- (void)presentSlideInFromRight {
	
	CGRect initialFrame = self.popOverFrame;
	initialFrame.origin.x = self.view.frame.size.width;
	self.rootViewController.view.frame = initialFrame;
	[self setPopOverHidden:NO];
	[UIView animateWithDuration:0.3 animations:^{
		[self presentAnimationBegan];
		self.rootViewController.view.frame = self.popOverFrame;
	} completion:^(BOOL finished) {
		[self presentAnimationCompleted];
	}];
}

- (void)presentFadeIn {
		
	self.rootViewController.view.alpha = 0.0;
	[self setPopOverHidden:NO];
	self.rootViewController.view.frame = self.popOverFrame;
	[UIView animateWithDuration:0.5 animations:^{
		[self presentAnimationBegan];
		self.rootViewController.view.alpha = 1.0;
		self.rootViewController.view.frame = self.popOverFrame;
	} completion:^(BOOL finished) {
		[self presentAnimationCompleted];
	}];
}

- (void)presentZoomIn {
	
	CGFloat x = self.popOverFrame.origin.x + self.popOverFrame.size.width / 2.0;
	CGFloat y = self.popOverFrame.origin.y + self.popOverFrame.size.height / 2.0;
	CGFloat width = 0.0;
	CGFloat height = 0.0;
	
	CGRect initialFrame = CGRectMake(x, y, width, height);
	self.rootViewController.view.frame = initialFrame;
	[self setPopOverHidden:NO];
	[UIView animateWithDuration:0.5 animations:^{
		[self presentAnimationBegan];
		self.rootViewController.view.frame = self.popOverFrame;
	} completion:^(BOOL finished) {
		[self presentAnimationCompleted];
	}];
}

#pragma mark – Dismiss Animations

- (void)dismissSlideOutToBottom {

	CGRect hiddenFrame = self.popOverFrame;
	hiddenFrame.origin.y = self.view.frame.size.height;
	[UIView animateWithDuration:0.3 animations:^{
		[self dismissAnimationBegan];
		self.rootViewController.view.frame = hiddenFrame;
	} completion:^(BOOL finished) {
		[self dismissAnimationCompleted];
	}];
}

- (void)dismissSlideOutToTop {
	
	CGRect hiddenFrame = self.popOverFrame;
	hiddenFrame.origin.y = - self.view.frame.size.height;
	[UIView animateWithDuration:0.3 animations:^{
		[self dismissAnimationBegan];
		self.rootViewController.view.frame = hiddenFrame;
	} completion:^(BOOL finished) {
		[self dismissAnimationCompleted];
	}];
}

- (void)dismissSlideOutToLeft {
	
	CGRect hiddenFrame = self.popOverFrame;
	hiddenFrame.origin.x = - self.view.frame.size.width;
	[UIView animateWithDuration:0.3 animations:^{
		[self dismissAnimationBegan];
		self.rootViewController.view.frame = hiddenFrame;
	} completion:^(BOOL finished) {
		[self dismissAnimationCompleted];
	}];
}

- (void)dismissSlideOutToRight {
	
	CGRect hiddenFrame = self.popOverFrame;
	hiddenFrame.origin.x = self.view.frame.size.width;
	[UIView animateWithDuration:0.3 animations:^{
		[self dismissAnimationBegan];
		self.rootViewController.view.frame = hiddenFrame;
	} completion:^(BOOL finished) {
		[self dismissAnimationCompleted];
	}];
}

- (void)dismissFadeOut {
	
	CGRect hiddenFrame = self.popOverFrame;
	[UIView animateWithDuration:0.3 animations:^{
		[self dismissAnimationBegan];
		self.rootViewController.view.alpha = 0.0;
		self.rootViewController.view.frame = hiddenFrame;
	} completion:^(BOOL finished) {
		[self dismissAnimationCompleted];
	}];
}

- (void)dismissZoomOut {
	
	CGFloat x = self.popOverFrame.origin.x + self.popOverFrame.size.width / 2.0;
	CGFloat y = self.popOverFrame.origin.y + self.popOverFrame.size.height / 2.0;
	CGFloat width = 0.0;
	CGFloat height = 0.0;
	
	CGRect hiddenFrame = CGRectMake(x, y, width, height);
	[UIView animateWithDuration:0.3 animations:^{
		[self dismissAnimationBegan];
		self.rootViewController.view.alpha = 0.0;
		self.rootViewController.view.frame = hiddenFrame;
	} completion:^(BOOL finished) {
		[self dismissAnimationCompleted];
	}];
}

#pragma mark – UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	
	CGPoint point = [touch locationInView:self.view];
	
	if (gestureRecognizer == _tapGesture) {
		return self.dismissOnTapOut && !CGRectContainsPoint(self.rootViewController.view.frame, point);
	}
	
	return YES;
}

@end
