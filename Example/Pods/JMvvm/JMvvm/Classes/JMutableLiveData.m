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
        _observerList = [[NSMutableArray alloc]init];
        
        [self addObserver:self forKeyPath:@"_value" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"_value"])
    {
        for(JObserver *o in _observerList)
        {
            o.callBack();
        }
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
    
    [_observerList removeAllObjects];
    
    _observerList = nil;
    
    _value = nil;
}

- (void)observer:(void (^)(void))callBack
{
    JObserver *o = [[JObserver alloc]init];
    
    [o setCallBack:callBack];
    
    [_observerList addObject:o];
}

@end
