//
//  PFAddFirstViewController.m
//  ProjectFood
//
//  Created by Abbin Varghese on 08/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFAddSecondViewController.h"
#import "PFAddFirstViewController.h"
#import "PFImagePreviewCell.h"
#import "PFTextFieldCell.h"
#import "PFTextViewCell.h"
#import "PFItemPicker.h"
#import "PFConstants.h"

@interface PFAddFirstViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,PFItemPickerDelegate>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *descrip;
@property (nonatomic, strong) UIToolbar *numberToolbar;

@end

@implementation PFAddFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _numberToolbar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(toolbarDoneClicked)];
    done.tintColor = [UIColor redColor];
    _numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           done,
                           nil];
    [_numberToolbar sizeToFit];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:addSecondViewControllerSegue]) {
        PFAddSecondViewController *vc = segue.destinationViewController;
        vc.name = _name;
        vc.price = _price;
        vc.descrip = _descrip;
    }
    else if ([segue.identifier isEqualToString:itemPickerSegue]){
        PFItemPicker *vc = segue.destinationViewController;
        vc.pickerMode = PFPickerModeTypeItem;
        vc.delegate = self;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource -


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PFImagePreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFImagePreviewCell"];
        cell.images = _images;
        return cell;
    }
    else{
        if(indexPath.row == 0 || indexPath.row == 1){
            PFTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFTextFieldCell"];
            cell.cellTextField.delegate = self;
            cell.cellTextField.tag = indexPath.row;
            cell.cellTextField.inputAccessoryView = _numberToolbar;
            if (indexPath.row == 0) {
                cell.cellTextField.placeholder = @"Name";
                cell.cellImageView.image = [UIImage imageNamed:@"pizza"];
                cell.cellTextField.userInteractionEnabled = NO;
            }
            else if(indexPath.row == 1){
                cell.cellTextField.placeholder = @"Price";
                cell.cellImageView.image = [UIImage imageNamed:@"price"];
                cell.cellTextField.userInteractionEnabled = YES;
            }
            return cell;
        }
        else{
            PFTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFTextViewCell"];
            cell.cellImageView.image = [UIImage imageNamed:@"description"];
            cell.cellTextView.delegate = self;
            cell.cellTextView.inputAccessoryView = _numberToolbar;
            return cell;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate -


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return tableView.frame.size.height/2.5;
    }
    else{
        if (indexPath.row == 2) {
            return tableView.frame.size.height/4;
        }
        else{
            return 55;
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Image preview";
    }
    else{
        return @"Details";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:itemPickerSegue sender:self];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITextViewDelegate -


-(void)textViewDidChange:(UITextView *)textView{
    _descrip = textView.text;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"Description (Optional)"]) {
        textView.text = @"";
        textView.textColor = [UIColor darkTextColor];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"Description (Optional)";
        textView.textColor = [UIColor colorWithWhite:0 alpha:0.25];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITextFieldDelegate -


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 1) {
        NSString *newStr = [NSString stringWithFormat:@"%@%@",textField.text,string];
        NSString *newStr2 = [newStr substringWithRange:NSMakeRange(1, [newStr length]-1)];
        _price = newStr2;
        if (range.location == 0 && range.length == 1) {
            return NO;
        }
        else{
            return YES;
        }
    }
    else{
        return YES;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        if (textField.text.length == 0) {
            textField.text = [self currencySymbol];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        if ([textField.text isEqualToString:[self currencySymbol]]) {
            textField.text = @"";
            textField.placeholder = @"Price";
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - PFItemPickerDelegate -


-(void)PFItemPicker:(PFItemPicker *)picker didFinishWithExistingItem:(NSDictionary *)item{
    
}

-(void)PFItemPicker:(PFItemPicker *)picker didFinishWithNewItem:(NSString *)item{
    PFTextFieldCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.cellTextField.text = item;
    _name = item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions -


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)next{
//    if (_name.length>0 && _price.length>0) {
        [self performSegueWithIdentifier:addSecondViewControllerSegue sender:self];
//    }
//    else{
//        if (_name.length == 0) {
//            PFTextFieldCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
//            [cell shakeCell];
//        }
//        if (_price.length == 0) {
//            PFTextFieldCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
//            [cell shakeCell];
//        }
//    }
}

-(void)toolbarDoneClicked{
    [self.view endEditing:YES];
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utility Methods -


-(NSString*)currencySymbol{
    return [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
}


@end
