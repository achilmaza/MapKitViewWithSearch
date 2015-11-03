//
//  WebViewController.h
//  MapKitView
//
//  Created by Aditya Narayan on 9/2/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import <UIKit/UIKit.h>

@import WebKit;

@interface WebViewController : UIViewController <WKNavigationDelegate>

@property (nonatomic, strong) NSURL * url;

@end
