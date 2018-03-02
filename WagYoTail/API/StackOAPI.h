//
//  Header.h
//  WagYoTail
//
//  Created by Ben Coffman on 3/01/18.
//  Copyright © 2018 Ben Coffman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^StackOPageCompletionBlk)(id result);
typedef void (^StackOPageFailureBlk)(NSError *error);

@interface StackOAPI : NSObject

+(StackOAPI *)sharedInstance;

-(void)getStackPage:(NSURL *)url completion:(StackOPageCompletionBlk)stackOPageCompletionBlk failure:(StackOPageFailureBlk)stackOPageFailureBlk;

@end
