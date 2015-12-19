//
//  C4QCatFactDetailViewController.m
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsDetailViewController.h"
#import <AFNetworking/AFNetworking.h>

#define CAT_GIF_URL @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC";

@interface C4QCatFactsDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *catFactsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;


@end

@implementation C4QCatFactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catFactsLabel.text = self.catFact;
    self.backgroundImage.clipsToBounds = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSArray *data = responseObject[@"data"];
             int randomNumber = (arc4random() % data.count) + 1;
             NSString *imageURLString = data[randomNumber][@"images"][@"fixed_height_still"][@"url"];
             
             NSURL *imageURL = [NSURL URLWithString:imageURLString];
             
             NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
             UIImage *image = [UIImage imageWithData:imageData];
             
             [self.backgroundImage setImage:image];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
