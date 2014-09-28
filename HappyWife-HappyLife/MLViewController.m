//
//  MLViewController.m
//  HappyWife-HappyLife
//
//  Created by MLinc on 2014-06-29.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLViewController.h"
#import "MLWordsDb.h"
#import "MLDetailsViewController.h"


@interface MLViewController ()
@property(strong, nonatomic)NSString* compliment;
@end

@implementation MLViewController

NSArray* tableData;


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    tableData = [MLWordsDb getAllWordsFromCategory:self.categoryA categoryB:self.categoryB];//getAllWords];
}

-(void)setReminder{


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [(MLWord*)[tableData objectAtIndex:indexPath.row] word];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.compliment = [tableData objectAtIndex:[indexPath row]];
    
    
    // Perform Segue
    //[self performSegueWithIdentifier:@"getDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[MLDetailsViewController class]]) {
        // Configure Books View Controller
       MLDetailsViewController* dest =  (MLDetailsViewController *)segue.destinationViewController;
        dest.compliment =
        ((UITableViewCell*)sender).textLabel.text; //self.compliment;
        
        //self.compliment=nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
