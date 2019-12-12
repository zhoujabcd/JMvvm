//
//  MutableLiveData.m
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import "JMutableLiveData.h"
#import "JObserver.h"

@implementation JMutableLiveData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observerDic = [[NSMutableDictionary alloc]init];
        
        [self addObserver:self forKeyPath:@"_value" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"_value"])
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        __weak typeof(self) wS = self;
        
        dispatch_async(queue, ^{
            for(JObserver *o in wS.observerDic.allValues)
            {
                o.callBack();
            }
        });
    } else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setValue:(id)value
{
    [self setValue:value forKey:@"_value"];
}

-(id)getValue
{
    return _value;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"_value"];
    
    [_observerDic removeAllObjects];
    
    _observerDic = nil;
    
    _value = nil;
}

- (void)observer:(void (^)(void))callBack atPath:(nonnull NSString *)path
{
    JObserver *o = [[JObserver alloc]init];
    
    [o setCallBack:callBack];
    
    [_observerDic setObject:o forKey:path];
}

- (void)removeObserve:(NSString *)path
{
    [_observerDic removeObjectForKey:path];
}

- (void)removeAllObserve
{
    [_observerDic removeAllObjects];
}

@end
