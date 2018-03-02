//
//  ViewController.m
//  WagYoTail
//
//  Created by Ben Coffman on 3/01/18.
//  Copyright © 2018 Ben Coffman. All rights reserved.
//

#import "TableViewController.h"

#import "StackOAPI.h"
#import "UserValues.h"
#import "Cell.h"

#import "UIImageView+AFNetworking.h"

@interface TableViewController ()
@property (strong, nonatomic) NSMutableArray *aryUserItems;

-(UIImage *)getStackImage:(NSString *)imageName;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"https://api.stackexchange.com/2.2/users?page=1&pagesize=100&order=desc&sort=reputation&site=stackoverflow"];
    _aryUserItems = [[NSMutableArray alloc] init];
    
    
    [[StackOAPI sharedInstance] getStackPage:url completion:^(id result) {
        //dont' forget to check for null or an empty string
        if (result != NULL || result != nil || result != [NSNull null]){
            NSArray *userDetails = result[@"items"];
            
            for (id object in userDetails){
                UserVals *userDetails = [[UserVals alloc] initWithValue:object[@"display_name"]
                                                               imageURL:object[@"profile_image"]
                                                         goldBadgeCount:object[@"badge_counts"][@"gold"]
                                                       silverBadgeCount:object[@"badge_counts"][@"silver"]
                                                       bronzeBadgeCount:object[@"badge_counts"][@"bronze"]];

                [_aryUserItems addObject:userDetails];
            }
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        //
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _aryUserItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //link up dynamic cell
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCell"];
    
    UserVals *userInfo = [_aryUserItems objectAtIndex:indexPath.item];
    cell.lblUserName.text = userInfo.userName;
    cell.lblGoldBadgeCount.text = [NSString stringWithFormat:@"%@",userInfo.goldBadgeCount];
    cell.lblSilverBadgeCount.text = [NSString stringWithFormat:@"%@",userInfo.silverBadgeCount];
    cell.lblBronzeBadgeCount.text = [NSString stringWithFormat:@"%@",userInfo.bronzeBadgeCount];
    
    if([self getStackImage:userInfo.imageURL]){
        cell.ivImage.image = [self getStackImage:userInfo.imageURL];
    }
    else{
        // AFNetworking automatically stores the image in the cache directory, however, i was unsure if you wanted the code to be explicity saved in a non-temporary direcotry, so I also stored the image in the NSDocuments Directory.  ...I've been told Apple doesn't love this, ...but then again Apples views change with the wind. :)
        
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:userInfo.imageURL]];
        [cell.ivImage setImageWithURLRequest:imageRequest
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
         {
             //saving image to file
             NSData *pngData = UIImagePNGRepresentation(image);
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             NSString *documentsPath = [paths objectAtIndex:0];
             //If this was for prod I would not use the URL as the image name, I would use the image id in the URL path #notclean
             NSString *filePath = [documentsPath stringByAppendingPathComponent:userInfo.imageURL];
             [pngData writeToFile:filePath atomically:YES];
             
             
             [cell.activityIndicator setHidden:YES];
             [cell.activityIndicator stopAnimating];
             cell.ivImage.image = image;
         }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
         {
             [cell.activityIndicator setHidden:YES];
             [cell.activityIndicator stopAnimating];
         }];
    }
    return cell;
}

#pragma mark -- Helper Methods
-(UIImage *)getStackImage:(NSString *)imageName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath;
    imageFilePath = [documentsDirectory stringByAppendingPathComponent:imageName];

    return [UIImage imageWithContentsOfFile: imageFilePath];
}

@end
