//
//  ChangeUserPictureViewController.m
//  Viewtext
//
//  Created by HuangChao on 14/10/23.
//  Copyright (c) 2014年 Clemson. All rights reserved.
//

#import "ChangeUserPictureViewController.h"
#import "ConvenientTools.h"
#import "GetMethodsConnect.h"
@interface ChangeUserPictureViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userCurrentPicture;
@property (weak, nonatomic) IBOutlet UIImageView *userNewPicture;
@property (nonatomic, strong) UIImage* saveImage;

@end

@implementation ChangeUserPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userCurrentPicture.image = [ConvenientTools getUserProFileByUserIDFromGlobalDatabase:self.currentUserID];

    // Do any additional setup after loading the view.
    
}

- (void)pickImageFromAlbum
{
    /*
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    */
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    

}


// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    self.saveImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    //NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    [picker dismissViewControllerAnimated:YES completion:^{}];
    self.userNewPicture.image = self.saveImage;
    //NSLog(@"%@",path);
}


- (IBAction)SearchNewPicFromLocal:(id)sender {
    [self pickImageFromAlbum];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


-(void)uploadImage
{
    /*
     turning the image into a NSData object
     getting the image back out of the UIImageView
     setting the quality to 90
     */
    UIImage *newImage = [self imageWithImage:self.saveImage scaledToSize:CGSizeMake(64, 64)];

    
    NSData *imageData = UIImagePNGRepresentation(newImage);
    // setting up the URL to post to
    NSString *urlString = @"http://people.cs.clemson.edu/~chaoh/ios/uploadPicture.php";
    
    // setting up the request object now
    /*
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:urlString ]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"hello.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", @"application/octet-stream"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",returnString);
    */
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"userfile\"; filename=\"%d.png\"\r\n",self.currentUserID] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",returnString);
    
    
    NSString *basic_URL = [NSString stringWithFormat:@"http://people.cs.clemson.edu/~chaoh/ios/updateUserInfoByID.php?userID=%d&changeItem=userProfile&changeContent=%@",self.currentUserID,[NSString stringWithFormat:@"%d.png",self.currentUserID]];
    
    NSData *resultData = [GetMethodsConnect getContentFromPhp:basic_URL];
    
    NSString *changeProfileString = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    if([changeProfileString isEqualToString:@"yes"]){
        //[self.delegate editingInfoWasFinished];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"successful");
    }
    else{
        NSLog(@"fail");
    }
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}





- (IBAction)changeUserPictureBt:(id)sender {
    [self uploadImage];
}





@end
