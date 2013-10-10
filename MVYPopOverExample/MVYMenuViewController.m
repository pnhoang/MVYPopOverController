//
//  MVYMenuViewController.m
//  MVYPopOverExample
//
//  Created by Álvaro Murillo del Puerto on 09/10/13.
//  Copyright (c) 2013 Mobivery. All rights reserved.
//

#import "MVYMenuViewController.h"

@interface MVYMenuViewController ()

@end

@implementation MVYMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissPopOver:(id)sender {
	if (self.onDismissButtonPresed) {
		self.onDismissButtonPresed();
	}
}

@end
