//
//  SCNNestFirebaseManager.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/3/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestFirebaseManager.h"

#import "SCNNestAuthManager.h"
#import "NSError+Utils.h"

@interface SCNNestFirebaseManager ()

@property (nonatomic, strong) Firebase *rootFirebase;

@property (nonatomic, strong) NSMutableDictionary *snapshotsByUrl;
@property (nonatomic, strong) NSMutableDictionary *observersByUrl;

@end

@implementation SCNNestFirebaseManager

+ (instancetype)sharedInstance {
    static SCNNestFirebaseManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
        
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (nil != self) {
        self.snapshotsByUrl = [NSMutableDictionary new];
        self.observersByUrl = [NSMutableDictionary new];
        self.rootFirebase = [[Firebase alloc] initWithUrl:@"https://developer-api.nest.com/"];
        NSString *validToken = [SCNNestAuthManager sharedInstance].validToken;
        [self.rootFirebase authWithCustomToken:validToken withCompletionBlock:nil];
    }
    return self;
}

- (void)observeUrl:(NSString *)url
   withObserverKey:(NSString *)key
       updateBlock:(void (^)(FDataSnapshot *snapshot))block {
    void(^safeUpdateBlock)(FDataSnapshot *) = ^(FDataSnapshot *snapshot) {
        if (nil != block) {
            block(snapshot);
        }
    };
    Firebase *observer = [self.rootFirebase childByAppendingPath:url];
    __weak typeof(self) weakSelf = self;
    [observer observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        weakSelf.snapshotsByUrl[url] = snapshot;
        safeUpdateBlock(snapshot);
    }];
    // replace observer (with its update block) for url if exist
    NSMutableDictionary *observersByKey = self.observersByUrl[url];
    if (nil == observersByKey) {
        observersByKey = [NSMutableDictionary new];
        self.observersByUrl[url] = observersByKey;
    }
    observersByKey[key] = observer;
}

- (void)removeObserverForUrl:(NSString *)url
             withObserverKey:(NSString *)key {
    NSMutableDictionary *observersByKey = self.observersByUrl[url];
    Firebase *observer = observersByKey[key];
    [observer removeAllObservers];
    [observersByKey removeObjectForKey:key];
}

- (void)setValue:(id)value
          forUrl:(NSString *)url
     observerKey:(NSString *)observerKey
  withCompletion:(void(^)(NSError *error))completion {
    // IMPORTANT to set withLocalEvents to NO
    // Read more here: https://www.firebase.com/docs/transactions.html
    NSMutableDictionary *observersByKey = self.observersByUrl[url];
    Firebase *observer = nil;
    if (nil != observersByKey) {
        observer = observersByKey[observerKey];
        [observer runTransactionBlock:^FTransactionResult *(FMutableData *currentData) {
            [currentData setValue:value];
            return [FTransactionResult successWithValue:currentData];
        } andCompletionBlock:^(NSError *error, BOOL committed, FDataSnapshot *snapshot) {
            if (nil != completion) {
                completion(error);
            }
        } withLocalEvents:NO];
    } else {
        if (nil != completion) {
            completion([NSError scnErrorWithCode:SCNErrorCodeInvalidObserver]);
        }
    }
}

@end
