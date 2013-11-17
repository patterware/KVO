KVO
===

A category on NSObject that adds block based KVO. 

Sample Usage
------------

```objectivec
@interface Sample : NSObject
@property (nonatomic) id testProperty;
@end

#import "NSObject+KVO.h"

-(void) startWatchingObject:(Sample *)sample {
  [self kvoWatchNewValueOnKeyPath:@"testProperty" object:sample callback:^(id newValue) {
    NSLog(@"testProperty changed value");
  }];
}  

-(void) stopWatchingObject:(Sample *)sample {
  [self kvoStopWatchingKeypath:@"testProperty" onObject:sample];
}
```
