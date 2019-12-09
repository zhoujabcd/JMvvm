//
//  JViewModelProvider.m
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import "JViewModelProvider.h"

@implementation JViewModelProvider

- (instancetype)init
{
    self = [super init];
    if (self) {
        _modelMap = [[NSMutableDictionary alloc]init];
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
        
        [_modelMap setObject:model forKey:classStr];
    }
    
    return model;
}

@end
