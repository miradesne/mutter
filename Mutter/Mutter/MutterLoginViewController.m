//
//  ViewController.m
//  Mutter
//
//  Created by Mira Chen on 4/29/15.
//  Copyright (c) 2015 MiraStudio. All rights reserved.
//

#import "MutterLoginViewController.h"

@interface MutterLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameInput;
@property (weak, nonatomic) IBOutlet UITextField *paswordInput;

@end

@implementation MutterLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpKeyboard {
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)]];
}

- (IBAction)login:(id)sender {
    NSString *userName = self.userNameInput.text;
    NSString *password = self.paswordInput.text;
    if (userName.length == 0 || password.length == 0) {
        [self showAlertViewWithTitle:@"Error: Username or password is empty"];
        return;
    }
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:userName];
    PFObject *object = [query getFirstObject];
    
    if (object) {
        NSError *loginError;
        [PFUser logInWithUsername:self.userNameInput.text password:self.paswordInput.text error:&loginError];
        if (loginError) {
            NSLog(@"error for login: %@", loginError);
            [self showAlertViewWithTitle:@"Incorrect password for an existing user"];
        } else {
            [self showAlertViewWithTitle:@"Welcome back!"];
            [self performSegueWithIdentifier:MutterSegueIdLogin sender:self];
        }
    } else {
        NSError *signUpError;
        PFUser *newUser = [PFUser user];
        newUser.username = userName;
        newUser.password = password;
        [newUser signUp:&signUpError];
        if (signUpError) {
            NSLog(@"error for sign up: %@",signUpError);
            [self showAlertViewWithTitle:@"Something went wrong"];
        } else {
            [self showAlertViewWithTitle:@"Welcome to Mutter!"];
            [self performSegueWithIdentifier:MutterSegueIdLogin sender:self];
        }
    }
    
    
}

- (void)resignKeyboard {
    [self.userNameInput resignFirstResponder];
    [self.paswordInput resignFirstResponder];
}

- (void)showAlertViewWithTitle:(NSString*)title {
    [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
