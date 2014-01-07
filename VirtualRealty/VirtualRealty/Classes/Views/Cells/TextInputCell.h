//
//  TextInputCell.h
//  VirtualRealty
//
//  Created by chrisshanley on 9/14/13.
//  Copyright (c) 2013 virtualrealty. All rights reserved.
//

#import "FormCell.h"
#import "CustomField.h"
@interface TextInputCell : FormCell<UITextFieldDelegate>

-(void)inputTextChanged:(id)sender;
-(void)textFieldFinished:(id)sender;
-(void)inputFieldBegan:(id)sender;
@property(nonatomic, strong, readonly)CustomField *inputField;

@end
