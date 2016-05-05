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
#import "SCNDevicesDataProvider.h"
#import "SCNSettings.h"
#import "UIView+SCNLockView.h"
#import "UITableView+SCNUtils.h"
#import "UIViewController+SCNErrorAlerts.h"

@interface SCNDevicesViewController ()

@property (nonatomic, strong) SCNAwayDataProvider *awayProvider;
@property (nonatomic, strong) SCNStructureNameDataProvider *nameProvider;
@property (nonatomic, strong) SCNDevicesDataProvider *devicesProvider;

@end

@implementation SCNDevicesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView scnHideEmptySeparators];
    
    NSString *structureId = [SCNSettings sharedInstance].activeStructureId;
    __weak typeof(self) weakSelf = self;
    self.awayProvider = [SCNAwayDataProvider providerWithStructureId:structureId
                                                         updateBlock:
                         ^(NSError *error) {
                             if (nil != error) {
                                 [weakSelf scnShowAlertWithError:error actionBlock:nil];
                             }
                             [self _updateAway];
                         }];
    self.nameProvider = [SCNStructureNameDataProvider providerWithStructureId:structureId
                                                                  updateBlock:
                         ^(NSError *error) {
                             if (nil != error) {
                                 [weakSelf scnShowAlertWithError:error actionBlock:nil];
                             }
                             [self _updateName];
                         }];
    self.devicesProvider = [SCNDevicesDataProvider providerWithStructureId:structureId
                                                               updateBlock:
                            ^(NSError *error) {
                                if (nil != error) {
                                    [weakSelf scnShowAlertWithError:error actionBlock:nil];
                                }
                                [self _updateDevices];
                            }];
}

#pragma mark - IBActions
- (IBAction)onAway:(id)sender {
    [self _updateAwayToState:SCNNestAwayStateAway];
}

- (IBAction)onHome:(id)sender {
    [self _updateAwayToState:SCNNestAwayStateHome];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.devicesProvider numberOfDeviceTypes];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.devicesProvider deviceTypeNameAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.devicesProvider numberOfDevicesForTypeIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCNNestDevice *device = [self.devicesProvider deviceAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = device.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
         if (nil != error) {
             [weakSelf scnShowAlertWithError:error actionBlock:nil];
         }
         [weakSelf _updateAway];
         [weakSelf.view scnHideLockView];
     }];
}

- (void)_updateName {
    self.navigationItem.title = self.nameProvider.name;
}

- (void)_updateDevices {
    [self.tableView reloadData];
}

@end
