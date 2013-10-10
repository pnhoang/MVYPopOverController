//
//  MVYViewController.m
//  MVYPopOverExample
//
//  Created by Álvaro Murillo del Puerto on 09/10/13.
//  Copyright (c) 2013 Mobivery. All rights reserved.
//

#import "MVYViewController.h"
#import "MVYMenuViewController.h"

@interface MVYViewController ()

- (IBAction)showPopOver:(id)sender;

@end

@implementation MVYViewController

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

- (IBAction)showPopOver:(id)sender {
	
	MVYMenuViewController *menuVC = [[MVYMenuViewController alloc] initWithNibName:@"MVYMenuViewController" bundle:nil];
	CGRect popOverFrame = CGRectMake(0, self.view.bounds.size.height - 240, self.view.bounds.size.width, 240);

	self.popOver = [[MVYPopOverController alloc] initWithRootViewController:menuVC];
	self.popOver.dismissOnTapOut = YES;
	self.popOver.dismissAnimation = MVYDismissPopOverAnimationZoomOut;
	[self.popOver presentPopOverInViewController:self atFrame:popOverFrame withAnimation:MVYPresentPopOverAnimationSlideInFromBottom];
	
	
	[menuVC setOnDismissButtonPresed:^{
		[self.popOver dismissPopOver];
	}];
		
	
}

@end
