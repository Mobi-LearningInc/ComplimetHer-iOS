//
//  MLCategoryBViewController.m
//  HappyWife HappyLife
//
//  Created by MLinc on 2014-07-04.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLCategoryBViewController.h"
#import "MLViewController.h"

@interface MLCategoryBViewController ()

@end

@implementation MLCategoryBViewController

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
    if([segue.identifier isEqualToString:@"romantic"]){
        cat=1;
    }else if([segue.identifier isEqualToString:@"light"]){
        cat=2;
    }
    
    if ([segue.destinationViewController isKindOfClass:[MLViewController class]]) {
        // Configure Books View Controller
        MLViewController* dest =  (MLViewController *)segue.destinationViewController;
        dest.categoryA = self.categoryA;
        dest.categoryB = cat;
    }
}


@end
