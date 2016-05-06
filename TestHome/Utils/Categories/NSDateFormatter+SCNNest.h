//
//  NSDateFormatter+SCNNest.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

@interface NSDateFormatter (SCNNest)

// @"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
+ (NSDateFormatter *)scnNestDateFormatter;

// @"yyyy.MM.dd HH:mm"
+ (NSDateFormatter *)scnUIDateFormatter;

@end
