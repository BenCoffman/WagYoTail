//
//  UserValues.m
//  WagYoTail
//
//  Created by Ben Coffman on 3/01/18.
//  Copyright © 2018 Ben Coffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserValues.h"


@implementation UserVals
-(id)initWithValue:(NSString *)userName imageURL:(NSString *)imageURL goldBadgeCount:(NSString *)goldBadgeCount silverBadgeCount:(NSString *)silverBadgeCount bronzeBadgeCount:(NSString *)bronzeBadgeCount{
        if(self = [super init]){
            self.userName = userName;
            self.imageURL = imageURL;
            self.goldBadgeCount = goldBadgeCount;
            self.silverBadgeCount = silverBadgeCount;
            self.bronzeBadgeCount = bronzeBadgeCount;
        }
    return self;
}


@end

