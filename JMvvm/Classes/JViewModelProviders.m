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
{
    NSLock *_lock;
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[self alloc]init];
    });
    return ins;
}

-(void)dealloc
{
    _providerMap = nil;
    
    _lock = nil;
}

+ (JViewModelProvider *)ofViewController:(UIViewController *)viewController
{
    NSString *mapName = [[NSString alloc]initWithUTF8String:object_getClassName(viewController)]
    ;
    
    JViewModelProvider *provider = [JViewModelProviders.shareInstance.providerMap objectForKey:mapName];
    
    if(provider == nil)
    {
        provider = [[JViewModelProvider alloc]init];
        
        [JViewModelProviders.shareInstance addProvider:provider key:mapName];
    }
    
    return provider;
}

+ (JViewModelProvider *)ofApplication:(UIApplication *)application
{
    NSString *mapName = [[NSString alloc]initWithUTF8String:object_getClassName(application)]
    ;
    
    JViewModelProvider *provider = [JViewModelProviders.shareInstance.providerMap objectForKey:mapName];
    
    if(provider == nil)
    {
        provider = [[JViewModelProvider alloc]init];
        
        [JViewModelProviders.shareInstance addProvider:provider key:mapName];
    }
    
    return provider;
}

+ (void)clean
{
    [JViewModelProviders.shareInstance removeAllProvider];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _providerMap = [[NSMutableDictionary alloc]init];
        
        _lock = [[NSLock alloc]init];
    }
    return self;
}

- (void)addProvider:(JViewModelProvider *)provider key:(NSString *)key
{
    [_lock lock];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:JViewModelProviders.shareInstance.providerMap];
    [mDic setObject:provider forKey:key];
    JViewModelProviders.shareInstance.providerMap = mDic;
    [_lock unlock];
}

- (void)removeAllProvider
{
    [_lock lock];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:JViewModelProviders.shareInstance.providerMap];
    [mDic removeAllObjects];
    JViewModelProviders.shareInstance.providerMap = mDic;
    [_lock unlock];
}

@end
