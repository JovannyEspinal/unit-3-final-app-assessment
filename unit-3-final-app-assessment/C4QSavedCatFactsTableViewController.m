//
//  C4QSavedCatFactsTableViewController.m
//  unit-3-final-app-assessment
//
//  Created by Jovanny Espinal on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QSavedCatFactsTableViewController.h"
#import "C4QCatFactsDetailViewController.h"

@interface C4QSavedCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *savedCatFacts;

@end

@implementation C4QSavedCatFactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    self.savedCatFacts = [[NSMutableArray alloc] init];
    
    self.savedCatFacts = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCatFactsArray"];
    
    
}

- (void)setupNavigationBar {
    
    self.navigationItem.title = @"Saved Cat Facts";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];

}


-(void)done{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedCatFacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SavedCatFactsIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.savedCatFacts[indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"savedCatDetailView"]) {
        C4QCatFactsDetailViewController *dvc = segue.destinationViewController;
        dvc.catFact = self.savedCatFacts[indexPath.row];
    }
}


@end
