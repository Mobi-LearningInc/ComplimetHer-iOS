//
//  MLDetailsViewController.m
//  HappyWife-HappyLife
//
//  Created by MLinc on 2014-06-30.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import "MLDetailsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Social/Social.h>

@interface MLDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *complimentText;

@end

@implementation MLDetailsViewController

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
    // Do any additional setup after loading the view.
    self.complimentText.text = self.compliment;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onReadPressed:(UIButton *)sender {
    AVSpeechUtterance *utterance = [AVSpeechUtterance
                                    speechUtteranceWithString:self.complimentText.text];
    float rate = AVSpeechUtteranceMaximumSpeechRate*0.2;
    NSLog(@"rate = %f\n", rate);
    utterance.rate = rate;//  AVSpeechUtteranceMinimumSpeechRate;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance];
}
- (IBAction)onSMSPressed:(UIButton *)sender {
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    [messageVC setMessageComposeDelegate:self];
    if ([MFMessageComposeViewController canSendText]) {
        
        NSString *smsString = self.complimentText.text;//[NSString stringWithFormat:@"bla bla bla"];
        messageVC.body = smsString;
        //messageVC.recipients = @[userPhone];
        messageVC.messageComposeDelegate = self;
        [self presentViewController:messageVC animated:YES completion:nil];
    }/*else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't send a text message"
                                                        message:@"You cannot send a text message from this device"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }*/
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{

    switch (result) {
        case MessageComposeResultCancelled:
            
            break;
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Error while sending SMS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [warningAlert show];
        }
            break;
        default:
            break;
    }
    
        [self dismissViewControllerAnimated:YES completion:nil];

}


- (IBAction)onTwitterPressed:(UIButton *)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *twitterView = [SLComposeViewController
                                                composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [twitterView setInitialText:self.complimentText.text];
        //[twitterView addImage:self.socialImage];
        [self presentViewController:twitterView animated:YES completion:nil];
    }
    else
    {
        [self showAlert:@"Twitter"];
    }

}
- (IBAction)onFacebookPressed:(UIButton *)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbView = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [fbView setInitialText:self.complimentText.text];
        //[fbView addImage:self.socialImage];
        [self presentViewController:fbView animated:YES completion:nil];
    }
    else
    {
        [self showAlert:@"Facebook"];
    }
}
- (IBAction)onEmailPressed:(UIButton *)sender {
    
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController* mailView = [[MFMailComposeViewController alloc] init];
        if (mailView)
        {
            mailView.mailComposeDelegate=self;
            NSString* subject = [NSString stringWithFormat:@"Compliment of the Day for You!"];
            [mailView setSubject:subject];
            
            [mailView setMessageBody:self.complimentText.text isHTML:NO];
            //NSData *data = UIImagePNGRepresentation(self.socialImage);
            //NSString * attachmentName = [NSString stringWithFormat:@"img.png"];
           // [mailView addAttachmentData:data mimeType:@"image/png" fileName:attachmentName];
            [self presentViewController:mailView animated:YES completion:nil];
        }
    }
    else
    {
        [self showAlert:@"Email"];
    }

}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
#ifdef DEBUG
    if (result == MFMailComposeResultSent) {
        NSLog(@"Email sent");
    }
#endif
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showAlert:(NSString*)serviceName
{
    NSString* title = [NSString stringWithFormat:@"No %@ account on your device.",serviceName];
    NSString* msg =[NSString stringWithFormat:@"To share you must sign into your %@ account from your device settings page.",serviceName];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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

@end
