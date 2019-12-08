//
//  JViewModelProviders.m
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import "JViewModelProviders.h"
#import <UIKit/UIKit.h>
#import "JViewModelProvider.h"

static JViewModelProviders *ins = nil;

@implementation JViewModelProviders

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[self alloc]init];
    });
    return ins;
}

+ (JViewModelProvider *)ofViewController:(UIViewController *)viewController
{
    NSString *mapName = [[NSString alloc]initWithUTF8String:object_getClassName(viewController)]
    ;
    
    JViewModelProvider *provider = [JViewModelProviders.shareInstance.providerMap objectForKey:mapName];
    
    if(provider == nil)
    {
        provider = [[JViewModelProvider alloc]init];
        
        [JViewModelProviders.shareInstance.providerMap setObject:provider forKey:mapName];
    }
    
    return provider;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _providerMap = [[NSMutableDictionary alloc]init];
    }
    return self;
}

@end
