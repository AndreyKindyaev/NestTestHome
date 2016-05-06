//
//  SCNNestAuthToken.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

@interface SCNNestAuthToken : MTLModel <MTLJSONSerializing>

+ (instancetype)tokenWithString:(NSString *)string expirationDate:(NSDate *)expirationDate;

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSDate *expirationDate;

- (BOOL)isValid;

@end
