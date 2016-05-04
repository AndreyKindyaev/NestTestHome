//
//  SCNStructuresViewController.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNStructuresViewController.h"

#import "SCNStructuresDataProvider.h"
#import "UITableView+SCNUtils.h"
#import "UIView+SCNLockView.h"
#import "SCNSettings.h"

@interface SCNStructuresViewController ()

@property (nonatomic, strong) SCNStructuresDataProvider *provider;

@end

@implementation SCNStructuresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Structures";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView scnHideEmptySeparators];
    
    [self.view scnShowLockViewWithText:@"Loading"];
    __weak typeof(self) weakSelf = self;
    self.provider = [SCNStructuresDataProvider providerWithUpdateBlock:^(NSError *error) {
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = structure.name;
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
}

#pragma mark - Private
- (SCNNestStructure *)_structureAtIndexPath:(NSIndexPath *)indexPath {
    return [self.provider structureAtIndex:indexPath.row];
}

@end
