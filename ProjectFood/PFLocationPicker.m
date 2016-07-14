//
//  PFLocationPicker.m
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFLocationPicker.h"

@interface PFLocationPicker ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) NSArray *listArray;

@end

@implementation PFLocationPicker

- (void)viewDidLoad {
    [super viewDidLoad];
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
        [self dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(PFLocationPicker:didCompleteWithLocation:)]) {
                [self.delegate PFLocationPicker:self didCompleteWithLocation:nil];
            }
        }];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(PFLocationPicker:didCompleteWithLocation:)]) {
                [self.delegate PFLocationPicker:self didCompleteWithLocation:nil];
            }
        }];
    }
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.label.text = @"";
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

@end
