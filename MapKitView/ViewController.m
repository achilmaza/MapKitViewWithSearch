//
//  ViewController.m
//  MapKitView
//
//  Created by Aditya Narayan on 9/2/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import <MapKit/Mapkit.h>
#import "NYCLocation.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar* searchBar;
@property (assign, nonatomic) MKCoordinateRegion viewRegion;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationDegrees lat = 40.741444;
    CLLocationDegrees lon = -73.99007;
    CLLocation * location = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
    self.viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 5000, 5000);
    [self.mapView setRegion:self.viewRegion];
    
    self.mapView.delegate = self;
    self.searchBar.delegate = self;
    
}

-(IBAction)setMap:(id)sender {
    
    switch (((UISegmentedControl*)sender).selectedSegmentIndex){
            
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
    
}


-(void)localSearch:(NSString*)searchString{
    
    [self.mapView setRegion:self.viewRegion];
    
    MKLocalSearchRequest * request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = [searchString lowercaseString];
    request.region = self.viewRegion;
    
    MKLocalSearch* search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if([response.mapItems count] == 0){
            NSLog(@"No matches \n");
        }
        else{
            for(MKMapItem * item in response.mapItems){
                
                NYCLocation * pin = [[NYCLocation alloc] initWith:item.placemark.title andSubtitle:item.phoneNumber
                                                    andCoordinate:item.placemark.coordinate andImageName:@"" andURL:item.url.absoluteString];
                [self.mapView addAnnotation:pin];
            }
        }
        
    }];
    
}

#pragma mark UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self localSearch:searchBar.text];
    
}

//-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//}

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//}
//


#pragma mark MKMapViewDelegate

-(MKAnnotationView*)mapView:(MKMapView*)sender viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString* identifier = @"reusablePin";
    
    MKAnnotationView * aView = [sender dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(!aView){
        
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        aView.canShowCallout = YES;
    }
    
    aView.annotation = annotation;
    return aView;
}


-(void)mapView:(MKMapView*)sender didSelectAnnotationView:(MKAnnotationView *)view{
    
    
    if([[(NYCLocation*)[view annotation]imageName] compare:@""] != NSOrderedSame){
        UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[(NYCLocation*)[view annotation]imageName]]];
        image.frame = CGRectMake(0, 0, 46, 46);
        view.leftCalloutAccessoryView = image;
    }
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    view.rightCalloutAccessoryView = button;

}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%@",view.annotation.title);
    NSLog(@"%@",view.annotation.subtitle);
    
    //goto webview
    [self performSegueWithIdentifier:@"showWebView" sender:view];
    
}

#pragma segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showWebView"])
    {
        NSString* urlString = [(NYCLocation*)[sender annotation] url];
        NSURL* url = [[NSURL alloc] initWithString:urlString];
    
        [[segue destinationViewController] setUrl:url];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
