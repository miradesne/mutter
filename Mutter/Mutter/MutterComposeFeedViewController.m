//
//  MutterComposeFeedViewController.m
//  Mutter
//
//  Created by Mira Chen on 4/30/15.
//  Copyright (c) 2015 MiraStudio. All rights reserved.
//

#import "MutterComposeFeedViewController.h"

@interface MutterComposeFeedViewController ()
@property (weak, nonatomic) IBOutlet UITextView *feedInputTextView;

@end

@implementation MutterComposeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewIsTapped:(id)sender {
    [self.feedInputTextView resignFirstResponder];
}

- (IBAction)postFeed:(id)sender {
    if (self.feedInputTextView.text.length > 0) {
        PFObject *newFeed = [PFObject objectWithClassName:@"Story"];
        [newFeed setObject:self.feedInputTextView.text forKey:@"Title"];
        [newFeed saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dude can't be blank" message:nil delegate:self cancelButtonTitle:@"kk" otherButtonTitles: nil];
        [alert show];
    }
    
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
