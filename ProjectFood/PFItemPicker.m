//
//  PFItemPicker.m
//  ProjectFood
//
//  Created by Abbin Varghese on 11/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFItemPicker.h"
#import "PFConstants.h"

@import Firebase;

@interface PFItemPicker ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *itemTableView;
@property (nonatomic, strong) FIRDatabaseReference *ref;
@property (nonatomic, strong) NSArray *itemArray;
@end

@implementation PFItemPicker

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_pickerMode == PFPickerModeTypeItem) {
        self.ref = [[[FIRDatabase database] reference] child:fuudPathKey];
    }
    else{
        self.ref = [[[FIRDatabase database] reference] child:restaurentPathKey];
    }
    [_searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length>0) {
        NSString *searchString = [searchText lowercaseString];
        NSString *searchKey;
        
        if (_pickerMode == PFPickerModeTypeItem) {
            searchKey = fuudTitleCappedKey;
        }
        else{
            searchKey = restaurantNameCappedKey;
        }
        [_ref removeAllObservers];
        [[[[[_ref  queryLimitedToLast:5] queryStartingAtValue:searchString] queryEndingAtValue:[NSString stringWithFormat:@"%@\uf8ff",searchString]] queryOrderedByChild:searchKey]observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
            if (snapshot.value != [NSNull null]) {
                NSDictionary *dict = snapshot.value;
                _itemArray = [dict allValues];
            }
            else{
                _itemArray = nil;
            }
            [_itemTableView reloadData];
            
        }];
    }
    else{
        [_itemTableView reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchBar.text.length>0) {
        return _itemArray.count+1;
    }
    else{
        return _itemArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (indexPath.row == _itemArray.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"Add '%@' as a new item",_searchBar.text];
        cell.detailTextLabel.text = @"";
    }
    else{
        cell.textLabel.text = [[_itemArray objectAtIndex:indexPath.row] objectForKey:fuudTitleKey];
        cell.detailTextLabel.text = @"Restaurant name here";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == _itemArray.count) {
        if ([self.delegate respondsToSelector:@selector(PFItemPicker:didFinishWithNewItem:)]) {
            [self.delegate PFItemPicker:self didFinishWithNewItem:_searchBar.text];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(PFItemPicker:didFinishWithExistingItem:)]) {
            [self.delegate PFItemPicker:self didFinishWithExistingItem:[_itemArray objectAtIndex:indexPath.row]];
        }
    }
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
