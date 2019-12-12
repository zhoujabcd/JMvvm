//
//  MutableLiveData.h
//  PodDemo
//
//  Created by justin on 2019/12/8.
//  Copyright © 2019 justin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JObserver;

NS_ASSUME_NONNULL_BEGIN

@interface JMutableLiveData<T> : NSObject
{
    T _value;
}

@property (nonatomic, copy)NSMutableDictionary<NSString*, JObserver *>* observerDic;

-(instancetype)init;

-(void)setValue:(T)value;

-(T)getValue;

-(void)observer:(void(^)(void))callBack atPath:(NSString *)path;

-(void)removeObserve:(NSString *)path;

-(void)removeAllObserve;

@end

NS_ASSUME_NONNULL_END
