//
//  C4QColorPickerViewController.h
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol C4QColorPickerDelegate <NSObject>

-(void)didPickColor:(UIColor *)color;

@end

@interface C4QColorPickerViewController : UIViewController

@property (weak, nonatomic) id<C4QColorPickerDelegate> delegate;

@end
