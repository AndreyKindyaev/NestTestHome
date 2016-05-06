//
//  SCNDevicesViewController.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDevicesViewController.h"

// data providers
#import "SCNAwayDataProvider.h"
#import "SCNStructureNameDataProvider.h"
#import "SCNDevicesDataProvider.h"

// entities
#import "SCNSettings.h"
#import "SCNNestCamera.h"
#import "SCNNestThermostat.h"
#import "SCNNestSmokeCOAlarm.h"

// controllers
#import "SCNCameraViewController.h"
#import "SCNThermostatViewController.h"
#import "SCNSmokeCOAlarmViewController.h"

static NSString *const kSegueIdCamera = @"SCNDevicesToCamera";
static NSString *const kSegueIdThermostat = @"SCNDevicesToThermostat";
static NSString *const kSegueIdSmokeCOAlarm = @"SCNDevicesToSmokeCOAlarm";

@interface SCNDevicesViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong) SCNAwayDataProvider *awayProvider;
@property (nonatomic, strong) SCNStructureNameDataProvider *nameProvider;
@property (nonatomic, strong) SCNDevicesDataProvider *devicesProvider;

@property (nonatomic, strong) SCNNestDevice *selectedDevice;

@end

@implementation SCNDevicesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView scnHideEmptySeparators];
    
    NSString *structureId = [SCNSettings sharedInstance].activeStructureId;
    __weak typeof(self) weakSelf = self;
    self.awayProvider = [SCNAwayDataProvider providerWithStructureId:structureId];
    [self.awayProvider setUpdateBlock:^(NSError *error) {
        if (nil != error) {
            [weakSelf scnShowAlertWithError:error actionBlock:nil];
        }
        [weakSelf _updateAway];
    }];
    self.nameProvider = [SCNStructureNameDataProvider providerWithStructureId:structureId];
    [self.nameProvider setUpdateBlock:^(NSError *error) {
        if (nil != error) {
            [weakSelf scnShowAlertWithError:error actionBlock:nil];
        }
        [weakSelf _updateName];
    }];
    self.devicesProvider = [SCNDevicesDataProvider providerWithStructureId:structureId];
    [self.devicesProvider setUpdateBlock:
     ^(NSError *error) {
         if (nil != error) {
             [weakSelf scnShowAlertWithError:error actionBlock:nil];
         }
         [weakSelf _updateDevices];
     }];
    self.tabBarController.delegate = self;
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
    if (self != viewController) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceCellId"];
    cell.textLabel.text = device.name;
    cell.detailTextLabel.text = device.isOnlineString;
    cell.detailTextLabel.textColor = device.isOnlineTextColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SCNNestDevice *device = [self.devicesProvider deviceAtIndexPath:indexPath];
    self.selectedDevice = device;
    if ([device isKindOfClass:[SCNNestCamera class]]) {
        [self performSegueWithIdentifier:kSegueIdCamera sender:self];
    } else if ([device isKindOfClass:[SCNNestThermostat class]]) {
        [self performSegueWithIdentifier:kSegueIdThermostat sender:self];
    } else if ([device isKindOfClass:[SCNNestSmokeCOAlarm class]]) {
        [self performSegueWithIdentifier:kSegueIdSmokeCOAlarm sender:self];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueId = segue.identifier;
    if ([segueId isEqualToString:kSegueIdCamera]) {
        ((SCNCameraViewController *)segue.destinationViewController).deviceId = self.selectedDevice.deviceId;
    } else if ([segueId isEqualToString:kSegueIdThermostat]) {
        ((SCNThermostatViewController *)segue.destinationViewController).deviceId = self.selectedDevice.deviceId;
    } else if ([segueId isEqualToString:kSegueIdSmokeCOAlarm]) {
        ((SCNSmokeCOAlarmViewController *)segue.destinationViewController).deviceId = self.selectedDevice.deviceId;
    }
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
