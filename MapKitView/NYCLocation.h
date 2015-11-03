//
//  NYCLocation.h
//  MapKitView
//
//  Created by Aditya Narayan on 9/2/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/MapKit.h>

@interface NYCLocation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, copy) NSString* url;

-(instancetype)initWith:(NSString*)titleVal andSubtitle:(NSString*)subtitleVal andCoordinate:(CLLocationCoordinate2D)coordinateVal andImageName:(NSString*)imageNameVal andURL:(NSString*)urlVal;

@end
