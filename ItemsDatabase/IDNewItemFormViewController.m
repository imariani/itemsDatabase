//
//  IDNewItemFormViewController.m
//  ItemsDatabase
//
//  Created by ignacio mariani on 30/6/17.
//  Copyright © 2017 ignacio mariani. All rights reserved.
//

#import "IDNewItemFormViewController.h"
#import "IDItem.h"
#import "IDSavingManager.h"
#import "IDItemSavedViewController.h"


@interface IDNewItemFormViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, SaveItemDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tituloTextView;
@property (weak, nonatomic) IBOutlet UITextField *subtituloTextView;
@property (weak, nonatomic) IBOutlet UITextField *precioTextView;
@property (weak, nonatomic) IBOutlet UITextField *descripcionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imagenThumbnail;

@end

@implementation IDNewItemFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.descripcionTextView.delegate = self;
    [[IDSavingManager sharedInstance] setNewDelegate:self];
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(hideKeyboard:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)verLogPressed:(id)sender
{
    [[IDSavingManager sharedInstance] showItemsSaved];
}

- (IBAction)elegirImagenPressed:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (IBAction)guardarPressed:(id)sender
{
    IDItem *item = [[IDItem alloc] initWithTitle:self.tituloTextView.text
                                    withSubTitle:self.subtituloTextView.text
                                       withPrice:[self.precioTextView.text floatValue]
                                 withDescription:self.descripcionTextView.text
                                        andImage:self.imagenThumbnail.image];
    
    [[IDSavingManager sharedInstance] saveItem:item];
    
    
    NSLog(@"Item created: %@", item);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.imagenThumbnail.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)hideKeyboard:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)clearScreen
{
    self.tituloTextView.text = @"";
    self.subtituloTextView.text = @"";
    self.precioTextView.text = @"";
    self.descripcionTextView.text = @"";
    self.imagenThumbnail.image = nil;
}

- (void)notifyItemSavedSuccessfully
{
    [self clearScreen];
    
    IDItemSavedViewController *viewController = [[IDItemSavedViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
