//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "C4QCatFactsTableViewCell.h"
#import "C4QCatFactsDetailViewController.h"

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController ()
@property (nonatomic) NSMutableArray *catFacts;

@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.catFacts = [[NSMutableArray alloc] init];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *jsonReponseSerializer = [AFJSONResponseSerializer serializer];
    jsonReponseSerializer.acceptableContentTypes = nil;
    manager.responseSerializer = jsonReponseSerializer;
    
    [manager GET:@"http://catfacts-api.appspot.com/api/facts?number=100"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSArray *catData = responseObject[@"facts"];
             
             for (NSString *fact in catData) {
                 [self.catFacts addObject:fact];
             }
             
             [self.tableView reloadData];

         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Cat's are awful anyways. Error is: %@", error);
         }];
    
}

- (IBAction)saveCatFactButton:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved" message:@"New cat fact saved!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFactsArray"]) {
            NSMutableArray *savedCatFactsArray = [[NSMutableArray alloc] init];
            [savedCatFactsArray addObject:self.catFacts[sender.tag]];
            [[NSUserDefaults standardUserDefaults] setObject:savedCatFactsArray forKey:@"savedCatFactsArray"];
        } else {
            NSMutableArray *savedCatFactsArrayCopy = [[NSMutableArray alloc] initWithArray:[[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFactsArray"] mutableCopy]];
            [savedCatFactsArrayCopy addObject:self.catFacts[sender.tag]];
            [[NSUserDefaults standardUserDefaults] setObject:savedCatFactsArrayCopy forKey:@"savedCatFactsArray"];
        }

    }];
    
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.catFacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C4QCatFactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatFactIdentifier" forIndexPath:indexPath];
    
    cell.catFactLabel.text = self.catFacts[indexPath.row];
    cell.saveCatFactButton.tag = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"catDetailView"]) {
        C4QCatFactsDetailViewController *dvc = segue.destinationViewController;
        dvc.catFact = self.catFacts[indexPath.row];
    }
}


@end
