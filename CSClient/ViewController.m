//
//  ViewController.m
//  CSClient
//
//  Created by Sébastien Martini on 21/08/13.
//  Copyright (c) 2013 Dbzteam.org. All rights reserved.
//

#import "ViewController.h"

#import "IACClient.h"


@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@end


@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.store = NO;
  self.callbacks = YES;
  self.sendAsFile = NO;
  self.addPassword = NO;
  self.encrypt = YES;
}

- (IBAction)encryptDecryptButtonAction:(id)sender {
  if (self.encrypt) {
    IACClient *client = [IACClient clientWithURLScheme:@"coresecret"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if ([self.descriptionField.text length] > 0)
      parameters[@"description"] = self.descriptionField.text;
    if (!self.sendAsFile) {
      parameters[@"plaintext"] = self.contentTextView.text;
    } else {
      parameters[@"filename"] = @"file.txt";
      parameters[@"plaintext"] = [[self.contentTextView.text dataUsingEncoding:NSUTF8StringEncoding]
                                  base64EncodedStringWithOptions:0];
    }
    if (self.store)
      parameters[@"store"] = @"1";
    if (self.addPassword) {
      parameters[@"addPassword"] = @"1";
      // Default value
      //parameters[@"scryptN"] = @"32768";
    }

    if (self.callbacks) {
      [client performAction:@"encrypt"
                 parameters:parameters
                  onSuccess:^(NSDictionary *resultParams){
                    [self setEncryptedString:resultParams[@"encryptedData"]];
                  }
                  onFailure:^(NSError *error){
                    NSLog(@"ERROR: %@", [error localizedDescription]);
                  }];
    } else {
      [client performAction:@"encrypt"
                 parameters:parameters];
    }
  } else {
    IACClient *client = [IACClient clientWithURLScheme:@"coresecret"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"encryptedData"] = self.contentTextView.text;
    if (self.store)
      parameters[@"store"] = @"1";

    if (self.callbacks) {
      [client performAction:@"decrypt"
                 parameters:parameters
                  onSuccess:^(NSDictionary *resultParams){
                    if (resultParams[@"filename"]) {
                      NSString *pt = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:resultParams[@"plaintext"]
                                                                                                        options:0]
                                                           encoding:NSUTF8StringEncoding];
                      [self setPlaintextString:pt description:resultParams[@"description"]];
                    } else {
                      [self setPlaintextString:resultParams[@"plaintext"] description:resultParams[@"description"]];
                    }
                  }
                  onFailure:^(NSError *error){
                    NSLog(@"ERROR: %@", [error localizedDescription]);
                  }];
    } else {
      [client performAction:@"decrypt"
                 parameters:parameters];
    }
  }
}

- (IBAction)storeSwitchAction:(id)sender {
  self.store = [(UISwitch *)sender isOn];
}

- (IBAction)callbacksSwitchAction:(id)sender {
  self.callbacks = [(UISwitch *)sender isOn];
}

- (IBAction)sendAsFileSwitchAction:(id)sender {
  self.sendAsFile = [(UISwitch *)sender isOn];
}

- (IBAction)addPasswordSwitchAction:(id)sender {
  self.addPassword = [(UISwitch *)sender isOn];
}

- (void)setEncryptedString:(NSString *)encryptedString {
  self.encryptDecryptButton.titleLabel.text = @"Decrypt";
  self.encrypt = NO;
  self.descriptionField.text = @"N/A";
  self.contentTextView.text = encryptedString;
}

- (void)setPlaintextString:(NSString *)plaintextString description:(NSString *)descriptionString {
  self.encryptDecryptButton.titleLabel.text = @"Encrypt";
  self.encrypt = YES;
  self.descriptionField.text = descriptionString;
  self.contentTextView.text = plaintextString;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
}


#pragma mark - UITextViewDelegate methods

- (void)textViewDidEndEditing:(UITextView *)textView {
}

@end
