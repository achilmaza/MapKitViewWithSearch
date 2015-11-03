//
//  NYCLocation.m
//  MapKitView
//
//  Created by Aditya Narayan on 9/2/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import "NYCLocation.h"
#import <Mapkit/MapKit.h>

@implementation NYCLocation

- (instancetype)init
{
    return [self initWith:@"" andSubtitle:@"" andCoordinate:CLLocationCoordinate2DMake(0.0, 0.0) andImageName:@"" andURL:@""];
}


-(instancetype)initWith:(NSString*)titleVal andSubtitle:(NSString*)subtitleVal andCoordinate:(CLLocationCoordinate2D)coordinateVal andImageName:(NSString *)imageNameVal andURL:(NSString*)urlVal{
    
    self = [super init];
    
    if(self){
        self.title = [titleVal copy];
        self.subtitle = [subtitleVal copy];
        self.coordinate = coordinateVal;
        self.imageName = [imageNameVal copy];
        self.url = [urlVal copy];
    }
    
    return self;
    
}

@end
