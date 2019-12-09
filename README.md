# JMvvm

[![CI Status](https://img.shields.io/travis/zhoujabcd/JMvvm.svg?style=flat)](https://travis-ci.org/zhoujabcd/JMvvm)
[![Version](https://img.shields.io/cocoapods/v/JMvvm.svg?style=flat)](https://cocoapods.org/pods/JMvvm)
[![License](https://img.shields.io/cocoapods/l/JMvvm.svg?style=flat)](https://cocoapods.org/pods/JMvvm)
[![Platform](https://img.shields.io/cocoapods/p/JMvvm.svg?style=flat)](https://cocoapods.org/pods/JMvvm)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JMvvm is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/zhoujabcd/mySpecs'
pod 'JMvvm'
```

## Use
Create a ViewModel and declare a JMutableLiveData property.JMutableLiveData supports a paradigm that encapsulates objects that need to listen for changes:
```ruby
#import <Foundation/Foundation.h>
#import <JMutableLiveData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

@property(nonatomic, strong)JMutableLiveData<NSString*> *data;

@end

NS_ASSUME_NONNULL_END
```

Get the ViewModel through JViewModelProviders. If there is no instance ViewModel before, a new ViewModel will be created. The scope of the ViewModel is managed based on the incoming ViewController. Different ViewControllers will get different ViewModel.
```ruby
ViewModel *viewModel = [[JViewModelProviders ofViewController:[[ViewController alloc]init]]get:ViewModel.class];
```
Add a ViewModel with scope of the whole application
```ruby
ViewModel *viewModel = [[JViewModelProviders ofApplicaton:[UIApplication sharedApplication]]get:ViewModel.class];
```
Add an observer for attributes that need to observe changes，path is used to mark the observer for easy deletion
```ruby
[viewModel.data observer:^{
        NSLog(@"!-- viewModel observer in ViewController");
    } atPath:@"ViewController"];
```
Through the setValue method of jmutablelivedata to change the object value, the observer can receive the relevant object change events, and get the object content through getValue
```ruby
[viewModel.data setValue:@"value change in ViewController"];
```
Delete an observer
```ruby
[viewModel.data removeObserve:@"ViewController"];
```
Delete all observer
```ruby
[viewModel.data removeAllObserve];
```


## Author

zhoujabcd, labinnah1982@hotmail.com

## License

JMvvm is available under the MIT license. See the LICENSE file for more info.
