//
//  MLCategoryAViewController.m
//  HappyWife HappyLife
//
//  Created by MLinc on 2014-07-04.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLCategoryAViewController.h"
#import "MLCategoryBViewController.h"

@interface MLCategoryAViewController ()

@end

@implementation MLCategoryAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
    int cat = 0;
    if([segue.identifier isEqualToString:@"dating"]){
        cat=3;
    }else if([segue.identifier isEqualToString:@"relation"]){
        cat=4;
    }
    
    if ([segue.destinationViewController isKindOfClass:[MLCategoryBViewController class]]) {
        // Configure Books View Controller
        MLCategoryBViewController* dest =  (MLCategoryBViewController *)segue.destinationViewController;
        dest.categoryA = cat;
    }
    
}


@end
