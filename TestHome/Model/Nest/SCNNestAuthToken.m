//
//  SCNNestAuthToken.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestAuthToken.h"

//static NSString *const kTokenKey = @"token";
//static NSString *const kExpirationDateKey = @"expirationDate";

@implementation SCNNestAuthToken

+ (instancetype)tokenWithString:(NSString *)string expirationDate:(NSDate *)expirationDate {
    SCNNestAuthToken *token = [self new];
    token.string = string;
    token.expirationDate = expirationDate;
    return token;
}

- (BOOL)isValid {
    return ([[NSDate date] compare:self.expirationDate] == NSOrderedAscending);
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"expirationDate": @"expires_in",
             @"string": @"access_token"};
}

+ (NSValueTransformer *)expirationDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:
            ^id(NSNumber *expiresInTime, BOOL *success, NSError *__autoreleasing *error) {
                return [NSDate dateWithTimeIntervalSinceNow:expiresInTime.doubleValue];
            }];
}

//#pragma mark - NSCoding
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.string forKey:kTokenKey];
//    [encoder encodeObject:self.expirationDate forKey:kExpirationDateKey];
//}
//
//- (id)initWithCoder:(NSCoder *)decoder {
//    if (self = [super init]) {
//        self.string = [decoder decodeObjectForKey:kTokenKey];
//        self.expirationDate = [decoder decodeObjectForKey:kExpirationDateKey];
//    }
//    return self;
//}

@end
