//
//  SCNNestFirebaseManager.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/3/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestFirebaseManager.h"

#import "SCNNestAuthManager.h"

@interface SCNNestFirebaseManager ()

@property (nonatomic, strong) Firebase *rootFirebase;

@property (nonatomic, strong) NSMutableDictionary *snapshotsByUrl;
@property (nonatomic, strong) NSMutableDictionary *observersByUrl;
@property (nonatomic, strong) NSMutableDictionary *updateBlocksByKeyByUrl;

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
        self.updateBlocksByKeyByUrl = [NSMutableDictionary new];
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
    // set update block
    NSMutableDictionary *updateBlocksByKey = self.updateBlocksByKeyByUrl[url];
    if (nil == updateBlocksByKey) {
        updateBlocksByKey = [NSMutableDictionary new];
        self.updateBlocksByKeyByUrl[url] = updateBlocksByKey;
    }
    updateBlocksByKey[key] = [safeUpdateBlock copy];
    // create observer or return stored snapshot for exist observer
    Firebase *observer = self.observersByUrl[url];
    if (nil == observer) {
        observer = [self.rootFirebase childByAppendingPath:url];
        self.observersByUrl[url] = observer;
        __weak typeof(self) weakSelf = self;
        [observer observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            // update snapshot
            weakSelf.snapshotsByUrl[url] = snapshot;
            NSDictionary *updateBlocksByKey = weakSelf.updateBlocksByKeyByUrl[url];
            [updateBlocksByKey.allValues enumerateObjectsUsingBlock:
             ^(void (^updateBlock)(FDataSnapshot *snapshot) , NSUInteger idx, BOOL * _Nonnull stop) {
                 if (nil != updateBlock) {
                     updateBlock(snapshot);
                 }
             }];
        }];
    } else {
        safeUpdateBlock(self.snapshotsByUrl[url]);
    }
}

- (void)removeObserverForUrl:(NSString *)url
             withObserverKey:(NSString *)key {
    Firebase *observer = self.observersByUrl[url];
    [observer removeAllObservers];
    [self.observersByUrl removeObjectForKey:url];
    
    [self.snapshotsByUrl removeObjectForKey:url];
    
    [self.updateBlocksByKeyByUrl[url] removeObjectForKey:key];
}

- (void)setValue:(id)value
          forUrl:(NSString *)url
     observerKey:(NSString *)observerKey
  withCompletion:(void(^)(NSError *error))completion {
    // IMPORTANT to set withLocalEvents to NO
    // Read more here: https://www.firebase.com/docs/transactions.html
    Firebase *observer = self.observersByUrl[url];
    if (nil != observer) {
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
