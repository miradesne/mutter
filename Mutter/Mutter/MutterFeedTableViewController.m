//
//  MutterFeedTableViewController.m
//  Mutter
//
//  Created by Mira Chen on 4/29/15.
//  Copyright (c) 2015 MiraStudio. All rights reserved.
//

#import "MutterFeedTableViewController.h"
#import "MutterFeedTableViewCell.h"
#import <FormatterKit/TTTTimeIntervalFormatter.h>
@interface MutterFeedTableViewController ()
@property (strong, nonatomic) NSMutableArray *feeds;
@end

@implementation MutterFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showPostFeedController)];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setUpParseQuery];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray*)feeds {
    if (!_feeds) {
        _feeds = [[NSMutableArray alloc] init];
    }
    return _feeds;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.feeds.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MutterFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MutterFeedCell" forIndexPath:indexPath];
    PFObject *feed = [self.feeds objectAtIndex:indexPath.row
                      ];
    // Configure the cell...
    cell.feedLabel.text = [feed objectForKey:@"Title"];
    NSString *feedCreatedPrettyTime = [[[TTTTimeIntervalFormatter alloc] init] stringForTimeInterval:[feed.createdAt timeIntervalSinceNow]];
    cell.feedCreatedDateLabel.text = [NSString stringWithFormat:@"- %@",feedCreatedPrettyTime];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)setUpParseQuery {
    PFQuery *query = [PFQuery queryWithClassName:@"Story"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            self.feeds = [NSMutableArray arrayWithArray:objects];
            NSSortDescriptor* sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
            [self.feeds sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)showPostFeedController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ComposeFeed" bundle:nil];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
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
