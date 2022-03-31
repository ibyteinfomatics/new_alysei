//
//  AppConstant.swift
//  CommonCode
//
//  Created by Nitin Aggarwal on 6/10/17.
//  Copyright © 2017 Nitin Aggarwal. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

typealias ArrayOfDictionary = [[String: Any]] //Array<Dictionary<String,Any>>
typealias NullableArrayOfDictionary = [[String: Any]]?
typealias NullableDictionary = [String: Any]? //Dictionary<String,Any>?
typealias NonNullDictionary = [String: Any] ////Dictionary<String,Any>

//MARK: - Properties -

let kSharedAppDelegate          = UIApplication.shared.delegate as! AppDelegate
let kSharedInstance             = SharedClass.sharedInstance
let kChatharedInstance             = SharedClass.shared_instance
let kSharedUserDefaults         = UserDefaults.standard
let kScreenBounds               = UIScreen.main.bounds
let kScreenWidth                = UIScreen.main.bounds.size.width
let kScreenHeight               = UIScreen.main.bounds.size.height

let APP_THEME_UP = UIColor.init(red: 0/255, green: 168/255, blue: 73/255, alpha: 1)
let APP_THEME_DOWN = UIColor.init(red: 251/255, green: 136/255, blue: 51/255, alpha: 1)
let LOCATION_COLOR = UIColor.init(red: 35/255, green: 187/255, blue: 212/255, alpha: 1)
let APP_BACKGROUND_THEME = UIColor.init(red: 237/255, green: 238/255, blue: 238/255, alpha: 1)
let BUTTON_BACKGROUND_THEME = UIColor.init(red: 226/255, green: 1888/255, blue: 157/255, alpha: 1)
let APP_COLOR = UIColor.init(red: 84.0/255.0, green: 110.0/255.0, blue: 122.0/255.0, alpha: 1.0)

//MARK: GoogleApi Key

//var googleAPIKey = "AIzaSyCHoKV0CQU2zctfEt3-8H-cX2skMbMpmsM"

// MARK: - Structure

struct NumberContants {
    
    static let kMinPasswordLength = 8
}

extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}

struct FunctionsConstants {
    
    static let kSharedUserDefaults = UserDefaults.standard
    static let kShared = SharedClass.sharedInstance
    static let kSharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let kScreenWidth = UIScreen.main.bounds.width
    static let kScreenHeight = UIScreen.main.bounds.height
}

struct UserDetailBasedElements {
    var profilePhoto: String = {
        //return "coverPhoto-\(kSharedUserDefaults.loggedInUserModal.userId ?? "").jpg"
        return "profilePhoto-\(kSharedUserDefaults.loggedInUserModal.userId ?? "").jpg"
    }()
    
    var coverPhoto: String = {
        // return "profilePhoto-\(kSharedUserDefaults.loggedInUserModal.userId ?? "").jpg"
        return "coverPhoto-\(kSharedUserDefaults.loggedInUserModal.userId ?? "").jpg"
    }()
}

struct  AlertMessage{
    
