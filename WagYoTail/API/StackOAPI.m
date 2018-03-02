//
//  StackOAPI.m
//  WagYoTail
//
//  Created by Ben Coffman on 3/01/18.
//  Copyright © 2018 Ben Coffman. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "StackOAPI.h"
#import "AFHTTPSessionManager.h"



@implementation StackOAPI

+(StackOAPI *)sharedInstance{
    static StackOAPI *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[StackOAPI alloc] init];
    });
	return instance;
};

-(void)getStackPage:(NSURL *)url completion:(StackOPageCompletionBlk)stackOPageCompletionBlk failure:(StackOPageFailureBlk)stackOPageFailureBlk{
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		stackOPageCompletionBlk(responseObject);
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		stackOPageFailureBlk(error);
	}];

}




@end
