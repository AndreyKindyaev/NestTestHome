//
//  SCNDevicesViewController.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDevicesViewController.h"

#import "SCNAwayDataProvider.h"
#import "SCNStructureNameDataProvider.h"
#import "SCNSettings.h"
#import "UIView+SCNLockView.h"
#import "UITableView+SCNUtils.h"

@interface SCNDevicesViewController ()

@property (nonatomic, strong) SCNAwayDataProvider *awayProvider;
@property (nonatomic, strong) SCNStructureNameDataProvider *nameProvider;

@end

@implementation SCNDevicesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView scnHideEmptySeparators];
    
    NSString *sructureId = [SCNSettings sharedInstance].activeStructureId;
    self.awayProvider = [SCNAwayDataProvider providerWithStructureId:sructureId
                                                         updateBlock:
                         ^(NSError *error) {
                             [self _updateAway];
                         }];
    self.nameProvider = [SCNStructureNameDataProvider providerWithStructureId:sructureId
                                                                  updateBlock:
                         ^(NSError *error) {
                             [self _updateName];
                         }];
}

#pragma mark - IBActions
- (IBAction)onAway:(id)sender {
    [self _updateAwayToState:SCNNestAwayStateAway];
}

- (IBAction)onHome:(id)sender {
    [self _updateAwayToState:SCNNestAwayStateHome];
}

#pragma mark - Private
- (void)_updateAway {
    switch (self.awayProvider.away) {
        case SCNNestAwayStateHome:
            self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Away"
                                                                                      style:UIBarButtonItemStylePlain
                                                                                     target:self
                                                                                     action:@selector(onAway:)];
            break;
        case SCNNestAwayStateAway:
            self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home"
                                                                                      style:UIBarButtonItemStylePlain
                                                                                     target:self
                                                                                     action:@selector(onHome:)];
        default:
            self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
            break;
    }
    
}

- (void)_updateAwayToState:(SCNNestAwayState)state {
    [self.view scnShowLockViewWithText:@"Updating"];
    __weak typeof(self) weakSelf = self;
    [self.awayProvider setAway:state
                    completion:
     ^(NSError *error) {
         [weakSelf _updateAway];
         [weakSelf.view scnHideLockView];
     }];
}

- (void)_updateName {
    self.navigationItem.title = self.nameProvider.name;
}

@end
