//
//  MutableLiveData.m
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import "JMutableLiveData.h"
#import "JObserver.h"

@interface JMutableLiveData<T>()
{
    T _value;
    
   
}
@end

@implementation JMutableLiveData
{
    NSLock *_lock;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"_value"];
    
    _observerDic = nil;
    
    _value = nil;
    
    _lock = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observerDic = [[NSMutableDictionary alloc]init];
        
        _lock = [[NSLock alloc]init];
        
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
            __strong typeof(self) sS = wS;
            
            if(sS != nil)
            {
                for(JObserver *o in sS.observerDic.allValues)
                {
                    o.callBack();
                }
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

- (void)observer:(void (^)(void))callBack atPath:(nonnull NSString *)path
{
    JObserver *o = [[JObserver alloc]init];
    
    [o setCallBack:callBack];
    
    [_lock lock];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:_observerDic];
    [mDic setObject:o forKey:path];
    _observerDic = mDic;
    [_lock unlock];
}

- (void)removeObserve:(NSString *)path
{
    [_lock lock];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:_observerDic];
    [mDic removeObjectForKey:path];
    _observerDic = mDic;
    [_lock unlock];
}

- (void)removeAllObserve
{
    [_lock lock];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:_observerDic];
    [mDic removeAllObjects];
    _observerDic = mDic;
    [_lock unlock];
}

@end
