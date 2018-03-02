//
//  UserValues.h
//  WagYoTail
//
//  Created by Ben Coffman on 3/01/18.
//  Copyright © 2018 Ben Coffman. All rights reserved.
//

#ifndef UserValues_h
#define UserValues_h


#endif /* UserValues_h */

@interface UserVals : NSObject
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *goldBadgeCount;
@property (nonatomic, strong) NSString *silverBadgeCount;
@property (nonatomic, strong) NSString *bronzeBadgeCount;


-(id)initWithValue:(NSString *)userName
          imageURL:(NSString *)imageURL
    goldBadgeCount:(NSString *)goldBadgeCount
  silverBadgeCount:(NSString *)silverBadgeCount
  bronzeBadgeCount:(NSString *)bronzeBadgeCount;

@end
