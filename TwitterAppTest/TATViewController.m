//
//  TATViewController.m
//  TwitterAppTest
//
//  Created by Antonio Melgarejo on 5/8/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//
#import "TATViewController.h"
#import "STTwitter.h"

@interface TATViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *twitterFeed;
@property (weak, nonatomic) IBOutlet UILabel *UserLabel;

@end

@implementation TATViewController


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
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"ocx2XNmtUI5NIGJSjKFjC8nCu" consumerSecret:@"wZHNt2XBmxKFGSXzMYhAd0tKI5Yr6R0EIkSkyuDj1LYkKTsB37"];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username)
     {
         [twitter getUserTimelineWithScreenName:@"Starbucks" successBlock:^(NSArray *statuses) {
             self.twitterFeed = [NSMutableArray arrayWithArray:statuses];
             [self.tableView reloadData];
         } errorBlock:^(NSError *error) {
             NSLog(@"%@", error.debugDescription);
         }];
     }
                                    errorBlock:^(NSError *error)
     {
         NSLog(@"%@", error.debugDescription);
     } ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.twitterFeed.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"CellTw";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSInteger idx = indexPath.row;
    NSDictionary *t = self.twitterFeed[idx];
    
    cell.textLabel.text = t[@"text"];
    NSDictionary *user = t[@"user"];
    NSString *username = user[@"screen_name"];
    NSString *profile_image_url_https = user[@"profile_image_url_https" ];
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end