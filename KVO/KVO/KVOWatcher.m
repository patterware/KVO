//
//  KVOWatcher.m
//  KVO
//
//  Created by Andrew Patterson on 11/16/2013.
//  Copyright (c) 2013 Andrew Patterson. All rights reserved.
//

#import "KVOWatcher.h"

@interface KVOWatcher()
@property (nonatomic) NSString *keypath;
@property (nonatomic) id watching;
@property (nonatomic, copy) KVOKeypathChangedCallback callback;
@end

@implementation KVOWatcher

+(instancetype)watcherForKeypath:(NSString *)keypath object:(id)object callback:(KVOKeypathChangedCallback)callback {
    return [[self alloc] initWithKeypath:keypath object:object callback:callback];
}

-(id)initWithKeypath:(NSString *)keypath object:(id)object callback:(KVOKeypathChangedCallback)callback {
    NSAssert(keypath && object && callback, @"missing required KVOWatcher argument");
    if (self = [self init]) {
        _keypath = keypath;
        _watching = object;
        _callback = callback;
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSAssert([keyPath isEqualToString:self.keypath], @"wrong keypath");
    NSAssert(object == self.watching, @"wrong object");
    self.callback(change);
}

-(void)dealloc {
    NSLog(@"dealloc!!!");
    [self.watching removeObserver:self forKeyPath:self.keypath];
}

@end
