//
//  SCNThermostatViewController.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNThermostatViewController.h"

#import "SCNThermostatDataProvider.h"
#import "SCNLocationDataProvider.h"

@interface SCNThermostatViewController ()

@property (nonatomic, strong) SCNThermostatDataProvider *thermostatProvider;
@property (nonatomic, strong) SCNLocationDataProvider *locationProvider;
@property (nonatomic, strong) NSString *locationId;

@property (weak, nonatomic) IBOutlet UILabel *lastConnectionDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *canCoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *canHeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *isUsingEmergencyHeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasFanLabel;
@property (weak, nonatomic) IBOutlet UISwitch *fanTimerSwitcher;
@property (weak, nonatomic) IBOutlet UILabel *fanTimerTimeoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasLeafLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UISlider *targetTemperatureSlider;
@property (weak, nonatomic) IBOutlet UILabel *targetTemperatureLabel;
@property (weak, nonatomic) IBOutlet UISlider *targetTemperatureHighSlider;
@property (weak, nonatomic) IBOutlet UILabel *targetTemperatureHighLabel;
@property (weak, nonatomic) IBOutlet UISlider *targetTemperatureLowSlider;
@property (weak, nonatomic) IBOutlet UILabel *targetTemperatureLowLabel;
@property (weak, nonatomic) IBOutlet UILabel *hvacStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTemperatureHighLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTemperatureLowLabel;
@property (weak, nonatomic) IBOutlet UILabel *ambientTemperatureLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *temperatureScaleSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hvacModeSegmentedControl;

@property (nonatomic, strong) NSTimer *sliderUpdateTimer;
@property (nonatomic, copy) void(^sliderUpdateBlock)();

@end

@implementation SCNThermostatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    __weak typeof(self) weakSelf = self;
    self.thermostatProvider = [SCNThermostatDataProvider providerWithDeviceId:self.deviceId];
    [self.thermostatProvider setUpdateBlock:^(NSError *error) {
        if (nil != error) {
            [weakSelf scnShowAlertWithError:error actionBlock:nil];
        }
        [weakSelf _updateThermostatData];
    }];
}

#pragma mark - Actions
- (IBAction)onHvacModeValueChanged:(id)sender {
    [self.thermostatProvider.thermostat setHvacMode:self.hvacModeSegmentedControl.selectedSegmentIndex];
    [self.thermostatProvider saveThermostatHvacModeWithCompletion:
     ^(NSError *error) {
         if (nil != error) {
             [self scnShowAlertWithError:error];
         }
     }];
}

- (IBAction)onTargetTemperatureLowValueChanged:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self _activateSliderTimerWithUpdateBlock:^{
        NSNumber *temperatureNumber = @(weakSelf.targetTemperatureLowSlider.value);
        [weakSelf.thermostatProvider.thermostat setTargetTemperatureLowNumber:temperatureNumber];
        [weakSelf.thermostatProvider saveThermostatTargetTemperatureHighLowWithCompletion:
         ^(NSError *error) {
             if (nil != error) {
                 [self scnShowAlertWithError:error];
             }
         }];
        [weakSelf _updateTemperatureValues];
    }];
}

- (IBAction)onTargetTemperatureHighValueChanged:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self _activateSliderTimerWithUpdateBlock:^{
        NSNumber *temperatureNumber = @(weakSelf.targetTemperatureHighSlider.value);
        [weakSelf.thermostatProvider.thermostat setTargetTemperatureHighNumber:temperatureNumber];
        [weakSelf.thermostatProvider saveThermostatTargetTemperatureHighLowWithCompletion:
         ^(NSError *error) {
             if (nil != error) {
                 [self scnShowAlertWithError:error];
             }
         }];
        [weakSelf _updateTemperatureValues];
    }];
    
}

- (IBAction)onTargetTemperatureValueChanged:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self _activateSliderTimerWithUpdateBlock:^{
        NSNumber *temperatureNumber = @(weakSelf.targetTemperatureSlider.value);
        [weakSelf.thermostatProvider.thermostat setTargetTemperatureNumber:temperatureNumber];
        [weakSelf.thermostatProvider saveThermostatTargetTemperatureWithCompletion:
         ^(NSError *error) {
             if (nil != error) {
                 [self scnShowAlertWithError:error];
             }
         }];
        [weakSelf _updateTemperatureValues];
    }];
}

- (IBAction)onFanTimerActiveValueChanged:(id)sender {
    self.thermostatProvider.thermostat.fanTimerActiveNumber = @(self.fanTimerSwitcher.on);
    [self.thermostatProvider saveThermostatFanTimerActiveWithCompletion:
     ^(NSError *error) {
         if (nil != error) {
             [self scnShowAlertWithError:error];
         }
     }];
}

#pragma mark - Private
- (void)_activateSliderTimerWithUpdateBlock:(void(^)())updateBlock {
    self.sliderUpdateBlock = updateBlock;
    [self.sliderUpdateTimer invalidate];
    self.sliderUpdateTimer = nil;
    self.sliderUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.3
                                                              target:self
                                                            selector:@selector(_sliderUpdateTimerFired:)
                                                            userInfo:nil
                                                             repeats:NO];
}

- (void)_sliderUpdateTimerFired:(NSTimer *)timer {
    self.sliderUpdateTimer = nil;
    if (nil != self.sliderUpdateBlock) {
        self.sliderUpdateBlock();
        self.sliderUpdateBlock = nil;
    }
}