    static var kEnterFirstName : String { return "Please enter first name.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterLastName  : String { return "Please enter last name.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMobileNumber : String { return "Please enter mobile number.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEmailAddress  : String { return "Please enter email address.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kValidEmailAddress  : String { return "Please enter valid email address.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDescription   : String { return "Please enter description.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddress  : String { return "Please enter address.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectCountry  : String { return "Please select country first.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectState  : String { return "Please select state first.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEmailSent : String { return "An recovery email has been sent to your registered email address.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPassword  : String { return "Please enter password.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNewPassword  : String { return "Please enter new password.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kConfirmPassword  : String { return "Please enter confirm password.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPasswordNotEqual : String { return "New password and confirm password does'nt match.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kValidMobileNumber : String { return "Please enter valid number.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterOTP   : String { return "Please enter OTP.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLocationEnabled  : String { return "Location enabled.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLocationNotEnabled : String { return "Location not enabled.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDefaultError : String { return "Something went wrong. Please try again.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoInternet  : String { return "Unable to connect to the Internet. Please try again.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSessionExpired  : String { return "Your session has expired. Please login again.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTurnOnLocation  : String { return "Location not enabled. Please turn on the location.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLocationPopUp  : String { return "We don't have access to location services on your device. Please go to settings and enable location services to use this feature.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLogOutMessage   : String { return "Are you sure you want to logout?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRequiredInformation : String { return "Please fill all the required Information.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTermsAndConditions : String { return "Please agree to Terms&Conditions.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNumberAdded  : String { return "Number Added successfully.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEmailChanged  : String { return "Email added successfully.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOTPSent   : String { return "OTP sent successfully.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOTPSentOnMail : String { return "OTP sent on your mail.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPasswordChanged  : String { return "Password changed successfully.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSourceType  : String { return "Please choose a source type".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTakePhoto  : String { return "Take Photo".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kChooseLibrary  : String { return "Choose From Library".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDeletePhoto : String { return "Delete photo".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRemovePhoto : String { return "Remove photo".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCancel   : String { return "Cancel".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOkay   : String { return "Okay".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnter6DigitOTP : String { return "Enter 6-digit OTP.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFeatureNot  : String { return "This feature is not available.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSignUpFirst  : String { return "To Start Shopping, you have to SignUp First.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLogIn  : String { return "Profile updated successfully.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kProfileUpdated : String { return "Profile updated successfully.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUploadImage  : String { return "Please upload image.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRoleSelection  : String { return "Please choose the role.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kValidPassword : String { return "Your password should contain atleast 8 characters, 1 special character and 1 number.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDeclineMsg : String { return "Please enter reason to decline".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kEnterName : String { return "Please Enter Name.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectCookingSkill : String { return "Please Select Cooking Skill.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectCousin : String { return "Please select Cuisine.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectMeal : String { return "Please select Meal.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectCourse : String { return "Please select Course.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectDiet : String { return "Please select Diet.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectHour: String { return "Please select Preparation Time.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelecForPeople : String { return "Please select for how much people you are cooking.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelecForFoodIntolerance : String { return "Please select Food Intolerance.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectRegion : String { return "Please select Region.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kImagepicker : String { return "This feature is not available.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterIngridientName : String { return "Please enter Ingredient Name.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterToolName : String { return "Please enter Tool Name.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectCategory : String { return "Please select a Category.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterDescription : String { return "Please enter Description.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterTitle : String { return "Please enter Title.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectIngridient : String { return "Please add Ingredient.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectTool : String { return "Please add Tool.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectStep : String { return "Please Add Step".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kselectUnit : String { return "Please select Unit".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kenterQuantity : String { return "Please enter Quantity".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterValidName : String { return "Please enter more than 3 character.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterDescriptionUrl : String { return "Please enter Description or Url.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kPleaseSelectAtleastOneState : String {return "Please select atleast one state".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
  
    
}
struct LabelandTextFieldTitle{
   
    static var selectCookingSkill  : String { return "Select Cooking Skill".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var selectCourse  : String { return "Select Course".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var selectCuisine : String { return "Select Cuisine".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var selectMeal  : String { return "Select Meal".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var selectDiet  : String { return "Select Diet".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var selectRegion  : String { return "Select Region".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var selectFoodIntolerance  : String { return "Select Food Intolerance".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var selectCategory  : String { return "Select a Category".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
}

struct AlertTitle{
    
    static let appName = "Alysei"
    static let notice  = "Notice"
}

struct StoryBoardConstants {
    
    static let kLogin = "Login"
    static let kHome = "Home"
    static let kMain = "Main"
    static let kSplash = "Splash"
    static let kHubs = "Hubs"
    static let kMarketplace = "Marketplace"
    static let kHubSelection = "HubSelection"
    static let kRecipesSelection = "Recipe"
    static let kChat = "Chat"
    static let kUpdateProfile = "UpdateProfile"
    static let kTimeline = "Timeline"
}

struct Notifications {
    
    static let kChatNotificationReceived = "ChatNotificationReceived"
    
}

struct ButtonTitle {
    
    static var  kOk  : String { return "Ok".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kCancel : String { return "Cancel".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kYes :  String { return "Yes".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
}

enum CountryCityHubSelection {
    
    case country
    case city
    case hub
}

struct APIUrl{
    static let kFaq                     = "get/faq"
    static let kSignUp                 =  "register"
    static let kForgotPassword         =  "forgot/password"
    static let kResetPassword          =  "reset/password"
    static let kVerifyOtp              =  "verify/otp"
    static let kResendOtp              =  "resend/otp"
    static let kGetRoles               =  "get/roles"
    static let kGetRegistrationFields  =  "get/registration/fields/"
    static let kGetWalkthroughScreens  =  "get/walkthroughscreens/"
    static let kGetCountries  =  "get/countries?role_id="
    static let kGetStatesByCountryId = "get/states?country_id="
    static let kGetStates  =  "get/states?role_id="
    static let kGetCities  =  "get/cities?role_id="
    static let kRegister  =  "user/register"
    static let kLogin  =  "user/login"
    static let kGetProgress  =  "get/alysei/progress"
    static let kUserSettings  =  "user/settings"
    static let kUpdateUserSettings  =  "update/user/settings"
    static let kGetFeatureListing  =  "get/featured/listing/"
    static let kAddFeaturedProducts  =  "post/featured/listing"
    static let kUserSubmittedFields  =  "get/user/submited/fields"
    static let kUpdateUserProfile  =  "update/user/profile"
    static let kChangePassword = "change/password"
    
    static let getAllEntities = "get/all/entities/for/homescreen/"
    static let kgetHubs = "get/hubs"
    static let kGetCitiesByStateId = "get/cities?state_id="
    static let kGetHubCountries  =  "get/hub/countries"
    static let kGetHubCity = "get/hub/city"
    static let kGetHubState = "get/states"
    static let kPostHub    = "post/hubs"
    static let kGetUpcomingCountries = "get/active/upcoming/countries"
    static let kGetCertificates = "get/user/certificates"
    static let kUploadCertificate = "update/user/certificates"
    static let kGetSelectedHubCountry = "get/selected/hub/countries"
    static let kGetSelectedHubStates = "get/selected/hub/states"
    static let kReviewHub = "review/hubs"
    static let kProfileProgress = "get/profile/progress"
    static let kPost = "add/post"
    static let kWalkthroughScreenStart = "get/walkthroughscreens"
    static let kGetFeed = "get/activity/feed?page="
    static let kNewsStatus = "get/news"
    static let kLikeApi = "post/like"
    static let kCommentLikeApi = "comment/like"
    static let kGetCountryStates = "get/mycountry/states"
    static let kGetAllHubs = "get/all/hubs"
    static let kGetFieldValue = "get/field/value/"
    static let kGetRolesUserCount = "get/roles/by/hubid/"
    static let kGetRoleListFromHubSlctn = "get/usersin/role?"
    static let kGetMarketPlaceWalkthrough = "get/marketplace/walkthrough"
    static let kGetMemberShip = "get/marketplace/packages"
    static let kCreateStore = "save/store"
    static let kProducttCategory = "get/marketplace/product/categories"
    static let kProductConnection = "get/products/for/connection"
    static let kSubProductCategoryId = "get/marketplace/product/subcategories?product_category_id="
    static let kBrandLabel = "get/marketplace/brand/label"
    static let kSaveProduct = "save/product"
    static let kHubSubscribeUnscribe = "subscribe/unsubscribe/hub?hub_id="
    static let kGetStoreFilledValue = "get/store/prefilled/values"
    static let kCheckIfStored = "checkif/store/created"
    static let kMyProductList = "get/myproduct/list"
    static let kDeleteProduct = "delete/product"
    static let kGetStoreDetails = "get/store/details"
    static let kGetDashbordScreen = "get/dashboard/screen"
    static let kUpdateStore = "update/store/details"
    static let kUpdateProductApi = "update/product/details"
    static let kGetCategories = "get/marketplace/product/categories"
    static let kDeleteGalleryPic = "delete/gallery/image"
    static let kGetStateWiseHub = "get/state/wise/hubs?country_id="
    static let kProductRecentSearch = "recent/search/product"
    static let kProductSearch = "search/product/listing?"
    static let kProductListing = "get/search/product/listing?keyword="
    static let kProductKeywordSearch = "search/product?keyword="
    static let kGetProductMarketDetail  = "get/product/detail?marketplace_product_id="
    static let kLikeProductApi = "make/favourite/store/product"
    static let kUnlikeProductApi = "make/unfavourite/store/product"
    
    static let kGetReview = "get/all/reviews?id="
    static let kGetSellerProfile = "get/seller/profile/"
    static let kProductCategory = "get/marketplace/product/categories/all"
    
    static let kSubmitReview = "do/review/store/product"
    static let kUpdateReview = "update/marketplace/rating"
    
    static let kUpdateEvent = "update/event"
    static let kUpdateBlog = "update/blog"
    static let kUpdateTrip = "update/trip"
    
    static let kDeleteEvent = "delete/event?event_id="
    static let kDeleteBlog = "delete/blog?blog_id="
    static let kDeleteTrip = "delete/trip?trip_id="
    
    static let kCreateEvent = "create/event"
    static let kGetIntensity = "get/intensity/list"
    static let kGetAdventure = "get/adventure/types"
    static let kCreateTrip = "create/trip"
    static let kCreateBlog = "create/blog"
    static let kGetEventListing  =  "get/event/listing?visitor_profile_id="
    static let kGetBlogListing  =  "get/blog/listing?visitor_profile_id="
    static let kGetTripListing  =  "get/trip/listing?visitor_profile_id="
    static let kGetNotificationList  =  "get/all/notifications"
    static let kSendNotification  =  "send/message/notification"
    static let kUploadMediaApi = "upload/media"
    static let kConnectionTabApi1 = "get/connection/tabs?tab=1"
    static let kConnectionTabApi = "get/connection/tabs?tab=2"
    static let kConnectionTabApi3 = "get/connection/tabs?tab=3"
    static let kConnectionTabApi4 = "get/connection/tabs?tab=4"
    static let kEditPost = "edit/post"
    static let kPrivacy = "get/user/privacy"
    static let kAwardList = "get/award/listing?visitor_profile_id="
    static let kAwardCreate = "create/award"
    static let kAwardUpdate = "update/award"
    static let kAwardDelete = "delete/award"
    static let kAwardMedal = "get/medal/types"
    static let kGetDiscoverListing  =  "get/circle/detail?type="
    
    static let kDashboard = "view/connection?connection_id="
    
    static let kSavePrivacy = "save/privacy"
    static let kinvitationAcceptReject = "accept/reject/request"
    static let kotherAcceptReject = "accept/reject/connection/request/from/profile?"
    static let kPendingRemove = "cancel/connection/request?visitor_profile_id="
    static let kMarketPlaceProduct = "get/box/detail/"
    static let kBlockList = "get/block/user/list"
    static let kUnBlockUser = "unblock/user"
    static let kMarketPlaceProductBox = "get/products?box="
    static let kMarketPlaceBoxProduct = "get/products?box="
    static let kMarketPlaceRegion = "get/box/detail/3"
    static let kGetProductByRegionId = "get/products/by/region?region_id="
    static let kGetProductByCategoryId = "get/products/by/category?category_id="
    static let kFollowUnfollow = "follow/user"
    static let kMarketplaceBoxFilterApi = "filter?"
    static let kMarketPlaceHome = "get/homescreen"
    static let kPostComment = "post/comment"
    static let kDeleteComment = "delete/post/comment"
    static let kUpdateComment = "post/comment/update"
    static let kPostReplyComment = "reply/post/comment"
    static let kLike = "post/like"
    
    static let kSaveInquiry = "save/product/enquery"
    static let kSaveProfileCover = "update/avatar/cover/image"
    static let kSaveUpdateProfileField = "update/user/field"
    static let kLogout = "logout"
    static let kIsStoreReview = "check/store/status"
    static let kGetNotificationStatusApi = "get/notification/status"
    static let kPostNotifictionEnableDisableApi = "update/notification/status"
    static let clearAllNotification = "delete/notifications"
    
    
    enum FeaturedProduct {
        static let delete = kBASEURL + "delete/featured/listing?featured_listing_id="
        
    }
    
    enum Posts {
        static let comments = kBASEURL + "get/post/comments?post_id="
        static let sharePost = kBASEURL + "share/post"
        static let searchUniversal = "search?search_type=" //kBASEURL + "search?search_type="
        static let deletePost = kBASEURL + "delete/post"
    }
    
    enum Images {
        static let removeProfilePhoto = kBASEURL + "remove/cover/profile/image?image_type=1"
        static let removeCoverPhoto = kBASEURL + "remove/cover/profile/image?image_type=2"
    }
    
    enum Profile {
        static let memberProfile = kBASEURL + "get/member/profile"
        static let userProfile = kBASEURL + "get/profile"
        
        static let fetchContactDetails = kBASEURL + "get/member/contact/tab"
        static let updateContactDetails = kBASEURL + "update/contact/details"
        
        static let fetchAboutDetails = kBASEURL + "get/member/about/tab"
        
        static let photoList = kBASEURL + "get/all/user/post/1"
        static let postList = kBASEURL + "get/all/user/post/0"
        static let onePost = kBASEURL + "get/post/detail?post_id="
        
        static let visiterProfile = kBASEURL + "get/visitor/profile?visitor_profile_id="
    }
    
    enum Connection {
        static let sendRequest = kBASEURL + "send/connection/request"
        static let sendFollowRequest = kBASEURL + "follow/user"
        static let cancelConnectionRequest = kBASEURL + "accept/reject/connection/request/from/profile?visitor_profile_id="
        static let blockConnectionRequest = kBASEURL + "block/user"
        static let kProductTypeCategory = kBASEURL + "get/marketplace/product/categories"
    }
    
    enum ReviewHub{
        static let kReviewHub = kBASEURL + "review/hubs"
    }
    enum B2BModule {
        //static let kKeywordSearch = "search?search_type=3&keyword="
        static let kSearchApi = "search?search_type="
        
        
    }
    enum Discover {
        static let kGetSpecialization = "get/specialization"
        static let kDiscoverEventSearch = "get/stories/byfilter?type=events"
        static let kDiscoverBlogSearch = "get/stories/byfilter?type=blogs"
        static let kDiscoverRestaurantSearch = "get/stories/byfilter?type=restaurants"
        static let kDiscoverTripsSearch = "get/stories/byfilter?type=trips"
        static let kRestaurantTypes = "get/restaurant/types"
        static let kAllHubs = "get/all/hubs"
        static let kInterestedEvent = "like/unlike/event"
        
    }
    enum Recipes {
        static let getrecipeCategory = kBASEURL + "get/recipe/categories"
        static let getrecipeIngridents = kBASEURL + "get/recipe/ingredients"
        static let getrecipeTools = kBASEURL + "get/recipe/tools"
        static let getrecipeRegion = kBASEURL + "get/recipe/regions?cousin_id=1"
        static let getrecipeMeal = kBASEURL + "get/recipe/meals"
        static let getrecipeCources = kBASEURL + "get/recipe/courses"
        static let getMyrecipe = kBASEURL + "get/myrecipes"
        static let createRecipe = kBASEURL + "create/recipe"
        static let getCuisine = kBASEURL + "get/all/cousins"
        static let getCookingSkill = kBASEURL + "get/cooking/skills"
        static let getRecipeDiet = kBASEURL + "get/diet/list"
        static let getFoodIntolerance = kBASEURL + "get/food/intolerance"
        static let addNewIngridient = kBASEURL + "add/ingredients"
        static let saveRecipe = kBASEURL + "create/recipe"
        //        static let draftRecipe = kBASEURL + "save/in/draft/recipe"
        static let draftRecipe = kBASEURL + "save/update/draft/recipe"
        static let getAllReviews = kBASEURL + "get/reviews?recipe_id="
        
        
        static let getMyRecipe = kBASEURL + "get/myrecipes"
        static let getHomeScreen = kBASEURL + "get/home/screen"
        static let getMyFavRecipe = kBASEURL + "my/favourite/recipes"
        static let searchIngridient = kBASEURL + "search/ingredients?keyword="
        static let savePreferences = kBASEURL + "save/preference"
        static let getsavedPreferences = kBASEURL + "get/saved/preferences"
        
        static let getRecipeHomeScreen = kBASEURL + "get/home/screen"
        static let getSearchMeal = kBASEURL + "search/meal?keyword="
        
        static let getChildIngridient = kBASEURL + "get/child/ingredients/"
        static let getFilterRecipe = kBASEURL + "filter/recipe?cook_time="
        static let getFavouriteRecipe = kBASEURL + "get/my/favourite/recipes"
        static let getSearchRecipe = kBASEURL + "search/recipe?keyword="
        static let getRecipeDeatail = kBASEURL + "get/recipe/detail/"
        static let getFavUnfavRecipe = kBASEURL + "favourite/unfavourite/recipe"
        static let doReview = kBASEURL + "do/review"
        static let updateRecipe = kBASEURL + "update/recipe/"
        static let deleteRecipe = kBASEURL + "delete/recipe/"
        static let searchTool = kBASEURL + "search/tools?keyword="
        static let editReview = kBASEURL + "update/review"
    }
}

struct AppConstants {
    static var recipeWalkthrough = false
    static var Company: String {return "Company".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Privacy: String{return "Privacy".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var CapPassword: String{return "Password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Blocking: String {"Blocking".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Membership: String{"Membership".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Billing : String{"Billing".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var YourData : String {"Your Data".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Marketplace : String {"Marketplace".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var TermsAndConditions : String {"Terms and Conditions".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PrivacyPolicy : String {"Privacy Policy".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var FAQ : String {"FAQ".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Logout: String {"Logout".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Events : String {"Events".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Featured: String {"Featured".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var UserSettings: String{"User Settings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EditHub: String{"Edit Hub".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EditProfile: String{"Edit Profile".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Notification: String {"Notification".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EditSettings: String{"Edit Settings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var WhoCanSendYouPrivateMessge : String{"Who can send you a private message ?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var WhoCanViewYourProfile : String{"Who can view your profile ?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var WhoCanConnectWithYou : String{"Who can connect with you ?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EmailPrefrences : String {"Email Prefrences".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Anyone: String {"Anyone".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Followers: String {"Followers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Connections: String {"Connections".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Nobody: String {"Nobody".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var OnlyMe : String{"Only Me".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PrivateMessages : String{"Private Messages".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EmailWhenSomeoneRequestsToFollowMe : String{"Email when someone requests to follow me".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ReceiveWeeklyUpdates : String{"Receive weekly updates".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Save : String {"Save".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PhotoOfLabel: String{"Photo of Label".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var FCESIDCertification : String {"FCE-SID Certification".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PhytosanitaryCertificate : String {"Phytosanitary Certificate".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PackagingOfUSA: String {"Packaging of USA".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var FoodSafetyPlan: String { "Food Safety Plan".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var AnimalHealthOrASLCertificate: String{"Animal Health or ASL Certificate".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var UploadAnImageYourProductLabel: String{"Upload an image your product's label".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var UploadAnImageOfYourFCESIDCertification :String {"Upload an image of your FCE-SID certification".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var UploadAnImagOfYourPhytosanitaryCertificate : String {"Upload an image of your Phytosanitary Certificate".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var UploadAnImageOrPDFOfYourPackagingforUSA: String {"Upload an image or PDF of your packaging for USA".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var UploadAnImageOrPDFOfYourFoodSafetyPlan : String {"Upload an image or PDF of your food safety plan".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var UploadAnImageOrPDFOfYourAnimalHealthOrASLCertificate: String{"Upload an image or PDF of your Animal Health or ASL Certificate".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ProvideYourValueAddedTaxID : String{"Provide your value-added tax ID.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  ProvideYourFoodAndDrugAdministrationIdentification : String{"Provide your Food and Drug Administration identification".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ChangingYourPasswordWillLogYouOffAnyOtherDevices : String {"Changing your password will log you off any other devices.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var UpdatePassword: String{"Update Password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var AccountDataDownload : String {"Account Data Download".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var NothingRequestedYet : String {"Nothing requested yet.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var RequestData : String{"Request Data".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUplaod: String{"Upload".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var isRequired: String{"is required".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddFeaturedProducts: String{"Add Featured Products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var KAddFeaturedMenu : String{"Add Featured Menu".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddFeaturedPackages: String{"Add Featured Packages".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kAddFeatured: String{ "Add Featured".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAllInformationIsRequired : String{"All Information is required".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSpecialization : String {"Specialization".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kBlogTitles : String { "Blog Titles".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPublic: String {"Public".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPrivate: String{"Private".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFree: String{"Free".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPaid: String{"Paid".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kChooseDate: String{"Choose Date".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectEvent : String{"Select Event".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectRegistration : String{"Select Registration".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    
    static var Select  : String { return "select".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Checkbox  : String { return "checkbox".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Radio  : String { return "radio".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Text  : String { return "text".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Password  : String { return "password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Multiselect  : String { return "multiselect".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Map  : String { return "map".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Terms  : String { return "terms".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterYourCity  : String { return "enter_your_city".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Email  : String { return "email".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Enter  : String { return "Enter ".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Other  : String { return "Other".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var File  : String { return "file".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kImageName  : String { return "imageName".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var Settings  : String { return "Settings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Hi  : String { return "Hi ".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var No  : String { return "No".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var CYes  : String { return "Yes".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Yes  : String { return "yes".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterEmail  : String { return "Enter Email".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterPassword  : String { return "Enter Password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var CompanyName  : String { return "Company Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterCompanyName  : String { return "Enter Company Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ProductType  : String { return "Product Type*".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var SelectProductType  : String { return "Select Product Type".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ItalianRegion  : String { return "Italian Region*".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PlaceholderItalianRegion  : String { return "Select a answer".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var URL  : String { return "URL".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Username  : String { return "Username".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var FirstName  : String { return "First Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var LastName  : String { return "Last Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var DisplayName  : String { return "Display Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var Language  : String { return "Language".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterFirstName  : String { return "Enter First Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterLastName  : String { return "Enter Last Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var RestaurantName  : String { return "Restaurant Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterRestaurantName  : String { return "Enter Restaurant Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDescription  : String { return "Description".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    
    static var EnterURL  : String { return "Enter URL".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterUsername  : String { return "Enter Username".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var EnterDisplayName  : String { return "Enter Display Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var SelectLanguage  : String { return "Select Language".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Title  : String { return "Title".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Description  : String { return "Description".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Tags  : String { return "Tags".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var AddTitle  : String { return "Add a title".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Add  : String { return "Add ".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ProceedNext  : String { return "Proceed Next".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Submit  : String { return "Submit".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Incomplete  : String { return "incomplete".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var AddDescription  : String { return "Add some description".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Calander  : String { return "calander".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var SeparateTags  : String { return "Separate tags with commas...".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Horeca  : String { return "Horeca".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PrivateLabel  : String { return "Private Label".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var AlyseiBrand  : String { return "Alysei Brand Label".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var HorecaValue  : String { return "horeca".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PrivateLabelValue  : String { return "privateLabel".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var AlyseiBrandValue  : String { return "alyseiBrandLabel".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var KeywordSearch  : String { return "Keyword Search".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    //static let TopHubs = "Top 10 City Hubs"
    static var  SelectState  : String { return "Select State".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Hubs  : String { return "Hubs".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var SelectRegion  : String { return "Select Region".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var RestaurantType  : String { return "Restaurant Type".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var PickUp  : String { return"Pick up".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Delivery  : String { return "Delivery".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Expertise  : String { return "Expertise".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var SelectCountry  : String { return "Select Country".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Speciality  : String { return "Speciality".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ProductTypeBusiness  : String { return "Product Type".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Producttype  : String { return "Product type".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var SelectUserType  : String { return "Select User Type".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var GetStarted  : String { return "Get Started".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Next  : String { return "Next".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Finish  : String { return "Finish".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var OTPHeading  : String { return "We have sent you a 6 digit verification code(OTP) to ".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var KeyLatitude  : String { return "lattitude".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var KeyLongitude  : String { return"longitude".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEmpty  : String { return "".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterText  : String { return "Enter your text here......".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVATNo  : String { return "VAT No.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    static var kZipCode  : String { return "Zip/Postal Code".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    static var is_subscribed_with_hub  : String { return "is_subscribed_with_hub".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var marketplace_product_id  : String { return "marketplace_product_id".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var profileData  : String { return "profile_data".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kURL  : String { return "URL".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUrl  : String { return "Url".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var leaveComment  : String { return "Leave a comment".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectRestType  : String { return "Select Restaurant".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddFeature  : String { return "Add Featured".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMemberShipProgressPending: String{ return "Your membership progress is pending review. You will be notified once the review of your account has begun.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kYourProfileNotReviewed : String {return "Your profile is not reviewed from admin".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kCompleteProfileStartPosting: String {return "Complete your profile in order to start Posting".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
   
    
    //MARK: Validation field type(check)
    static var kzip_postal_code = "zip_postal_code"
    static var kvatno  = "vat_no"
    static var kpassword = "password"
   
}

struct ProfileCompletion {
    static var HubSelection : String { "Hub Selection".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ProfilePicture  : String { "Profile Picture".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var CoverImage  : String { "Cover Image".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var About  : String { "About".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Featuredlisting  : String { "Featured listing".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var FeaturedProducts  : String { "Featured Products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var FeaturedPackages  : String { "Featured Packages".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var OurProducts  : String { "Our Products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var FeaturedRecipe  : String { "Featured Menu".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var FeaturedBlog  : String { "Featured".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Ourtrips   : String { "Our trips".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var Ourtours   : String { "Our Tours".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var ContactInfo  : String { "Contact Info".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var OurMenu  : String { "Our Menu".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
}

struct PlaceholderImages {
    
    static let MobileNumber = "icon_mobile"
    static let Name = "icon_name"
    static let Password = "icon_lock"
    
    static let ProfileName = "icon_profileName"
    static let ProfileEmail = "icon_profileEmail"
    static let ProfileMobile = "icon_profileMobile"
    static let ProfileAddress = "icon_address"
    
}
struct MarketPlaceConstant{
    static var kSubmitQuery : String { return  "You already submitted a query on this product".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNetworkError : String { "Network Error".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var KEnterSomeMessage : String { "Please enter some message".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kIsProductAvailable : String { "Hi is this product is available?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMarkMessage : String { "Message".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNew : String { "New".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOpened : String { "Opened".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kClosed : String {"Closed".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kYearsAgo : String { "years ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMonthsAgo : String { "months ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWeeksAgo : String { "weeks ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kYesterday : String { "Yesterday".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kHoursAgo : String { "hours ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMinutesAgo : String { "minutes ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSecondsAgo : String { "seconds ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kYearAgo : String { "year ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMonthAgo : String { "month ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWeekAgo : String { "week ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kHourAgo : String { "hour ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMinuteAgo : String { "minute ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSecondAgo : String { "second ago".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoNetwork : String { "no network".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoProducer : String { "No producer found".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSpaceReview : String { " Reviews".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSpacereview : String { " reviews".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSendInquiry : String { "Send Inquiry".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kBlocked : String { "Blocked".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFullName : String { "Full Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEmail : String { "Email".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPhoneNumber : String { "Phone Number".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMessage : String { "Message".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Marketplace Home Screen
    static var kMarketPlace : String {  "MarketPlace".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kRecipe : String {  "Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kPosts : String {  "Posts".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var  kNotifications : String {  "Notifications".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kGotoMyStore : String { return  "Go to my store".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kCreateMyStore : String {  "Create your store".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDiscoverMarketplace : String { return "Discover Marketplace".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
 static var kProducerStore  : String {  "Producer Store".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kConservationMethod : String { "Conservation Method".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kItalianRegion : String {  "Italian Regions".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kCategories : String { "Categories".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kProductProperties : String {  "Product Properties".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kFDACertified : String {  "FDA Certified".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kMyFavourite : String {  "My Favourite".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kMostPospular : String {  "Most Popular".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kPromotions : String { "Promotions".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kRecentlyAddedProject : String {  "Recently Added Products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

static var kViewAll : String {  "View all".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kNewlyAddedStore : String {"Newly Added Stores".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kSearchItalianRegion : String {"Search by Italian Regions".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kTopRatedProduct : String {  "Top Rated Products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kTopFavproduct : String {  "Top Favourite Products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kWhatYouLookingFor : String {  "What are you looking for?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
static var kProduct : String {  "Product".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    //MARK: Marketplace Search Screen
static var kSearchForProductBrands : String { return "Search for product brands & more".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

    //MARK: Marketplace Listing Screen
static var kSort  : String {  "Sort".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kFilter  : String {  "Filter".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    //MARK: Marketplace Filter Screen
static var kNoProductFound  : String {  "No Product found".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   // static let kCategories = "Categories"
static var kProperties  : String {  return "Properties".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   // static let kFDACertified = "FDA Certfied"
static var kITalianRegion  : String {  "Italian Region".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kDistance  : String {  "Distance".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kRatings  : String {  " Ratings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kProducers  : String {  "Producers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kProductName  : String {  "Product Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kClearFilters  : String {  "Clear Filters".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kApplyFilters  : String {  "Apply Filter".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kWithIn5Miles  : String {  "Within 5 Miles".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kWithIn10Miles  : String {  "Within 10 Miles".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kWithIn20Miles  : String {  "Within 20 Miles".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kWithIn40Miles  : String { "Within 40 Miles".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kWithIn100Miles  : String {  "Within 100 Miles".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kMostratedstores  : String { "Most rated stores".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var k5StarStores  : String {  "5 star stores".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kSortByAtoZ  : String {  "Sort by A to Z".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kSortByZtoA  : String {  "Sort by Z to A".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   // static let kFilter = "Filters"
    
    //MARK: Marketplace Membership Screen
static var kSelectYourPackage  : String {  "Select your package".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kComingSoon  : String {  "Coming Soon.....".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kBoostYourListing  : String {  "Boost your listing".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kBoostListingExpandReach  : String {  "Boost your listing to expand you reach and increase buyers engagement".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kSellOnline  : String {  "Sell online".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kSellProducttoBuyers  : String {  "Sell your product online to your buyers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kB2CGrandOpening  : String {  "B2C Grand Opening".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kAlyseiFullOpeneingToMarket  : String {  "Alysei full opening to Market, Buyers and Consumers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kCreateYourOwnModern  : String { "Create your own modern, professional online Store".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kCreateProductListing  : String { "Create your Product listing".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kDisplayProductListing  : String { "Display your unique products listings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kRespondToBuyers  : String {  "Respond to buyers inquiry".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kInteractWithFutureBuyers  : String { "Interact with your future buyers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kFavRatings  : String { "Favorite and Ratings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kBeingAbleToReviewedAndRated  : String { "Being able to be reviewed and rated by buyers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kAlyseiMarketplaceMemebership  : String { "Alysei Marketplace Membership".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
static var kChoosePlanRight  : String { "Choose a plan that is right for you".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    
    //MARK: Marketplace CreateStore Screen
    static var kUpdateStore  : String {   "Update Store".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kStoreName  : String {  "Store Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kStore : String {  "Store".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDescription  : String {  "Description".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCWebsite  : String {  "Website".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kStoreRegion  : String {   "Store Region".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLocation  : String {  "Location".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

    static var kExceedMaximumLimit  : String {  "Exceed Maximum Number Of Selection".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOk  : String {  "Ok".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUploadProfilePicture  : String {  "Please upload profile picture.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUploadCoverPicture  : String {  "Please upload cover picture.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUploadStorePicture  : String {  "Please upload store images.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterValidWebsiteUrl  : String {  "Please enter a valid website url.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterValidWebsiteUrlExample  : String {  "Please enter valid website url, For example: www.website.com".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kChooseSource  : String {  "Please choose a source type".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTakePhoto  : String {  "Take Photo".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kChooseLibrary  : String {  "Choose From Library".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDeletePhoto  : String {  "Delete photo".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRemovePhoto  : String {  "Remove photo".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCancel  : String {  "Cancel".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOkay  : String {  "Okay".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDeniedAlbumPermissioins : String {  "Denied albums permissions granted".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDeniedCameraPermissioins  : String {  "Denied camera permissions granted".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Marketplace Add Product Screen
    static var kYes  : String {  "Yes".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNo  : String {  "No".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNumberOfPieces  : String {  "No. of pieces".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNumberOfbottles  : String { "No. of bottles".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLiters  : String {  "liters".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kKiloGrams  : String {  "kilograms".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUSD  : String {  "USD".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMaximum200Characters  : String {  "Maximum 200 characters".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMaximum50Characters  : String {  "Maximum 50 characters".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProductPrice  : String {  "Product Price".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProductTitle  : String {  "Product Title".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectProductCategory  : String {  "Select Product Category".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kQuantityAvailable  : String {  "Quantity Available".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kBrandLabel  : String {  "Brand Label".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kKeyword  : String {  "Keywords".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kGrams  : String {  "grams".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddProduct  : String {  "Add Product".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMilligram  : String {  "milligrams".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMinimumOrderProductQuantity  : String {  "Minimum Order quantity should be less or equal to quantity Available".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUploadProductImages  : String {  "Please upload product images.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterProductTitle  : String {  "Please enter product title.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterProductDesc  : String {  "Please enter product description.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterProductCategory  : String {  "Please enter category.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterProduvtQunatity  : String {  "Please enter quantity available.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProductMinimumQuantity  : String {  "Please enter minimum order quantity.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProductHandlingInstr  : String {  "Please enter handling instructions.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProductDispatchInstr  : String {  "Please enter dispatch instructions.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterAvailableSample  : String {  "Please enter available for sample.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterProductPrice  : String {  "Please enter valid product price.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kHelpUserToFindProduct  : String {  "Helps user to find product".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProductCureentlyAvalbleToDelivr  : String {  "How many products are you currently available to deliver?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPlanToSellYourProduct  : String {  "Choose how you plan to sell your products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMinimumOrderQunatityToSellProduct  : String {  "Which is the minimum order quantity you are able to accept?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSafehandlingInstructions  : String {  "Provide details about your safe handling instructions".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSpecifinDispatchInstruction  : String {  "Provide details about your specific disptach instructions".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProvideSampleOfProduct  : String {  "Are you able to provide samples of your products upon request?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProductSellingPrice  : String {  "Indicate your product selling price to possible buyers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kYourOwnBrandLabel  : String { "Your own brand label".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Marketplace Rating Review Screen
    static var kSRatings  : String {  " ratings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kReviews  : String {  "reviews".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCapReviews  : String {  "Reviews".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEditReview  : String {  "Edit Review".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddReview  : String {  "Add Review".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLeaveAComment  : String {  "Leave a comment".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPleaseAddRatings  : String {  "Please add ratings.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterSomeReview  : String {  "Please enter some review.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kReviewAddedSuccessfully  : String {  "Review added Successfully!".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAlreadytDoneReview  : String {  "You have already done a review on this product".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kReviewUpdatedSuccessfully  : String {  "Review updated Successfully!".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTapToRate  : String {  "Tap to rate:".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Marketplace First Time Walthrough
    static var kWelcomeToMarketplace  : String{ "Welcome to Marketplace".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFeatureYouExplore  : String { "Features you can explore".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMarketPlaceRules  : String {  "MarketPlace Rules".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCreateYourUniqueStore : String { "Here you can create your unique Store, upload your product portfolio, explore, search and reply to inquiries".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPowerfulMarketplaceEngine  : String {  "The most powerful markeplace engine for the Made in Italy".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kPostiveExperience  : String {  "To ensure a positive experience follow these simple rules".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kExploreSearchProductsFormItalian  : String {  "Here you can explore and search for products from Italian Producers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kExploreSendInquiry  : String {   "Here you can explore and search for products and send inquiry to Italian Producers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
  
        static var kExploreMarketPlace  : String {  "Explore the Markeplace".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kReportSuspiciousBehaviour  : String {  "Report suspicious behaviour".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kSearchByRegionProductCategory  : String {  "Search by Region, Product, Category and much more".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kLetUSKnowSomethingDoesNotFeelright  : String {  "Let us know if something does not feel right".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kReplytoInquiry  : String {  "Reply to inquiry".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
       static var kEnquiryStoreContact : String {  "Fill the form just once to get faster responses. Store will contact you shortly.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kSendAnInquiry  : String {  "Send an inquiry".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kShowcaseProductSimpleClean  : String {  "Showcase you Products Store in a simple, clean and professional way".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kBeingResponsiveBuildTrust  : String {  "Being responsive will help you to build trust with Buyers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

        static var kAskFoeProductSampleRequest  : String {  "Ask for product information, samples request, prices, quantity etc.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kInformationAndDetails  : String { "Information and details".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kPhotoQuality  : String {  "Photo Quality".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   // static let kAllInformationProvideAccurate =  "Make sure all the information you provide are accurate and completed"
        static var kPhotosUploadhighQuality  : String {  "Make sure that all photos that you upload are in high quality".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kBoostListigToExpandReachIncsebuyer  : String {  "You can boost your listing to expand you reach and increase buyers engagement".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kInformationAccurateAndcomplete  : String {   "Make sure all the information you provide are accurate and completed".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kDone  : String {"Done".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Marketplace Create Store Walthrough
    static var kStartPromotingProducts  : String {"Start promoting your products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kConfigureStore  : String { "Configure Your Store".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTipsToHelpPromoteConfidence  : String { "Here is some tips to help you promote with confidence".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kPostInEnglish  : String { "Post in English".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWriteEnglishCreateYourStore  : String {"Write in English language to create your store and list your products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kConnectWithBuyers  : String {"Connect with buyers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCreateListingBuyers  : String {"When you create a listing, buyers will interact with you".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kAddingAccurateHelpBuyers  : String { "Adding relevant and accurate info helps buyers to learn more about what you are selling.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddClearPhotos  : String { "Add clear photos".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPhotosGoodResolutionAndLightning : String {"Photos should have a good resolution and lighting,and should only show what you are listing".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOfferFairPrice  : String {"Offer a fair price".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOfferingFarePriceToCompMarket  : String {"Make sure you are offering prices appropriate to a competitive market like the US".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    ////MARK: Marketplace ProductInfo Screen
    static var kProductInfo  : String {  "Product Info".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kHandlingInstructions  : String {"Handling Instructions".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDispatchInstruction  : String {"Dispatch Instructions".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDotQuantityAvailable  : String {"Quantity Available:".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kBrandLable  : String {  "Brand Label".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMinOrderQuantity  : String {"Min Order Quantity".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSampleAvailable  : String {"Sample Available".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAvailableForSample  : String {"Available for Sample".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCategory  : String {"Category".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPriceRange  : String {"Price Range".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMethod  : String {"Method".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMyProducts  : String {"My Products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Marketplace Dashboard Screen
    static var kTotalProduct  : String {"Total Product".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTotalEnquiry  : String {"Total Enquiry".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTotalCategories  : String {"Total Categories".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTotalReviews  : String {  "Total Review".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kYearly  : String {"Yearly".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMonthly  : String {"Monthly".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWeekly  : String {"Weekly".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kyesterday : String {"Yesterday".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kInquiries  : String {"Inquiries".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDashboard  : String {"Dashboard".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAnalytics  : String {"Analytics".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kToday  : String {"Today".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDeleteProduct  : String {"Are you sure you want to delete this product".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Marketplace Confirm Screen
    static var kThanksForsubmittingInformation  : String {  "Thank you for submitting your information for admin review. We will respond you at earliest.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kBackToMarketplace  : String {"Back to MarketPlace".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

    //MARK: Marketplace Sort Screen
    static var kPopularity  : String {"Popularity".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPriceLowToHigh  : String {"Price -- Low to High".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPriceHighToLow  : String {"Price -- High to Low".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNewestFirst  : String {"Newest First".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Marketplace Store Screen
    static var kItalianFBProducers  : String {"Italian F&B Producers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kItalianFBProducer  : String {"Italian F&B Producer".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kOurGallery  : String { "Our Gallery".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCall  : String {"Call".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddToFav  : String {"Add to Fav".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoImage  : String {"No Image".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRatingAndReviews  : String {"Rating & Reviews".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSeeAll  : String {"See All".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAllProducts  : String {"All Products".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoStoreFound  : String {"No Stores Found".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTryAgain  : String {"Try Again".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
}
struct LogInSignUp{
  
    //MARK: Membership Screen
    static var kSelectCities : String {"Select Cities".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSearchCities : String {"Search Cities".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectedHubs : String {"Selected hubs".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kReview  : String {  "Review".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAccountReviewesApprovOurStaff  : String {  "Your account has been reviewed and approved by our staff".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAlyseiCertification  : String {  "Alysei Certification".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kYouAreeCertifiedAlysei  : String {"Congratulation! You are now a certified Alysei Member.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kRecognition  : String {  "Recognition".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kTop10MostSearched  : String {  "You are within the top 10 most searched Alysei Members".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kQualityMark  : String {  "Quality Mark".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kTop5HighestRatedAlysei  : String { "You are within the top 5 highest rated Alysei Members".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kBecomeACertifiedAlyei  : String {  "Become a Certified Alysei Member to expan your market access".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kCompleteProfileFullyAccess  : String {  "Complete your profile in order to fully access Alysei".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVerifyOTP : String{"Verify OTP".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kResendOtpTitle: String{"Resend OTP".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRequiredInformation : String { "* Required Information".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSearchforyourlocation :String {"Search for your location".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kSelectYourlocation :String {"Select Your location".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kYourlocation :String {"Your location".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var lDidntreceiveOTP : String{"Didn't receive the OTP ? ".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    //MARK: LOGIN SCREEN
        static var kLoginToyourAccount  : String {  "Login to your Account".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kLoginWithEmail  : String {  "LOGIN WITH EMAIL".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kSignUp  : String {  "SIGN UP".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kSigningUpAgreeTerms  : String { "By signig up, you agree to our Terms of Services & Privacy Policy.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
        static var kPassword  : String {  "Password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kLOGIN  : String {  "LOGIN".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kForgetPassword  : String {  "Forget Password?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kDontHaveAccount  : String {  "Don't have an account yet?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kEnterYourRegisteredEmail  : String {  "Enter your registered email to recover your password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kResetPassword  : String {  "Reset Password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNewPassword  : String { "New Password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRConfirmPassword  : String { "Confirm Password".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVerifyPassword  : String {"Password must be at least 8 characters and contain at least one numeric digit and a special character.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kSelectRole  : String {  "Select your role".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kExploreConnectCertifiedImp : String { "Explore, find and connect with certified Importers and Distributors in USA, build up and consolidate your brand, promote your products, reach your consumers.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kUSImporterDistributer  : String {  "US Importers & Distributors".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kExploreFindConnectLocalItalian  : String {  "Explore, find and connect with local italian Producers to strenghten your product portfolio, enanch your competiviness, expand your brand and market access.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kIatalianRestaurants  : String {  "Italian Restaurants in US".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

        static var kStrengthCollaborationWithProducer  : String {  "Strengthen collaboration with Producers, Importers, promote your cusine and special events, bring more clients to the table by exponentially expand your reach.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kChefCookingSchools  : String {  "Chefs, Cooking Schools, and all Italian Food and Beverage specialists will leverage on the Alysei platform to promote their name, brand, offering, events, blogs.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kTavelAgencies  : String {  "Travel Agencies".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kStreghthConnectionWithProducer  : String {  "Strenghten connection with Italian Producers, Importers and Distributors in USA, Voice of Experts, grown your visibility, reach your target customers.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kVoyager  : String {   "Voyagers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kEnjopyMagicWorldOfEndless  : String {  "Enjoy the magic world of our endless cuisine searching for products, restaurants, events, trips to Italy, tasting tours, cooking classes, recipes, blogs and much more.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMembershipTitle: String {"Alysei Membership is important to guarantee professionalism, quality and visibility".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

    //MARK: SELECT LANGUAGE SCREEN, WALKTHROUGH SCREEN

        static var kSelectYourLanguage  : String {  "Select your Language".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kskip  : String {  "Skip".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kgetStarted  : String {  "Get Started".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kBridgeGapBtwmTradition  : String {  "Bridge the gap between tradition and modernity, offering endless opportunities to Italian high quality product maanufactures to grow and expand their business in USA while maintaining their centennial tradition and identity.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kEnjoyMagicWorldOfEndless  : String {  "Alysei is the first B2B and B2C Portal for Italian high-quality products in the Food & Beverage sector, designed and developed on a Collaborative Social Platform entirely directed to a public enthusiastic for the Made in Italy eno-gastronomy.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kCertifiedProducerWillBeAble  : String {  "Alysei certified Producers will be able to search and connect with certified Importers and Distributors in the US, build up and consolidate their brand, promote their products and reach their target customers faster to gain visibility and traction in the USA market.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kAlyseiTargetTheEntirePopulation  : String {  "Alysei targets the entire population with a strong passion to the culture, history and tradition of the Italian cuisine.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kUSerWillJoinAlyseiToEnjoyMagic  : String {   "Users will join Alysei to enjoy the magic world of our endless cuisine searching for products, restaurants, trips to Italy, events and tasting tours, cooking classes, recipes, blogs and many more activities helping to strengthen our great Made in Italy brand in US.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: PRODUCER WALKTHROUGH
  
        static var kSignUpCreateCompleteCompnyPrfl  : String {   "Sign up, create, and complete your Company profile, showcase your feature products, select your Hub in US, promote your Brand.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kAccessB2BPlatform  : String {   "Access to the B2B Platform".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kAcessB2B  : String {   "Access to the B2B Engine to search and connect with Importers, Distributors, Italian Restaurants in US Voice of Experts, Travel Agencies.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kYourOwnMarketplace  : String {   "Your own Marketplace".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kAccessToMarketPlaceCreate  : String {   "Access to the Market Place, create your unique Store, upload your product portfolio, enhance your visibility, expand your reach.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kFromFarmToFork  : String {   "From Farm to Fork".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kFullAccessToAlyseiSocialPlatform  : String {    "Full access to Alysei Social Platform to reach your target customers in US within your Hub, launch target product and event promotion campaigns, strengthen your Brand.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: IMPORTER AND DISTRIBUTER WALKTHROUGH
        static var kAccessToMarketPlaceEXPLORE  : String {   "Access to the Market Place, explore, search for high quality Italian producers by Region, Product, Category and much more, connect and develop business realtionship.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    //MARK: RESTAURANT WALKTHROUGH
        static var kSignUpCreateRestProfile : String { "Sign up, create and complete your Restaurant profile, showcase your menu and feature recipes, select your Hub in US, promote your Restaurant.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
        static var KGainMarketVisibility  : String {  "Gain Market Visibility".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
        static var kAcessToMarketPlaceCollaboratinOpportunities  : String {   "Access to the Market Place, explore, search for high quality Italian producers by Region, Product, Category and much more,  develop business collaboration opportunities through your local Importers and Distributors.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kExpandReach  : String {  "Expand your reach".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: VOICE OF EXPERT WALKTHROUGH
        static var kSignUpVoiceOfExpert  : String {  "Sign up, create and complete your Profile, showcase your feature blogs, books, events, projects, select your Hub in US, promote your Brand and offering.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kEnhanceCollabOpprByLeveraging  : String {  "Enhance your collaboration opportunity by leveraging on the B2B Engine to search and connect with Italian Producers, Importers, Distributors and Italian Restaurants in US, Travel Agencies.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kAccesMarketVoiceOfExpert  : String {  "Access to the Market Place, explore, search for high quality Italian producers by Region, Product, Category and much more, connect develop business collaboration opportunities.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kAccessSocialAlyseiVoiceOfExpert  : String {  "Full access to Alysei Social Platform to promote and strengthen your Brand, blogs, books, events, projects.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: TRAVEL AGENCIES WALKTHROUGH

        static var kSigupTravelAgencies  : String {  "Sign up, create and complete your Company profile, showcase your feature trips, select your Hub in US, promote your offering.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kAccesMarketTravelAgencies  : String {  "Access to the Market Place, explore, search for high quality Italian producers by Region, Product, Category and much more, connect develop business collaboration opportunities.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kAccessSocialAlyseiTRAVELAGENCIES  : String {  "Full access to Alysei Social Platform to define, promote and reach your target market and customer.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: VOYAGERS WALKTHROUGH
        static var kChooseYourHub  : String {  "Choose your HUB in US".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSigupvoyager  : String {  "Sign up, create and complete your profile, access to the Alysei world.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAccessToAlysei  : String {   "Access to Alysei Social".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAccessVoyager  : String {  "Access to Alysei to search for products, restaurants, events, cooking classes, Recipes, trips to Italy, post, share, comments and much more.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kReceipeTool  : String {  "Recipe Tool".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAccessToReceipeTool  : String {  "Access to the Alysei Recipe Tool, search, create, post, share, rate recipes with a click of a mouse.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kBringMoreFriendsAndExpand : String {"Bring more friends an expand your membership and Benefits.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: HUB SELECTION SCREEN
    static var kSelectHubinUSA  : String {  "Select the HUB in USA where you plan to develop your business".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kHubIdentifiesAGeographical  : String {  "The Hub identifies a geographical area developed around a metropolitan district, the nerve center of business, network and development activities".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kIfyouDontWantHubAmongThose  : String {  "If you do not find the Hub among those currently available, indicate the one or ones of your interest by selecting state and city".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    static var kSelectHub : String{ return "Select the HUB in".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUSAWhere: String {return "USA where you".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kplanToDevelop: String {return "plan to develop".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kyourBusiness : String {return "your business".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectHubs : String {return "Select Hubs".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDidntRecognizeHub: String {return "Didn't recognize your hub?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kClickHere: String {return "Click Here".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kwhereyou : String {return " where you ".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    //MARK: SIGN UP SCREEN

        static var kHotelCafeRest  : String {  "Hotel/Restaurant/Café".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    //static let kSellProductOnlineUnderRetailer = "Sell your products under the retailer name"

        static var kProvidePickUpDelivery  : String {  "Provide Pick Up and And/Or Delivery".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kSelectIfYouCanProvidePickupDeleivery  : String {  "Select if you can provide Pick Up and Delivery".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kPickUpDiscountForAlyseiVoyager  : String {  "Pick up Discount for Alysei Voyager".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kSelectDiscountOfferToVoyager  : String {  "Select the discount you want to offer to Voyagers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
        static var kDeliveryDiscountToVoyager  : String {  "Delivery Discount for Alysei Voyager".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectTheDiscountOfferTovoyager : String { return "Select the discount you want to offer to Voyagers".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectthestatesfrom : String {return "Select the states from ".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEdit : String {return "Edit".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEditSelection : String {return "Edit Selection".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRemove: String {return "Remove".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFillTheFormToGetAFasterResponse : String {"Fill the form to get a faster response. The Italian Producer will contact you shortly.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAlyseiMemberShip : String {return "Alysei Membership Progress".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kYourProgress : String{ return "Your Progress".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kGoToProfile: String {return "Go to Profile".localizableString(loc: kSharedUserDefaults.getAppLanguage())
    }
    
}


struct TourGuideConstants{
    
    //MARK: Select your role ————
    static var kSelectRole : String { return "Select the box that identifies you or your company and follow the steps".localizableString(loc: kSharedUserDefaults.getAppLanguage())}

    //MARK: Hub Selection ————
    static var kLogoutProfile : String { return "Logout".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProducerHub : String { return "You are assigned by default to the Chicago Hub. You can select more than one if available.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kProducerClickHere : String { return "Don't you find your Hub and are you looking to add additional locations? Click here".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kImporterdistributorHub : String { return "Select the Hub among those available where you are physically located or where you operate your business".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRestaurentsHub : String { return "Select the Hub among those available where your Restaurant is physically located".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRestaurentClickHere : String { return "Don't you find your Hub? Click here".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: About ————
    static var kProducerImporterDistributor : String { return "Tell us more about your company and its history.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRestaurant : String { return "Tell us more about your restaurant and its history.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTravelAgencies : String { return "Tell us more about your agency and its history.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVoiceofExperts : String { return "Tell us more about yourself and your experience.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVoyagers : String { return "Tell us more about yourself and your interests.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Profile Picture ————
    static var kProducerImpDistPic : String { return "Upload the logo of your company as your profile.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRestaurantPic : String { return "Upload the logo of your restaurant as your profile.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTravelAgenciesPic : String { return "Upload the logo of your agency as your profile.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVoiceofExpertsPic : String { return "Upload a photo of you or your logo as your profile.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVoyagersPic : String { return "Upload a photo of you as your profile.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    //MARK: Cover Picture ————
    
    static var kProducerImpDistCover : String { return "Upload a nice landscape photo of your company as your cover.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRestaurantCover : String { return "Upload a nice landscape photo of your restaurant as your cover.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTravelAgenciesCover : String { return "Upload a nice landscape photo of your agency as your cover.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVoiceofExpertsCover : String { return "Upload a nice landscape photo of your business as your cover.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVoyagersCover : String { return "Upload a nice landscape photo as your cover.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK:  OUR FIELDS (PRODUCTS/MENU/TRIPS) ————
   
    static var kProducerField : String { return "Briefly describe your products with their properties and characteristics.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kImporterDistField : String { return "Briefly describe your product portfolio and offerings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRestaurantField : String { return "Briefly describe your menu and your specials.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTravelAgenciesField : String { return "Briefly describe your trips and your unique proposed adventures.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    //MARK: FEATURED FIELD ————
    
    static var kProducerImpDistFeatured : String { return "List your flagship products with a short description and if you have it, you can link each product to your corresponding product website page.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRestaurantFeatured : String { return "List your flagship recipes and your specials with a short description and link your menu website.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTravelAgenciesFeatured : String { return "List your flagship trips with a short description and if you have it, you can link each trip to your corresponding website page.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kVoiceofExpertsFeatured : String { return "List your books, articles, recipes and more with a short description, and if you have it, you can link each photo corresponding website page.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: B2B TAB ————
    
    static var kForEveryMemberB2B : String { return "Search for Alysei Members through the Hub and create connections.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kForVoyagersB2B  : String { return "Explore the Hubs and follow the Alysei Members of your interest.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: ADD POST ————
    
    static var kForAllPost  : String { return "Add a post.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: MARKETPLACE ————
    
    static var kProdImpDistRestVoiceExprtMarketPlace : String { return "Check Italian Producers stores, their high-quality products and send inquiries.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTravelAgenciesVoygersMarketPlace : String { return "Check Italian Producers stores and their high-quality products.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: Recipe ————
    
    static var kForAllRecipe  : String { return "Explore, search, create, rate, and share the Recipes from the endless Italian cuisine.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: CREATE RECIPE ————
    static var kForCreateRecipe  : String { return "Create your own Italian recipe in a simple and fun way!".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: QUICK SEARCH BY INGREDIENTS ————
    static var kForSearchbyIngedients  : String { return "Explore recipes by ingredients used.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //MARK: TRENDING NOW ————
    static var kForTrendingNow  : String { return "Discover the trending recipes.".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
}

struct RecipeConstants{
    
    //MARK: Home Screen————

    static var kRecipe : String { return "Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCreateRecipe : String { return "Create Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCravingTitle : String { return "What are you craving".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSearchRecipe : String { return "Search Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kExplore : String { return  "Explore".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFavourite : String { return  "Favourite".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMyRecipe : String { return "My Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMyPreference : String { return "My Preferences".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kViewAll : String { return "View All".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kByIngredient : String { return "Quick Search By Ingredients".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kByMeal : String { return "Quick Search By Meal".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSearchMeal : String { return "Search Meal".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kByRegion : String { return "Search By Italian Region".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kTrendingNow : String { return "Trending Now".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kTrending : String { return "Trending".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kQuickEasy : String { return "Quick Easy".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kServingHome : String { return "Serving".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFavCuisine : String { return "Favourite Cuisine".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFoodAlrgy : String { return "Food Alergies".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDiet : String {return  "Diets".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kIngredient : String { return  "Ingredients".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUtensil : String { return  "Utensils".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCkngSkill : String { return "Cooking Skill".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLikes : String { return "Likes".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNA : String {return  "NA".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDraft : String {return  "Draft".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kPublish : String { return "Published".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoRecipe : String { return "No recipe found".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNotLikeRecipe : String { return "You have not liked any recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoMeal : String { return "No Meal Found".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kInternalServerEr : String { return "Internal Server Error".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCookTime : String { return "Cook Time".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoOfIngredient : String { return "No. of Ingredients".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMealType : String {return  "Meal Type".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCuisine : String { return "Cuisines".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMeal : String { return "Meal".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kIngridients : String { return "Ingridients".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kFilter : String { return "Filter".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kClearAll : String { return "Clear All".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kViewResult : String { return "View Results".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSearchItalianRegion : String{ return "Search Italian Region".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    // MARK: Create Recipe Screen————

    //Walkthrough——
    static var kNext : String { return "Next".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDone : String { return "Done".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk1Title : String { return "Create your Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk1Subtitle : String { return "Create your own recipes exploring and sharing the endless world of the Italian cuisine".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk2Title : String { return "Instruction to create a Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk2Subtitle : String { return "Add Ingredients and Tools Used".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk2title1 : String {  "Add clear photos".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk2Subtitle1 : String {  "Photos should have good resolution and lightning".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk2title2 : String {  "Add Ingredients and Kitchen Tools Used".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk2Subtitle2 : String {  "Use accurate amount and unit for ingredients, select the right Kitchen Tools".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk2title3 : String {  "Divide your recipe in steps".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk2Subtitle3 : String {  "You can divide our recipe in steps so that viewers can easily understand the procedure".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk3Title : String {  "Share your Recipe with others".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kWalk3Subtitle : String {  "Once your recipe is created, you can share it so viewers can cook it, like it and rate it".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    //CreateNewRecipe——
    static var kCreateNwRecipe : String {  "Create New Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUploadImg : String {  "Upload Recipe Image".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kClickHere : String {  "Click here to upload recipe photo".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kImages : String {  "Images".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPNG : String {  "PNG, JPG".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kResolution : String {  "Resolution".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUpto : String {  "Upto 600x600".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kName : String {  "Name *".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRecipeName : String {  "Recipe Name".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectCookingSkil : String {  "Select Cooking Skill *".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectCuisine : String {  "Select Cuisine *".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectMeal : String {  "Select Meal *".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectCourse : String {  "Select Course *".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectDiet : String {  "Select Diet".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectFoodIntolerance : String {  "Select Food Intolerance".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPreparationTime : String {  "Preparation Time *".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kHours : String {  "Hours".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMinutes : String {  "Minutes".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kServing : String {  "Serving *".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kForHowMuch : String {  "For how much people you are cooking".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSelectRegion : String {  "Select Region *".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kCancel : String {  "Cancel".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNone : String {  "None".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddIngridient : String {  "Add Ingredients in Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSearchIngredients : String {  "Search Ingredients".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAdd : String {  "Add".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kItems : String {  "Items".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSaveAndProceed : String {  "Save & Proceed".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kQuantity : String {  "Quantity".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUnit : String {  "Unit".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterQuantity : String {  "Enter Quantity".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddtoList : String {  "Add to List".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kKg : String {  "kg".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kLitre : String {  "litre".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPieces : String {  "pieces".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDozen : String {  "dozen".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kgm : String {  "gm".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kMl : String {  "ml".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSpoon : String {  "spoon".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDrops : String {  "drops".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddTools : String {  "Add Tools in Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSearchTools : String {  "Search Appliance, Utensils & Tools".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddStepsRecipe : String {  "Add Steps in Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kStep : String {  "Step".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEnterTitleStep : String {  "Enter Title for Step".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRecipeDirection : String {  "Your recipe direction text here...".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kIngridientUsed : String {  "Ingridients Used in Step".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kToolUsed : String {  "Tools Used in Step".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddStep : String {  "Add Step".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSaveRecipeHeader : String {  "Recipe Ingredients and Tools used".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kUtensils : String {  "Utensils, Appliances & Tools".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kRecipeSteps : String {  "Recipe Steps".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoIngredientAdded : String {  "  No Ingridients Added yet!".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoToolAdded : String {  "  No Tools Added yet!".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoStepAdded : String {  "  No Step Added yet!".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSaveRecipe : String {  "Save Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSave : String {  "Save".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kEditRecipe : String {  "Edit Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoTools : String {  "No Tools found".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kNoIngredient : String {  "No Ingredients found".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDiscardAlert : String {  "Are you sure you want to discard your recipe ?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSaveInDraft : String {  "Save in Draft".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kDiscard : String {  "Discard".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    // MARK: Recipe Preference————
    
    static var kPreference1 : String {  "What is your favourite \n Cuisines?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPreference2 : String {  "Do you have any food \n allergies?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPreference3 : String {  "Do you have follow these \n diets?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kPreference4 : String {  "Don't  want to see \n ingredients?".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kBack : String {  "Back".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSkip : String {  "Skip".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSearchOtherIngredient : String {  "Search Other Ingridients to exclude".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kAddOtherIngredient : String {  "Add other ingredients to exclude".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
   
    
    // MARK: View Recipe ————
    
    static var  kDeleteRecipe: String {  "Delete Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kShareRecipe : String {  "Share Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kCheckout : String {  "Checkout".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kFromAlysei : String {  "from Alysei app".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kReviews : String {  "Reviews".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kFinishCooking : String {  "Finish Cooking".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kRecipeBy : String {  "Recipe by".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kRatingReview : String {  "Rating & Reviews".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kYouMightLike : String {  "You might also like...".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kAddRatingAlert : String {  "Please add ratings".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kLeaveCommentAlert : String {  "Please leave a comment".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kAlreadyReviewAlert : String {  "You have already done a review on this product".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kSeeAll  : String {"See All".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var kViewProfile  : String {"View Profile".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kEditReview : String {  "Edit Review".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kAddReview : String {  "Add Review".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kLeaveComment : String {  "Leave a comment".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kEnterReviewAlert : String {  "Please enter some review".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kReviewAddedMsg : String {  "Review added Successfully!".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kReviewUpdatedMsg : String {  "Review updated Successfully!".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kWriteReview : String {  "Write a Review".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kWellDone : String {  "Well Done !".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kEnjoyRecipeMsg : String {  "Now its time to enjoy the recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kTapToRate : String {  "Tap to rate".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kStartCooking : String {  "Start Cooking".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kIngredientsUsed : String {  "Ingredients Used".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kToolsUsed : String {  "Tools Used".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
    // MARK: Edit Recipe ————
    
    static var  kSaveEditRecipe : String {  "Save Edit Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kEditStep : String {  "Edit Steps in Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kTitle : String {  "Title".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kEnterTitle : String {  "Enter title".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kDescription : String {  "Description".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kChangePhoto : String {  "Change Photo".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kEditIngredient : String {  "Edit Ingredients in Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kEditRecipeIngredient : String {  "Edit Ingredients".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kEditTool : String {  "Edit Tools in Recipe".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kSaveTool : String {  "Save Tools".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    static var  kSaveIngridients : String {  "Save Ingridients".localizableString(loc: kSharedUserDefaults.getAppLanguage())}
    
}

struct APIConstants {
    
    static let kImageName                = "imageName"
    static let kImage                    = "image"
    static let kImages                    = "images"
    static let kToken = "token"
    static let kUserId = "user_id"
    static let kAuthorization = "Authorization"
    static let kData = "data"
    static let kUser = "user"
    static let kSocialId = "social_id"
    static let kEmail  = "email"
    static let kLocale  = "locale"
    static let kOtp  = "otp"
    static let kFirstName = "first_name"
    static let kLastName = "last_name"
    static let kError  = "error"
    static let kisAnonymous  = "is_anonymous"
    static let kUniqueId  = "unique_id"
    static let kLocation  = "location"
    static let kLatitude  = "latitude"
    static let kLongitude = "longitude"
    static let kPhone = "phone"
    static let kUsername = "username"
    static let kPassword = "password"
    static let kConfirmPassword = "confirm_password"
    static let kDisplayName = "display_name"
    static let kFDANumber = "fda_number"
    static let FDANumber = "FDA Number"
    // static let kDisplayName = "company_name"
    static let kCompanyName = "company_name"
    static let kRestaurantName = "restaurant_name"
    static let kWebsite = "website"
    static let kName = "name"
    static let kRoleId = "role_id"
    static let kAvatarId = "avatar_id"
    static let kCoverId = "cover_id"
    static let kAccountEnabled = "account_enabled"
    static let kAttachmentUrl = "attachment_url"
    static let kFields = "fields"
    static let kSlug = "slug"
    static let kRoles = "roles"
    static let kProducts = "products"
    static let kImporterRoles = "importer_roles"
    static let kTitle = "title"
    static let kImageId = "image_id"
    static let kDescription = "description"
    static let kSubtitle = "subtitle"
    static let kHint = "hint"
    static let kRequired = "required"
    static let kType = "type"
    //static let kValue = "value"
    static let kStepOne = "step_1"
    static let kStepTwo = "step_2"
    static let kHead = "head"
    // static let kOption = "ç"
    static let kOptions = "options"
    static let kOption = "option"
    static let kUserFieldId = "user_field_id"
    static let kUserFieldOptionId = "user_field_option_id"
    static let kIsSelected = "is_selected"
    //static let kIsSelectedProduct = "is_selected_product"
    static let kSelectedOption = "selected_option"
    static let kMultipleOption = "multiple_option"
    static let kOptionName = "option_name"
    static let kErrors = "errors"
    static let kOrder = "order"
    static let kParentId = "parentId"
    static let kHidden = "hidden"
    static let kMessage = "message"
    static let kId = "id"
    static let kmarketplaceReviewRatingId  = "marketplace_review_rating_id"
    static let kPhonecode = "phonecode"
    static let kCountryId = "country_id"
    static let kStateId = "state_id"
    static let kCountry = "country"
    static let kState = "state"
    static let kCity = "city"
    static let kFeaturedTypeTitle = "featured_listing_type_title"
    static let kFeaturedListingFieldId = "featured_listing_field_id"
    static let kFeaturedListingTypeId = "featured_listing_type_id"
    static let kFeaturedListingFields = "featured_listing_fields"
    static let kFeaturedListingOptionId = "featured_listing_option_id"
    static let kFeaturedListingId = "featured_listing_id"
    static let kPlaceholder = "placeholder"
    static let kSelectedAddressOne = "selected_address_one"
    static let kSelectedAddressTwo = "selected_address_two"
    static let emoji = "emoji"
    static let userFieldOptionId = "user_field_option_id"
    static let userFieldId = "user_field_id"
    static let fceSidCertification = "fce_sid_certification"
    static let phytosanitaryCertificate = "phytosanitary_certificate"
    static let packagingForUsa = "packaging_for_usa"
    static let foodSafetyPlan = "food_safety_plan"
    static let animalHelathAslCertificate = "animal_helath_asl_certificate"
    static let photoOfLabel = "photo_of_label"
    static let vatNo = "vat_no"
    static let fdaNo = "fda_no"
    static let fdaCertified = "fda_certified"
    static let koldPassword = "old_password"
    static let knewPassword = "new_password"
    static let kStoreRegion = "store_region"
    static let kProducerName = "producer_name"
    static let kmarketplaceStoreId = "marketplace_store_id"
    static let kKeywords = "keywords"
    static let kQuantityAvailable = "quantity_available"
    static let kMinOrderQuantity = "min_order_quantity"
    static let kHandlingInstruction = "handling_instruction"
    static let kDispatchInstruction = "dispatch_instruction"
    static let kAvailableForSample = "available_for_sample"
    static let kProductPrice = "product_price"
    static let kProductCategoryId = "product_category_id"
    static let kProductId = "product_id"
    static let kProductSubCategoryId = "product_subcategory_id"
    static let kbrandLabelId = "brand_label_id"
    static let kMarketPlaceProduct_id = "marketplace_product_id"
    static let kfavourite_type  = "favourite_type"
    static let kRating = "rating"
    static let kReview = "review"
    static let kCousinId = "cousin_id"
    static let kCategory = "category"
    static let kIngridientTitle = "title"
    static let kIngridientImage = "image_id"
    static let kMealId = "meal_id"
    static let kCourseId = "course_id"
    static let kHours = "hours"
    static let kminutes = "minutes"
    static let kServing = "serving"
    static let kRegionId = "region_id"
    static let kDietId = "diet_id"
    static let kIntoleranceId = "intolerance_id"
    static let kCookingSkillId = "cooking_skill_id"
    static let kSavedCategory = "save_categories"
    static let kSavedIngridient = "saved_ingredients"
    static let kSavedTools = "saved_tools"
    static let kIngridientId = "ingredient_id"
    static let kQuantity = "quantity"
    static let kUnit = "unit"
    static let kToolId = "tool_id"
    static let kRecipeStep = "recipe_steps"
    static let kIngridients = "ingredients"
    static let kTools = "tools"
    static let kRecipeReviewRatingId = "recipe_review_rating_id"
}

struct OtherConstant {
    
    static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate?
    //static let kRootVC      = UIApplication.shared.keyWindow?.rootViewController
}

struct StaticArrayData {
    
    static let kInactiveNetworkCategoryDict = [(image: "invitations", name: "Invitations"),
                                               (image: "connections", name: "Connections"),
                                               (image: "pending", name: "Pending"),
                                               kSharedUserDefaults.loggedInUserModal.memberRoleId == "10" ? (image: "following", name: "Following") : (image: "followers", name: "Followers")]
    
    static let kInactiveBusinessCategoryDict = [(image: "hubs", name: "Hubs"),
                                                (image: "importers&distributors", name: "Importers & Distributors"),
                                                (image: "italianrestaurantsinus", name: "Italian Restaurants in US"),
                                                (image: "voiceofexperts", name: "Voice of Experts"),
                                                (image: "travelagencies", name: "Travel Agencies"),
                                                (image: "producers", name: "Producer"),
    ]
    
    static let kTutorialDict = [(image: "Alysei Splash Screen 1", title: "Welcome to Alysei", description: "Connect to social platform Alysei and follow your interests in restaurants,events,wine,food,cooking classes,recipes,blogs and more."),
                                (image: "Alysei Splash Screen 2", title: "Lorem Ipsum", description: "First B2B and B2C portal developed to sell high quality Italian products among targeted US customers effortlessly and faster."),
                                (image: "Alysei Splash Screen 3", title: "Lorem Ipsum", description: "Promote your brand on a collaborative network of certified US-based Producers, Importers, and Distributors."),
                                (image: "Alysei Splash Screen 4", title: "Lorem Ipsum", description: "First B2B and B2C portal developed to sell high quality Italian products among targeted US customers effortlessly and faster."),
                                (image: "Alysei Splash Screen 5", title: "Lorem Ipsum", description: "First B2B and B2C portal developed to sell high quality Italian products among targeted US customers effortlessly and faster.")]
    
    
    static let kSettingScreenDict = [(image: "icons8_settings", name: AppConstants.Settings),
                                     (image: "icons8_business", name: AppConstants.Company),
                                     (image: "icons8_security_lock", name: AppConstants.Privacy),
                                     (image: "passwordSetting", name: AppConstants.CapPassword),
                                     (image: "icons8_unavailable", name: AppConstants.Blocking),
                                     (image: "membership_icon", name: AppConstants.Membership),
                                     (image: "billing_icon", name: AppConstants.Billing),
                                     (image: "yourData", name: AppConstants.YourData)]
    
    static let kSettingPrducrColScreenDict = [(image: "icons8_settings", name: AppConstants.Settings),
                                              (image: "icons8_shop", name: AppConstants.Marketplace),
                                              (image: "icons8_business", name:AppConstants.Company),
                                              (image: "icons8_security_lock", name: AppConstants.Privacy),
                                              (image: "passwordSetting", name: AppConstants.CapPassword),
                                              (image: "icons8_unavailable", name: AppConstants.Blocking),
                                              (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                              (image: "icons8_purchase_order", name: AppConstants.Billing),
                                              (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                              (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                              (image: "Faq", name: AppConstants.FAQ),
                                              (image: "yourData", name: AppConstants.YourData),
                                               (image: "icons8_exit", name: AppConstants.Logout),
    ]
    
    static let kSettingImprtrColScreenDict = [(image: "icons8_settings", name: AppConstants.Settings),
                                              (image: "icons8_shop", name:  AppConstants.Marketplace),
                                              (image: "icons8_security_lock", name: AppConstants.Privacy),
                                              (image: "passwordSetting", name: AppConstants.CapPassword),
                                              (image: "icons8_unavailable", name: AppConstants.Blocking),
                                              (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                              (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                              (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                              (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                              (image: "Faq", name: AppConstants.FAQ),
                                              (image: "icons8_exit", name: AppConstants.Logout),
                                              (image: "yourData", name: AppConstants.YourData)
                                             
                                              
    ]
    
    static let kSettingRestColScreenDict = [(image: "icons8_settings", name: AppConstants.Settings),
                                            (image: "icons8_shop", name:  AppConstants.Marketplace),
                                            (image: "calendar (2)", name: AppConstants.Events),
                                            (image: "icons8_security_lock", name: AppConstants.Privacy),
                                            (image: "passwordSetting", name: AppConstants.CapPassword),
                                            (image: "icons8_unavailable", name: AppConstants.Blocking),
                                            (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                            (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                            (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                            (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                            (image: "Faq", name: AppConstants.FAQ),
                                            (image: "yourData", name: AppConstants.YourData),
                                            (image: "icons8_exit", name: AppConstants.Logout)
                                            
                                            
    ]
    
    static let kSettingVoyaColScreenDict = [(image: "icons8_settings", name: AppConstants.Settings),
                                            
                                            (image: "icons8_security_lock", name: AppConstants.Privacy),
                                            (image: "passwordSetting", name: AppConstants.CapPassword),
                                            (image: "icons8_unavailable", name: AppConstants.Blocking),
                                           // (image: "icons8_debit_card_1", name: "Membership"),
                                            (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                            (image: "icons8_terms_and_conditions", name:AppConstants.TermsAndConditions),
                                            (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                            (image: "Faq", name: AppConstants.FAQ),
                                            
                                            (image: "icons8_exit", name: AppConstants.Logout),
                                            (image: "yourData", name: AppConstants.YourData)
                                            
                                            
                                            
    ]
    
    static let kSettingTravlColScreenDict = [(image: "icons8_settings", name: AppConstants.Settings),
                                             (image: "icons8_shop", name:  AppConstants.Marketplace),
                                             (image: "icons8_security_lock", name: AppConstants.Privacy),
                                             (image: "passwordSetting", name: AppConstants.CapPassword),
                                             (image: "icons8_unavailable", name: AppConstants.Blocking),
                                             (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                             (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                             (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                             (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                             (image: "Faq", name: AppConstants.FAQ),
                                            
                                             (image: "icons8_exit", name:AppConstants.Logout),
                                             (image: "yourData", name: AppConstants.YourData)
                                             
                                             
    ]
    
    static let kSettingExpertColScreenDict = [(image: "icons8_settings", name: AppConstants.Settings),
                                              (image: "icons8_shop", name:  AppConstants.Marketplace),
                                              (image: "Featured", name: AppConstants.Featured),
                                              (image: "icons8_security_lock", name: AppConstants.Privacy),
                                              (image: "passwordSetting", name: AppConstants.CapPassword),
                                              (image: "icons8_unavailable", name: AppConstants.Blocking),
                                              (image: "icons8_debit_card_1", name: AppConstants.Membership),
                                              (image: "icons8_purchase_order", name:  AppConstants.Billing),
                                              (image: "icons8_terms_and_conditions", name: AppConstants.TermsAndConditions),
                                              (image: "icons8_data_protection", name: AppConstants.PrivacyPolicy),
                                              (image: "Faq", name: AppConstants.FAQ),
                                              (image: "yourData", name: AppConstants.YourData),
                                              (image: "icons8_exit", name: AppConstants.Logout)
                                              
    ]
    
    //MARK: EditSettingCollectionView
    static let kEditSettingUserColScreenDict = [
        (image: "editSettingprofile", name: AppConstants.UserSettings),
        (image: "community", name: AppConstants.EditHub)
    ]
    
    static let kEditSettingVoyColScreenDict = [
        (image: "editSettingprofile", name:AppConstants.EditProfile)
    ]
    
    
    
    //MARK: SettingTableView
    
    static let kSettingPrdrTblScreenDict = [
        (image: "billing_icon", name: "Billing"),
        (image: "data_icon", name: "Your Data"),
        (image: "block_icon", name: "Blocking")]
    
    static let kMembershipData = [(image: "Ellipse 22", name: "Review", status: "Your account is being reviewed by our staff."),
                                  (image: "Ellipse 22", name: "Alysei Certification", status: "You have been officially certified by our staff."),
                                  (image: "Ellipse 22", name: "Recognition", status: "Your have been recognized by our app."),
                                  (image: "Ellipse 22", name: "Quality Mark", status: "You will receive an official quality mark on your profile.")]
    
    
    static let kBusinessCategoryDict = [(image: "hubs", name: "Hubs"),
                                        (image: "importers&distributors", name: "Importers & Distributors"),
                                        (image: "italianrestaurantsinus", name: "Italian Restaurants"),
                                        (image: "voiceofexperts", name: "Voice of Experts"),
                                        (image: "travelagencies", name: "Travel Agencies"),
                                        (image: "producers", name: "Italian F&B Producers"),
    ]
    
    static let kNetworkCategoryDict = [(image: "invitations", name: "Invitations"),
                                       (image: "connections", name: "Connections"),
                                       (image: "pending", name: "Pending"),
                                       kSharedUserDefaults.loggedInUserModal.memberRoleId == "10" ? (image: "following", name: "Following") : (image: "followers", name: "Followers")]
    
    //  static let kRoleSelectionDict = [(image: "select_role1", name: "Italian F&B Producers"),
    //                                 (image: "select_role2", name: "US Importers & Distributors"),
    //                                 (image: "select_role3", name: "Italian Restaurants in US"),
    //                                 (image: "select_role4", name: "Voice of Experts"),
    //                                 (image: "select_role5", name: "Travel Agencies"),
    //                                 (image: "select_role6", name: "Voyagers")]
    
    static let kImporterFilter = ["Horeca","Private Label","Alysei Brand Label"]
    
    static let kRestaurantFilter = ["PickUp","Delivery"]
    
    static let kEventArray = ["Adventure","Tech","Family","Wellness","Fitness","Photography","Food & Drink","Writing","Culture"]
    
    static let ArrayProducerProfileCompletionDict = [(name: "HubSelection", status: "Your account is being                                                         reviewed by our staff."),
                                                     (name: "Profile Picture", status: "You have been officially certified by our staff."),
                                                     (name: "Banner (Cover Picture)", status: "Your have been recognized by our app."),
                                                     (name: "About", status: "You will receive an official quality mark on your profile."),
                                                     (name: "Our Products", status: "You will receive an official quality mark on your profile."),
                                                     (name: "Featured Products", status: "You will receive an official quality mark on your profile.")]
    static let kMemberShipArray = [(name: "Create your Store", desc: "Create your own modern, professional online Store", image: "membership_store"),
                                   (name: "Create your Product listing", desc: "Display your unique products listings", image: "membership_productListing"),
                                   (name: "Respond to buyers inquiry", desc: "Interact with your future buyers", image: "membership_respond"),
                                   (name: "Favorite and Ratings", desc: "Being able to be reviewed and rated by buyers", image: "membership_heart")]
    static let kMemberShipCmngSoonArray = [(name: "Boost your listing", desc: "Boost your listing to expand you reach and increase buyers engagement",  image: "membership_boost"),
                                   (name: "Sell online", desc: "Sell your product online to your buyers",  image: "membership_sell"),
                                   (name: "B2C Grand Opening", desc: "Alysei full opening to Market, Buyers and Consumers",  image: "membership_b2b"),
                                   ]

}

struct StaticArrSelectOption {
    
    static let kSelectOptionDict = [(image: "checked_icon_normal", name: "Baby Food"),
                                    (image: "checked_icon_normal", name: "Bakery & Snacks"),
                                    (image: "checked_icon_normal", name: "Baking Mixes"),
                                    (image: "checked_icon_normal", name: "Base Ingredients"),
                                    (image: "checked_icon_normal", name: "Beer"),
                                    (image: "checked_icon_normal", name: "Cereals & Legumes"),
                                    (image: "checked_icon_normal", name: "Cheese"),
                                    (image: "checked_icon_normal", name: "Coffee & Tea"),
                                    (image: "checked_icon_normal", name: "Coffee Beans / Pods / Capsules"),
                                    (image: "checked_icon_normal", name: "Confectionary & Sweets"),
                                    (image: "checked_icon_normal", name: "Condiments"),
                                    (image: "checked_icon_normal", name: "Dairy")]
    
}

struct StaticArrSugnUpSecond {
    
    static let kSSignUpSecondDict = [(lbl: "Horeca*", placeholder: "Yes"),
                                     (lbl: "Private Label*", placeholder: "Select a answer"),
                                     (lbl: "Alysei Brand Label*", placeholder: "Select a answer")]
    
}

struct StaticArrEditProfileFirst{
    
    static let kEditProfileFirstDict = [(lbl: "Private Type*", placeholder: "Baby Food"),
                                        (lbl: "Italian Region*", placeholder: "Abruzzo")]
    
}

struct StaticArrCompanyFirst{
    
    static let kCompanyFirstDict = [(lbl: "VAT", placeholder: "12345678"),
                                    (lbl: "FDA Number", placeholder: "12345678")]
    
}

struct StaticArrCompanySecond{
    
    static let kCompanySecondDict = [(title: "Photo of Label", description: "Upload an image of your product label."),
                                     (title: "FCE-SID certification", description: "Upload an image or PDF of your FCE-SID certification."),
                                     (image: "checked_icon_normal", title: "Phytosanitary Certificate", description: "Upload an image or PDF of your Phytosanitary Certificate ."),
                                     (image: "checked_icon_normal", title: "Packaging for USA", description: "Upload an image or PDF of your packaging for USA."),
                                     (image: "checked_icon_normal", title: "Animal Health or ASL Certificate", description: "Upload an image or PDF of your Animal Health or ASL Certificate.")] as [Any]
}



// MARK: - Enums

enum SignUpCellIndex: Int {
    
    case name
    case email
    case password
}

enum DeviceType:String {
    
    case android = "2", iOS = "1"
    
    
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct MobileDeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0 || UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 320.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0  || UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 375.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0 ||  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 414.0
    static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0 &&  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 375.0
    static let IS_IPHONE_X_MAX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
}


enum MediaType:Int{
    
    case image = 0, video = 1, none = 2
    
    init(rawValue: Int)
    {
        switch rawValue
        {
        case 0: self = .image
        case 1: self = .video
        default: self = .none
            
        }
    }
    
    var CameraMediaType:[String]{
        
        switch rawValue{
        case 0: return [(kUTTypeImage as String)]
        case 1: return [(kUTTypeMovie as String)]
        default: return [(kUTTypeImage as String),(kUTTypeMovie as String)]
            
        }
    }
}

enum NetworkStatusReport:Int {
    
    case success = 200
    case successA = 201
    case successB = 202
    case badRequest = 400
    case badRequestA = 401
    case badRequestB = 409
}

enum PushedFrom: Int {
    
    case forgotPassword
    case signUp
    case login
    case selectHubCities
    case confirmSelection
    case myStoreDashboard
    case addProduct
    case region
    case category
    case conservation
    case fdaCertified
    case properties
    case myFav
    case viewAllEntities
    case hubUserListVC
    
}

enum LoadCell {
    case stateList
    case hubList
    case sharePost
}

//MARK: - UIFont Constants -

enum AppFonts{
    
    case bold(CGFloat),semiBold(CGFloat),regular(CGFloat)
    
    var font:UIFont{
        switch self{
        case .semiBold(let size):
            return UIFont (name: "Montserrat-Semibold", size: size)!
        case .bold(let size):
            return UIFont (name: "Montserrat-Bold", size: size)!
        case .regular(let size):
            return UIFont (name: "Montserrat-Regular", size: size)!
        }
    }
}

func printAllFonts(){
    
    let fontFamilyNames = UIFont.familyNames
    for familyName in fontFamilyNames{
        
        print("------------------------------")
        print("Font Family Name = [\(familyName)]")
        let names = UIFont.fontNames(forFamilyName: familyName )
        print("Font Names = [\(names)]")
    }
}

//MARK: - UIColor Constants -

enum AppColors{
    
    case green,liteGray,gray,blue,lightGray,gradientBlue,gradientGreen,orange ,gradientDarkGreen,grayLight,marigold,black,red,darkBlue,mediumBlue
    
    var color:UIColor{
        
        switch self{
        
        case .red:
            return UIColor.init(red: 243.0/255, green: 76.0/255, blue: 67.0/255, alpha: 1)
        case .orange:
            return UIColor.init(red: 243.0/255, green: 70.0/255, blue: 69.0/255, alpha: 1)
        case .gray:
            return UIColor.init(red: 207.0/255, green: 207.0/255, blue: 207.0/255, alpha: 1)
            
            
        case .green:
            return UIColor.init(red: 60/255, green: 212/255, blue: 114/255, alpha: 1)
        case .liteGray:
            return UIColor.init(red: 141/255, green: 141/255, blue: 141/255, alpha: 0.80)
        case .blue:
            return UIColor.init(red: 75.0/255, green: 179.0/255, blue: 253.0/255, alpha: 1)
        case .darkBlue:
            return UIColor.init(red: 0.0/255, green: 69.0/255, blue: 119.0/255, alpha: 1)
            
        case .mediumBlue:
            return UIColor.init(red: 47.0/255, green: 151.0/255, blue: 193.0/255, alpha: 1)
            
            
            
        case .lightGray:
            return UIColor.init(red: 172.0/255, green: 178.0/255, blue: 196.0/255, alpha: 0.6)
        case .gradientBlue:
            return UIColor.init(red: 6.0/255, green: 171.0/255, blue: 237.0/255, alpha: 1)
        case .gradientGreen:
            return UIColor.init(red: 10.0/255, green: 195.0/255, blue: 162.0/255, alpha: 1)
        case .gradientDarkGreen:
            return UIColor.init(red: 109.0/255, green: 189.0/255, blue: 50.0/255, alpha: 1)
        case .grayLight:
            return UIColor.init(red: 82.0/255, green: 84.0/255, blue: 93.0/255, alpha: 0.5)
            
        case .marigold:
            return UIColor.init(red: 255.0/255, green: 175.0/255, blue: 0.0/255, alpha: 1)
        case .black:
            return UIColor.init(red: 42.0/255, green: 46.0/255, blue: 67.0/255, alpha: 1)
            
        }
    }
}

func print_debug(items: Any){
    print(items)
}

func print_debug_fake(items: Any){
    
}

