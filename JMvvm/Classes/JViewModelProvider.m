//
//  JViewModelProvider.m
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import "JViewModelProvider.h"

@implementation JViewModelProvider
{
    NSLock *_lock;
}

- (void)dealloc
{
    _lock = nil;
    
    _modelMap = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _modelMap = [[NSMutableDictionary alloc]init];
        
        _lock = [[NSLock alloc]init];
    }
    return self;
}

- (id)get:(Class)className
{
    NSString *classStr = NSStringFromClass(className);
    
    id model = [_modelMap objectForKey:classStr];
    
    if(model == nil)
    {
        model = [[className alloc]init];
        
        [_lock lock];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:_modelMap];
        [mDic setObject:model forKey:classStr];
        _modelMap = mDic;
        [_lock unlock];
    }
    
    return model;
}

@end
