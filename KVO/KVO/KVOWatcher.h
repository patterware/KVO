//
//  KVOWatcher.h
//  KVO
//
//  Created by Andrew Patterson on 11/16/2013.
//  Copyright (c) 2013 Andrew Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+KVO.h"

@interface KVOWatcher : NSObject
+(instancetype)watcherForKeypath:(NSString *)keypath object:(id)object callback:(KVOKeypathChangedCallback)callback;
@end
