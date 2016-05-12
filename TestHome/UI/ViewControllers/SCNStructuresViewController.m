//
//  SCNStructuresViewController.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNStructuresViewController.h"

#import "SCNStructuresDataProvider.h"
#import "SCNSettings.h"
#import "SCNNestAuthManager.h"

@interface SCNStructuresViewController ()

@property (nonatomic, strong) SCNStructuresDataProvider *provider;

@end

@implementation SCNStructuresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Structures";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onLogout:)];
    [self.tableView scnHideEmptySeparators];
    
    [self.view scnShowLockViewWithText:@"Loading"];
    __weak typeof(self) weakSelf = self;
    self.provider = [SCNStructuresDataProvider new];
    [self.provider setUpdateBlock:^(NSError *error) {
        if (nil != error) {
            [weakSelf scnShowAlertWithError:error actionBlock:nil];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.view scnHideLockView];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.provider numberOfStructures];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCNNestStructure *structure = [self _structureAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StructureCellId"];
    cell.textLabel.text = structure.name;
    cell.detailTextLabel.text = structure.awayString;
    cell.detailTextLabel.textColor = structure.awayColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = (([[SCNSettings sharedInstance].activeStructureId isEqualToString:structure.structureId])
                          ? UITableViewCellAccessoryCheckmark
                          : UITableViewCellAccessoryNone);
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [SCNSettings sharedInstance].activeStructureId = [self _structureAtIndexPath:indexPath].structureId;
    [tableView reloadData];
    self.tabBarController.selectedIndex = 1;
}

#pragma mark - Actions
- (IBAction)onLogout:(id)sender {
    [[SCNNestAuthManager sharedInstance] logout];
    [self performSegueWithIdentifier:@"SCNStucturesToLogin" sender:self];
}

#pragma mark - Private
- (SCNNestStructure *)_structureAtIndexPath:(NSIndexPath *)indexPath {
    return [self.provider structureAtIndex:indexPath.row];
}

@end
