//
//  PFLocationPicker.m
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFLocationPicker.h"
#import "NSMutableDictionary+TFALocation.h"

@import GoogleMaps;

@interface PFLocationPicker ()<UITableViewDelegate,UITableViewDataSource,GMSAutocompleteFetcherDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) GMSAutocompleteFetcher *fetcher;
@property (strong, nonatomic) NSArray *listArray;

@end

@implementation PFLocationPicker

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        filter.country = countryCode;
        self.fetcher = [[GMSAutocompleteFetcher alloc] initWithBounds:nil filter:filter];
        self.fetcher.delegate = self;
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return self.listArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"Detect my location";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = [UIImage imageNamed:@"Current Location"];
    }
    else{
        GMSAutocompletePrediction *prediction = [self.listArray objectAtIndex:indexPath.row];
        cell.textLabel.attributedText = prediction.attributedPrimaryText;
        cell.detailTextLabel.attributedText = prediction.attributedSecondaryText;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }
    else{
        return 55;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [[GMSPlacesClient sharedClient] currentPlaceWithCallback:^(GMSPlaceLikelihoodList * _Nullable likelihoodList, NSError * _Nullable error) {
            if (error == nil) {
                GMSPlaceLikelihood *likelihood = [likelihoodList.likelihoods objectAtIndex:0];
                GMSPlace* place = likelihood.place;
                NSMutableDictionary *obj = [[NSMutableDictionary alloc]initWithGMSPlace:place];
                if ([self.delegate respondsToSelector:@selector(PFLocationPicker:didCompleteWithLocation:)]) {
                    [self.delegate PFLocationPicker:self didCompleteWithLocation:obj];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                
                UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get your current location" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }];
    }
    else{
        
        GMSAutocompletePrediction *prediction = [self.listArray objectAtIndex:indexPath.row];
        
        [[GMSPlacesClient sharedClient] lookUpPlaceID:prediction.placeID callback:^(GMSPlace * _Nullable result, NSError * _Nullable error) {
            if (error == nil) {
                NSMutableDictionary *obj = [[NSMutableDictionary alloc]initWithGMSPlace:result];
                if ([self.delegate respondsToSelector:@selector(PFLocationPicker:didCompleteWithLocation:)]) {
                    [self.delegate PFLocationPicker:self didCompleteWithLocation:obj];
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                
                UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get location" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.label.text = @"";
    [self.fetcher sourceTextHasChanged:searchText];
}

- (void)didAutocompleteWithPredictions:(NSArray *)predictions {
    
    if (predictions.count>0) {
        self.label.text = @"";
    }
    else{
        self.label.text = @"No results found";
    }
    self.listArray = predictions;
    [self.listTableView reloadData];
}

- (void)didFailAutocompleteWithError:(NSError *)error {
    self.label.text = @"No results found";
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
