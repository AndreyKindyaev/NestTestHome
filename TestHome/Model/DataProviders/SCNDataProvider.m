//
//  SCNDataProvider.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNDataProvider.h"

@interface SCNDataProvider ()

@property (nonatomic, strong) NSString *uniqueKey;
@property (nonatomic, strong) NSString *observerUrl;

@end

@implementation SCNDataProvider

- (void)dealloc {
    [[SCNNestFirebaseManager sharedInstance] removeObserverForUrl:self.observerUrl
                                                  withObserverKey:self.uniqueKey];
}

- (instancetype)init {
    self = [super init];
    if (nil != self) {
        _uniqueKey = [[NSUUID UUID] UUIDString];
    }
    return self;
}

- (void)observeUrl:(NSString *)url updateBlock:(void(^)(FDataSnapshot *snapshot))updateBlock {
    self.observerUrl = url;
    [[SCNNestFirebaseManager sharedInstance] observeUrl:self.observerUrl
                                        withObserverKey:self.uniqueKey
                                            updateBlock:
     ^(FDataSnapshot *snapshot) {
         if (nil != updateBlock) {
             updateBlock(snapshot);
         }
     }];
}

- (void)setValue:(id)value withCompletion:(void(^)(NSError *error))completion {
    [[SCNNestFirebaseManager sharedInstance] setValue:value
                                               forUrl:self.observerUrl
                                          observerKey:self.uniqueKey
                                       withCompletion:
     ^(NSError *error) {
         if (nil != completion) {
             completion(error);
         }
     }];
}

@end
