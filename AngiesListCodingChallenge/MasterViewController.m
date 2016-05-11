//
//  ViewController.m
//  AngiesListCodingChallenge
//
//  Created by Jack Hutchinson on 5/10/16.
//  Copyright © 2016 Helium Apps. All rights reserved.
//

#import "MasterViewController.h"
#import "AngiesListCodingChallenge-Swift.h"


NSString *masterViewCellIdentifier = @"masterViewCellIdentifier";
NSString *detailsViewSegueIdentifier = @"detailsViewSegueIdentifier";

const NSInteger tagServiceProviderIcon = 200;
const NSInteger tagRecentReviews = 201;
const NSInteger tagServiceProvider = 202;
const NSInteger tagLocation = 203;

@interface MasterViewController ()

@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *activityView;
@property(nonatomic, strong) NSArray *serviceProviders;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self getServiceProviders];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Service Call 

-(void)getServiceProviders
{
    [self.activityView startAnimating];
    ServiceCall *serviceCall = [[ServiceCall alloc] init];
    [serviceCall getServiceProviders:^(NSArray *providers, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityView stopAnimating];
            if (error != nil)
            {
                NSLog(@"getServiceProviders error %@", error.localizedDescription);
            }
            else
            {
                // initial sort by name
                NSArray *sortedByName = [providers sortedArrayUsingComparator:^NSComparisonResult(Provider *obj1, Provider *obj2) {
                    return [obj1.name compare:obj2.name];
                }];
                
                self.serviceProviders = sortedByName;
                [self.tableView reloadData];
            }
        });
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.serviceProviders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:masterViewCellIdentifier forIndexPath:indexPath];
    
    Provider *provider = self.serviceProviders[indexPath.row];
    [self formatCell:cell provider:provider];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Provider *provider = self.serviceProviders[indexPath.row];
    [self performSegueWithIdentifier:detailsViewSegueIdentifier sender:provider];
}

#pragma mark - UITableViewCell Helpers

-(void)formatCell:(UITableViewCell *)cell provider:(Provider *)provider
{
    UIView *view;
    // Recent reviews label
    view = [cell viewWithTag:tagRecentReviews];
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *label = (UILabel *)view;
        label.text = [NSString stringWithFormat:@"%ld Recent Review%@", provider.reviewCount, provider.reviewCount==1?@"":@"s"];
    }
    
    // Service provider name
    view = [cell viewWithTag:tagServiceProvider];
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *label = (UILabel *)view;
        label.text = provider.name;
    }
    
    // Service provider location
    view = [cell viewWithTag:tagLocation];
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *label = (UILabel *)view;
        label.text = provider.location;
    }
    
    // Grade icon
    view = [cell viewWithTag:tagServiceProviderIcon];
    if ([view isKindOfClass:[UIImageView class]])
    {
        UIImageView *imageView = (UIImageView *)view;
        imageView.image = [UIImage imageFromText:provider.overallGrade bounds:view.bounds color:[provider badgeColor]];
        imageView.layer.cornerRadius = view.bounds.size.width / 2;
        imageView.clipsToBounds = YES;
    }
}

#pragma mark - UINavigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(Provider *)sender
{
    // remove Back button text:
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    // controller-specific initialization
    if ([segue.destinationViewController isKindOfClass:[DetailViewController class]])
    {
        // by convention sender is a Provider
        DetailViewController *controller = (DetailViewController *)segue.destinationViewController;
        controller.provider = sender;
    }
}

@end