- (void)_updateThermostatData {
    SCNNestThermostat *thermostat = self.thermostatProvider.thermostat;
    self.navigationItem.title = thermostat.name;
    self.lastConnectionDateLabel.text = thermostat.lastConnectionDateString;
    self.canCoolLabel.text = thermostat.canCoolString;
    self.canHeatLabel.text = thermostat.canHeatString;
    self.isUsingEmergencyHeatLabel.text = thermostat.isUsingEmergencyHeatString;
    self.hasFanLabel.text = thermostat.hasFanString;
    NSNumber *fanTimerActiveNumber = thermostat.fanTimerActiveNumber;
    if (nil != fanTimerActiveNumber) {
        self.fanTimerSwitcher.enabled = YES;
        self.fanTimerSwitcher.on = fanTimerActiveNumber.boolValue;
    } else {
        self.fanTimerSwitcher.enabled = NO;
    }
    self.fanTimerTimeoutLabel.text = thermostat.fanTimerTimeoutString;
    self.hasLeafLabel.text = thermostat.hasLeafString;
    self.hvacStateLabel.text = thermostat.hvacStateString;
    self.humidityLabel.text = thermostat.humidityString;
    if (thermostat.isHvacModeValid) {
        self.hvacModeSegmentedControl.enabled = YES;
        [self _updateUIByHvacMode:thermostat.hvacMode];
    } else {
        self.hvacModeSegmentedControl.enabled = NO;
    }
    [self _updateTemperatureValues];
    if (![self.locationId isEqualToString:thermostat.locationId]) {
        __weak typeof(self) weakSelf = self;
        self.locationProvider = [SCNLocationDataProvider providerWithLocationId:thermostat.locationId
                                                                    structureId:thermostat.structureId];
        [self.locationProvider setUpdateBlock:^(NSError *error) {
            if (nil != error) {
                [weakSelf scnShowAlertWithError:error actionBlock:nil];
            }
            [weakSelf _updateLoacation];
        }];
    }
}

- (void)_updateUIByHvacMode:(SCNNestHVACMode)hvacMode {
    self.hvacModeSegmentedControl.selectedSegmentIndex = hvacMode;
    switch (hvacMode) {
        case SCNNestHVACModeCool:
        case SCNNestHVACModeHeat:
            self.targetTemperatureSlider.userInteractionEnabled = YES;
            self.targetTemperatureHighSlider.userInteractionEnabled = NO;
            self.targetTemperatureLowSlider.userInteractionEnabled = NO;
            break;
        case SCNNestHVACModeHeatCool:
            self.targetTemperatureSlider.userInteractionEnabled = NO;
            self.targetTemperatureHighSlider.userInteractionEnabled = YES;
            self.targetTemperatureLowSlider.userInteractionEnabled = YES;
            break;
        case SCNNestHVACModeOff:
            self.targetTemperatureSlider.userInteractionEnabled = NO;
            self.targetTemperatureHighSlider.userInteractionEnabled = NO;
            self.targetTemperatureLowSlider.userInteractionEnabled = NO;
        default:
            break;
    }
}

- (void)_updateTemperatureValues {
    SCNNestThermostat *thermostat = self.thermostatProvider.thermostat;
    self.temperatureScaleSegmentedControl.enabled = NO;
    if (thermostat.isTemperatureScaleValid) {
        self.temperatureScaleSegmentedControl.selectedSegmentIndex = thermostat.temperatureScale;
    } else {
        self.temperatureScaleSegmentedControl.selectedSegmentIndex = NSNotFound;
    }
    self.targetTemperatureLabel.text = thermostat.targetTemperatureString;
    [self _setupTemperatureSlider:self.targetTemperatureSlider
                  withValueNumber:thermostat.targetTemperatureNumber
                   minValueNumber:thermostat.targetTemperatureMinNumber
                   maxValueNumber:thermostat.targetTemperatureMaxNumber];
    self.targetTemperatureHighLabel.text = thermostat.targetTemperatureHighString;
    [self _setupTemperatureSlider:self.targetTemperatureHighSlider
                  withValueNumber:thermostat.targetTemperatureHighNumber
                   minValueNumber:thermostat.targetTemperatureMinNumber
                   maxValueNumber:thermostat.targetTemperatureMaxNumber];
    self.targetTemperatureLowLabel.text = thermostat.targetTemperatureLowString;
    [self _setupTemperatureSlider:self.targetTemperatureLowSlider
                  withValueNumber:thermostat.targetTemperatureLowNumber
                   minValueNumber:thermostat.targetTemperatureMinNumber
                   maxValueNumber:thermostat.targetTemperatureMaxNumber];
    self.awayTemperatureHighLabel.text = thermostat.awayTemperatureHighString;
    self.awayTemperatureLowLabel.text = thermostat.awayTemperatureLowString;
    self.ambientTemperatureLabel.text = thermostat.ambientTemperatureString;
}

- (void)_updateLoacation {
    self.locationLabel.text = self.locationProvider.location.name;
}

- (void)_setupTemperatureSlider:(UISlider *)slider
                withValueNumber:(NSNumber *)valueNumber
                 minValueNumber:(NSNumber *)minValueNumber
                 maxValueNumber:(NSNumber *)maxValueNumber {
    if (nil != valueNumber) {
        slider.enabled = YES;
        slider.minimumValue = minValueNumber.doubleValue;
        slider.maximumValue = maxValueNumber.doubleValue;
        slider.value = valueNumber.doubleValue;
    } else {
        slider.enabled = NO;
    }
}

@end
