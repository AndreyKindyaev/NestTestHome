//
//  SCNSmokeCOAlarmViewController.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNSmokeCOAlarmViewController.h"

#import "SCNSmokeCOAlarmDataProvider.h"
#import "SCNLocationDataProvider.h"

@interface SCNSmokeCOAlarmViewController ()

@property (weak, nonatomic) IBOutlet UILabel *isOnlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastConnectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *batteryHealthLabel;
@property (weak, nonatomic) IBOutlet UILabel *coAlarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *smokeAlarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *isManualTestActiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastManualTestTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (nonatomic, strong) SCNSmokeCOAlarmDataProvider *alarmProvider;
@property (nonatomic, strong) SCNLocationDataProvider *locationProvider;
@property (nonatomic, strong) NSString *locationId;

@end

@implementation SCNSmokeCOAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    self.alarmProvider = [SCNSmokeCOAlarmDataProvider providerWithDeviceId:self.deviceId];
    [self.alarmProvider setUpdateBlock:^(NSError *error) {
        if (nil != error) {
            [weakSelf scnShowAlertWithError:error actionBlock:nil];
        }
        [weakSelf _updateAlarmData];
    }];
}

#pragma mark - Private
- (void)_updateAlarmData {
    SCNNestSmokeCOAlarm *alarm = self.alarmProvider.smokeCOAlarm;
    self.navigationItem.title = alarm.name;
    self.navigationController.navigationBar.barTintColor = alarm.color;
    self.isOnlineLabel.text = alarm.isOnlineString;
    self.lastConnectionLabel.text = alarm.lastConnectionDateString;
    self.batteryHealthLabel.text = alarm.batteryHealthString;
    self.coAlarmLabel.text = alarm.coAlarmStateString;
    self.smokeAlarmLabel.text = alarm.smokeAlarmStateString;
    self.isManualTestActiveLabel.text = alarm.manualTestActiveString;
    self.lastManualTestTimeLabel.text = alarm.lastManualTestTimeString;
    if (![self.locationId isEqualToString:alarm.locationId]) {
        __weak typeof(self) weakSelf = self;
        self.locationProvider = [SCNLocationDataProvider providerWithLocationId:alarm.locationId
                                                                    structureId:alarm.structureId];
        [self.locationProvider setUpdateBlock:^(NSError *error) {
            if (nil != error) {
                [weakSelf scnShowAlertWithError:error actionBlock:nil];
            }
            [weakSelf _updateLoacation];
        }];
    }
}

- (void)_updateLoacation {
    self.locationLabel.text = self.locationProvider.location.name;
}

@end
