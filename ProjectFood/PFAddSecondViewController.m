//
//  PFAddSecondViewController.m
//  ProjectFood
//
//  Created by Abbin Varghese on 10/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFAddSecondViewController.h"
#import "PFRestaurantTextFieldCell.h"
#import "PFTagTableViewCell.h"
#import "PFConstants.h"
#import "PFItemPicker.h"
#import "PFLocationPicker.h"

@interface PFAddSecondViewController ()<UITextFieldDelegate,TLTagsControlDelegate,PFItemPickerDelegate,PFLocationPickerDelegate>

@property (nonatomic, strong) NSString *restaurantName;
@property (strong, nonatomic) NSMutableArray * restaurantPhoneNumber;
@property (strong, nonatomic) NSMutableDictionary * restaurantLocation;

@property (strong, nonatomic) IBOutlet UITableView *restTableView;

@end

@implementation PFAddSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:itemPickerSegue]){
        PFItemPicker *vc = segue.destinationViewController;
        vc.pickerMode = PFPickerModeTypeRestaurant;
        vc.delegate = self;
    }
    else if ([segue.identifier isEqualToString:locationPickerSegueKey]){
        PFLocationPicker *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource -


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 3;
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PFRestaurantTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFRestaurantTextFieldCell"];
        cell.cellTextField.placeholder = @"Restaurant name";
        cell.cellImageView.image = [UIImage imageNamed:@"restaurant"];
        cell.cellTextField.tag = indexPath.section;
        cell.cellTextField.userInteractionEnabled = NO;
        return cell;
    }
    else if (indexPath.section == 1){
        PFRestaurantTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFRestaurantTextFieldCell"];
        cell.cellTextField.text = @"Choose location";
        cell.cellTextField.textColor = [UIColor redColor];
        cell.cellImageView.image = [UIImage imageNamed:@"location"];
        cell.cellTextField.tag = indexPath.section;
        cell.cellTextField.userInteractionEnabled = NO;
        return cell;
    }
    else if(indexPath.section == 2){
        PFTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFTagTableViewCell"];
        cell.cellTagView.tagPlaceholder = @"Type phone number here";
        cell.cellTagView.delegate = self;
        return cell;
    }
    else{
        if (indexPath.row == 0) {
            PFRestaurantTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFRestaurantTextFieldCell"];
            cell.cellTextField.placeholder = @"Days";
            cell.cellImageView.image = [UIImage imageNamed:@"Calander"];
            cell.cellTextField.userInteractionEnabled = NO;
            return cell;
        }
        else if (indexPath.row == 1){
            PFRestaurantTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFRestaurantTextFieldCell"];
            cell.cellTextField.placeholder = @"From";
            cell.cellImageView.image = [UIImage imageNamed:@"From"];
            cell.cellTextField.delegate = self;
            cell.cellTextField.tag = indexPath.section;
            cell.cellTextField.userInteractionEnabled = YES;
            return cell;
        }
        else{
            PFRestaurantTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFRestaurantTextFieldCell"];
            cell.cellTextField.placeholder = @"Till";
            cell.cellImageView.image = [UIImage imageNamed:@"Till"];
            cell.cellTextField.delegate = self;
            cell.cellTextField.tag = indexPath.section;
            cell.cellTextField.userInteractionEnabled = YES;
            return cell;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate -

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Restaurant name";
    }
    else if (section == 1){
        return @"Location";
    }
    else if (section == 2){
        return @"Phone Number(optional)";
    }
    else{
        return @"Working hours(optional)";
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:itemPickerSegue sender:self];
    }
    else if (indexPath.section == 1){
        [self performSegueWithIdentifier:locationPickerSegueKey sender:self];
    }
    else if (indexPath.section == 3 && indexPath.row == 0){
        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 0) {
        _restaurantName = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TLTagsControlDelegate -


-(void)tagsControl:(TLTagsControl *)tagsControl didRemoveTag:(NSString *)string{
    [_restaurantPhoneNumber removeObject:string];
}

-(void)tagsControl:(TLTagsControl *)tagsControl didAddTag:(NSString *)string{
    if (_restaurantPhoneNumber == nil) {
        _restaurantPhoneNumber = [NSMutableArray new];
    }
    [_restaurantPhoneNumber addObject:string];
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - PFItemPickerDelegate -


-(void)PFItemPicker:(PFItemPicker *)picker didFinishWithNewItem:(NSString *)item{
    PFRestaurantTextFieldCell *cell = [_restTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.cellTextField.text = item;
    _restaurantName = item;
}

-(void)PFItemPicker:(PFItemPicker *)picker didFinishWithExistingItem:(NSDictionary *)item{
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - PFItemPickerDelegate -


-(void)PFLocationPicker:(PFLocationPicker *)picker didCompleteWithLocation:(NSMutableDictionary *)location{
    PFRestaurantTextFieldCell *cell = [_restTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.cellTextField.text = location[locationNameKey];
    _restaurantLocation = location;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -


- (void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submit:(id)sender{
    
}

@end
