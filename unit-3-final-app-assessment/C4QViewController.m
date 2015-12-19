//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"
#import "C4QColorPickerViewController.h"

@interface C4QViewController () <C4QColorPickerDelegate>

@end

@implementation C4QViewController

-(void)didPickColor:(UIColor *)color{
    self.view.backgroundColor = color;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"colorPickerSegue"]) {
        C4QColorPickerViewController *colorPickerVC = segue.destinationViewController;
        colorPickerVC.delegate = self;
    }
    
}

@end
