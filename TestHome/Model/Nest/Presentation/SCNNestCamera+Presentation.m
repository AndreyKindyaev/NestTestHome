//
//  SCNNestCamera+Presentation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/6/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestCamera+Presentation.h"

@implementation SCNNestCamera (Presentation)

- (NSString *)isAudioInputEnabledString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.isAudioInputEnabledNumber];
}

- (NSString *)lastIsOnlineChangeString {
    return [SCNNilObjectValueTransformer nilDashesUIStringForDate:self.lastIsOnlineChange];
}

- (NSString *)isVideoHistoryEnabledString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.isVideoHistoryEnabledNumber];
}

@end
