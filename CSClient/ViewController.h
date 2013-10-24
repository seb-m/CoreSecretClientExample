//
//  ViewController.h
//  CSClient
//
//  Created by Sébastien Martini on 21/08/13.
//  Copyright (c) 2013 Dbzteam.org. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *descriptionField;
@property (nonatomic, strong) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) IBOutlet UIButton *encryptDecryptButton;
@property (nonatomic, strong) IBOutlet UISwitch *storeSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *callbacksSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *sendAsFileSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *addPasswordSwitch;
@property (nonatomic, assign) BOOL store;
@property (nonatomic, assign) BOOL callbacks;
@property (nonatomic, assign) BOOL sendAsFile;
@property (nonatomic, assign) BOOL addPassword;
@property (nonatomic, assign) BOOL encrypt;

@end
