//
//  SCNCameraViewController.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNCameraViewController.h"

#import "SCNCameraDataProvider.h"
#import "SCNLocationDataProvider.h"
#import "SCNNestCameraEvent.h"

@interface SCNCameraViewController ()

@property (nonatomic, strong) SCNCameraDataProvider *cameraProvider;
@property (nonatomic, strong) SCNLocationDataProvider *locationProvider;
@property (nonatomic, strong) NSString *locationId;

// camera outlets
@property (weak, nonatomic) IBOutlet UILabel *isOnlineLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isStreamingSwitcher;
@property (weak, nonatomic) IBOutlet UILabel *isAudioInputEnabledLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastIsOnlineChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *isVideoHistoryEnabledLabel;
@property (weak, nonatomic) IBOutlet UIButton *safariButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *appButton;

// last event outlets
@property (weak, nonatomic) IBOutlet UILabel *hasSoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasMotionLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlsExpireTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *lastEventSafariButton;
@property (weak, nonatomic) IBOutlet UIButton *lastEventAppButton;

@end

@implementation SCNCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    __weak typeof(self) weakSelf = self;
    self.cameraProvider = [SCNCameraDataProvider providerWithDeviceId:self.deviceId];
    [self.cameraProvider setUpdateBlock:^(NSError *error) {
        if (nil != error) {
            [weakSelf scnShowAlertWithError:error actionBlock:nil];
        }
        [weakSelf _updateCameraData];
    }];
}

#pragma mark - Actions
- (IBAction)onIsStreamingSwitcher:(id)sender {
    self.cameraProvider.camera.isStreamingNumber = @(self.isStreamingSwitcher.on);
    [self.cameraProvider saveCameraIsStreamingWithCompletion:
     ^(NSError *error) {
         if (nil != error) {
             [self scnShowAlertWithError:error];
         }
     }];
}

- (IBAction)onSafariButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.cameraProvider.camera.webUrl]];
}

- (IBAction)onAppButton:(id)sender {
    [[UIApplication sharedApplication] scnOpenNestAppUrl:self.cameraProvider.camera.appUrl];
}

- (IBAction)onLastEventSafariButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.cameraProvider.camera.lastEvent.webUrl]];
}

- (IBAction)onLastEventAppButton:(id)sender {
    [[UIApplication sharedApplication] scnOpenNestAppUrl:self.cameraProvider.camera.lastEvent.appUrl];
}

#pragma mark - Private
- (void)_updateCameraData {
    SCNNestCamera *camera = self.cameraProvider.camera;
    self.navigationItem.title = camera.name;
    self.isOnlineLabel.text = camera.isOnlineString;
    if (nil != camera.isStreamingNumber) {
        self.isStreamingSwitcher.enabled = YES;
        self.isStreamingSwitcher.on = camera.isStreamingNumber.boolValue;
    } else {
        self.isStreamingSwitcher.enabled = NO;
    }
    self.isAudioInputEnabledLabel.text = camera.isAudioInputEnabledString;
    self.lastIsOnlineChangeLabel.text = camera.lastIsOnlineChangeString;
    self.isVideoHistoryEnabledLabel.text = camera.isVideoHistoryEnabledString;
    if (![self.locationId isEqualToString:camera.locationId]) {
        __weak typeof(self) weakSelf = self;
        self.locationProvider = [SCNLocationDataProvider providerWithLocationId:camera.locationId
                                                                    structureId:camera.structureId];
        [self.locationProvider setUpdateBlock:^(NSError *error) {
            if (nil != error) {
                [weakSelf scnShowAlertWithError:error actionBlock:nil];
            }
            [weakSelf _updateLoacation];
        }];
    }
    
    SCNNestCameraEvent *event = camera.lastEvent;
    self.hasSoundLabel.text = event.hasSoundString;
    self.hasMotionLabel.text = event.hasMotionString;
    self.startTimeLabel.text = event.startTimeString;
    self.endTimeLabel.text = event.endTimeString;
    self.urlsExpireTimeLabel.text = event.urlsExpireTimeString;
    BOOL isUrlButtonsHidden = event.isUrlsExpired;
    self.lastEventSafariButton.hidden = isUrlButtonsHidden;
    self.lastEventAppButton.hidden = isUrlButtonsHidden;
}

- (void)_updateLoacation {
    self.locationLabel.text = self.locationProvider.location.name;
}

@end
