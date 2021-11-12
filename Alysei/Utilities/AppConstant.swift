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
    
    static let kEnterFirstName          = "Please enter first name."
    static let kEnterLastName          = "Please enter last name."
    static let kMobileNumber            = "Please enter mobile number."
    static let kEmailAddress            = "Please enter email address."
    static let kValidEmailAddress       = "Please enter valid email address."
    static let kDescription             = "Please enter description."
    static let kAddress                 = "Please enter address."
    static let kSelectCountry           = "Please select country first."
    static let kSelectState             = "Please select state first."
    static let kEmailSent               = "An recovery email has been sent to your registered email address."
    static let kPassword                = "Please enter password."
    static let kNewPassword             = "Please enter new password."
    static let kConfirmPassword         = "Please enter confirm password."
    static let kPasswordNotEqual        = "New password and confirm password does'nt match."
    static let kValidMobileNumber       = "Please enter valid number."
    static let kEnterOTP                = "Please enter OTP."
    static let kLocationEnabled         = "Location enabled."
    static let kLocationNotEnabled      = "Location not enabled."
    static let kDefaultError            = "Something went wrong. Please try again."
    static let kNoInternet              = "Unable to connect to the Internet. Please try again."
    static let kSessionExpired          = "Your session has expired. Please login again."
    static let kTurnOnLocation          = "Location not enabled. Please turn on the location."
    static let kLocationPopUp      = "We don't have access to location services on your device. Please go to settings and enable location services to use this feature."
    static let kLogOutMessage           = "Are you sure you want to logout?"
    static let kRequiredInformation     = "Please fill all the required Information."
    static let kTermsAndConditions     = "Please agree to Terms&Conditions."
    static let kNumberAdded             = "Number Added successfully."
    static let kEmailChanged            = "Email added successfully."
    static let kOTPSent                 = "OTP sent successfully."
    static let kOTPSentOnMail           = "OTP sent on your mail."
    static let kPasswordChanged         = "Password changed successfully."
    static let kSourceType              = "Please choose a source type"
    static let kTakePhoto               = "Take Photo"
    static let kChooseLibrary           = "Choose From Library"
    static let kDeletePhoto             = "Delete photo"
    static let kRemovePhoto             = "Remove photo"
    static let kCancel                  = "Cancel"
    static let kOkay                    = "Okay"
    static let kEnter6DigitOTP          = "Enter 6-digit OTP."
    static let kFeatureNot              = "This feature is not available."
    static let kSignUpFirst              = "To Start Shopping, you have to SignUp First."
    static let kLogIn                   = "Logged in successfully."
    
    static let kProfileUpdated          = "Profile updated successfully."
    static let kUploadImage          = "Please upload image."
    static let kRoleSelection          = "Please choose the role."
    static let kValidPassword          = "Your password should contain atleast 8 characters, 1 special character and 1 number."
    static let kEnterName = "Please Enter Name."
    static let kSelectCookingSkill = "Please Select Cooking Skill."
    static let kSelectCousin = "Please select Cuisine."
    static let kSelectMeal = "Please select Meal."
    static let kSelectCourse = "Please select Course."
    static let kSelectDiet = "Please select Diet."
    static let kSelectHour = "Please select Preparation Time."
    static let kSelecForPeople = "Please select for how much people you are cooking."
    static let kSelecForFoodIntolerance = "Please select Food Intolerance."
    static let kSelectRegion = "Please select Region."
    static let kImagepicker = "This feature is not available."
    static let kEnterIngridientName = "Please enter Ingridient Name."
    static let kEnterToolName = "Please enter Tool Name."
    static let kSelectCategory = "Please select a Category."
    static let kEnterDescription = "Please enter Description."
    static let kEnterTitle = "Please enter Title."
    static let kSelectIngridient = "Please add Ingridient."
    static let kSelectTool = "Please add Tool."
    static let kselectUnit = "Please select Unit"
    static let kenterQuantity = "Please enter Quantity"
    static let kEnterValidName = "Please enter more than 3 character."
    static let kEnterDescriptionUrl = "Please enter Description or Url."

}
struct LabelandTextFieldTitle{
    static let recipeName = "Recipe Name"
    static let selectCookingSkill = "Select Cooking Skill"
    static let selectCourse = "Select Course"
    static let selectCuisine = "Select Cuisine"
    static let selectMeal = "Select Meal"
    static let selectDiet = "Select Diet"
    static let selectRegion = "Select Region"
    static let selectFoodIntolerance = "Select Food Intolerance"
    static let selectCategory = "Select a Category"
    
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
}

struct Notifications {
    
    static let kChatNotificationReceived = "ChatNotificationReceived"
    
}
struct ButtonTitle {
    
    static let  kOk     = "Ok"
    static let  kCancel = "Cancel"
    static let  kYes = "Yes"
}

enum CountryCityHubSelection {
    
    case country
    case city
    case hub
}

struct APIUrl{
    
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
    static let kLikeApi = "post/like"
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
    static let kAwardList = "get/award/listing/"
    static let kAwardCreate = "create/award"
    static let kAwardUpdate = "update/award"
    static let kAwardDelete = "delete/award"
    static let kAwardMedal = "get/medal/types"
    static let kGetDiscoverListing  =  "get/circle/detail?type="
    
    static let kDashboard = "view/connection?connection_id="
    
    static let kSavePrivacy = "save/privacy"
    static let kinvitationAcceptReject = "accept/reject/request"
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
    static let kPostReplyComment = "reply/post/comment"
    static let kLike = "post/like"
   
    static let kSaveInquiry = "save/product/enquery"
    static let kSaveProfileCover = "update/avatar/cover/image"
    static let kSaveUpdateProfileField = "update/user/field"
    
    enum FeaturedProduct {
        static let delete = kBASEURL + "delete/featured/listing?featured_listing_id="
        
    }

    enum Posts {
        static let comments = kBASEURL + "get/post/comments?post_id="
        static let sharePost = kBASEURL + "share/post"
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
        static let cancelConnectionRequest = kBASEURL + "cancel/connection/request?visitor_profile_id="
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
        static let kDiscoverTripsSearch = "get/stories/byfilter?type=trips"
        static let kRestaurantTypes = "get/restaurant/types"
        static let kAllHubs = "get/all/hubs"
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
        
    }
}

struct AppConstants {
    static var recipeWalkthrough = false
    static let Select = "select"
    static let Checkbox = "checkbox"
    static let Radio = "radio"
    static let Text = "text"
    static let Password = "password"
    static let Multiselect = "multiselect"
    static let Map = "map"
    static let Terms = "terms"
    static let EnterYourCity = "enter_your_city"
    static let Email = "email"
    static let Enter = "Enter "
    static let Other = "Other"
    static let File = "file"
    static let kImageName = "imageName"
    
    static let Settings = "Settings"
    static let Hi = "Hi "
    static let No = "No"
    static let Yes = "yes"
    static let EnterEmail = "Enter Email"
    static let EnterPassword = "Enter Password"
    static let CompanyName = "Company Name"
    static let EnterCompanyName = "Enter Company Name"
    static let ProductType = "Product Type*"
    static let SelectProductType = "Select Product Type"
    static let ItalianRegion = "Italian Region*"
    static let PlaceholderItalianRegion = "Select a answer"
    static let URL = "URL"
    static let Username = "Username"
    static let FirstName = "First Name"
    static let LastName = "Last Name"
    static let DisplayName = "Display Name"
    //static let DisplayName = "Company Name"

    static let Language = "Language"
    static let EnterFirstName = "Enter First Name"
    static let EnterLastName = "Enter Last Name"

    static let RestaurantName = "Restaurant Name"
    static let EnterRestaurantName = "Enter Restaurant Name"



    static let EnterURL = "Enter URL"
    static let EnterUsername = "Enter Username"
    static let EnterDisplayName = "Enter Display Name"
    static let SelectLanguage = "Select Language"
    static let Title = "Title"
    static let Description = "Description"
    static let Tags = "Tags"
    static let AddTitle = "Add a title"
    static let Add = "Add "
    static let ProceedNext = "Proceed Next"
    static let Submit = "Submit"
    static let Incomplete = "incomplete"
    static let AddDescription = "Add some description"
    static let Calander = "calander"
    static let SeparateTags = "Separate tags with commas..."
    static let Horeca = "Horeca"
    static let PrivateLabel = "Private Label"
    static let AlyseiBrand = "Alysei Brand Label"
    static let HorecaValue = "horeca"
    static let PrivateLabelValue = "privateLabel"
    static let AlyseiBrandValue = "alyseiBrandLabel"
    static let KeywordSearch = "Keyword Search"
    //static let TopHubs = "Top 10 City Hubs"
    static let SelectState = "Select State"
    static let Hubs = "Hubs"
    static let SelectRegion = "Select Region"
    static let RestaurantType = "Restaurant Type"
    static let PickUp = "Pick up"
    static let Delivery = "Delivery"
    static let Expertise = "Expertise"
    static let SelectCountry = "Select Country"
    static let Speciality = "Speciality"
    static let ProductTypeBusiness = "Product Type"
    static let Producttype = "Product type"
    static let SelectUserType = "Select User Type"
    static let GetStarted = "Get Started"
    static let Next = "Next"
    static let Finish = "Finish"
    static let OTPHeading = "We have sent you a 6 digit verification code(OTP) to "
    
    static let KeyLatitude = "lattitude"
    static let KeyLongitude = "longitude"
    static let kEmpty = ""
    static let kEnterText = "Enter your text here......"
    static let kVATNo = "VAT No."
    static let kZipCode = "Zip/Postal Code"
    static let is_subscribed_with_hub = "is_subscribed_with_hub"
    static let marketplace_product_id = "marketplace_product_id"
    static let profileData = "profile_data"
    static let kURL = "URL"
    static let kUrl = "Url"
    static let leaveComment = "Leave a comment"
    static let kSelectRestType = "Select Restaurant"
}

struct ProfileCompletion {
    static let HubSelection = "Hub Selection"
    static let ProfilePicture = "Profile Picture"
    static let CoverImage = "Cover Image"
    static let About = "About"
    static let Featuredlisting = "Featured listing"
    static let FeaturedProducts = "Featured Products"
    static let FeaturedPackages = "Featured Packages"
    static let OurProducts = "Our Products"
    static let FeaturedRecipe = "Featured Menu"
    static let FeaturedBlog = "Featured"
    static let Ourtrips  = "Our trips"
    static let ContactInfo = "Contact Info"
    static let OurMenu = "Our Menu"
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
}

struct OtherConstant {
    
    static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate?
    //static let kRootVC      = UIApplication.shared.keyWindow?.rootViewController
}

struct StaticArrayData {
    
    static let kTutorialDict = [(image: "Alysei Splash Screen 1", title: "Welcome to Alysei", description: "Connect to social platform Alysei and follow your interests in restaurants,events,wine,food,cooking classes,recipes,blogs and more."),
                                (image: "Alysei Splash Screen 2", title: "Lorem Ipsum", description: "First B2B and B2C portal developed to sell high quality Italian products among targeted US customers effortlessly and faster."),
                                (image: "Alysei Splash Screen 3", title: "Lorem Ipsum", description: "Promote your brand on a collaborative network of certified US-based Producers, Importers, and Distributors."),
                                (image: "Alysei Splash Screen 4", title: "Lorem Ipsum", description: "First B2B and B2C portal developed to sell high quality Italian products among targeted US customers effortlessly and faster."),
                                (image: "Alysei Splash Screen 5", title: "Lorem Ipsum", description: "First B2B and B2C portal developed to sell high quality Italian products among targeted US customers effortlessly and faster.")]
    
    static let kSettingScreenDict = [(image: "icons8_settings", name: "Settings"),
                                     (image: "icons8_business", name: "Company"),
                                     (image: "icons8_security_lock", name: "Privacy"),
                                     (image: "icons8_privacy", name: "Password"),
                                     (image: "icons8_unavailable", name: "Blocking"),
                                     (image: "membership_icon", name: "Membership"),
                                     (image: "billing_icon", name: "Billing"),
                                     (image: "icons8_secure_cloud", name: "Your Data")]
    
    static let kSettingPrducrColScreenDict = [(image: "icons8_settings", name: "Settings"),
                                              (image: "icons8_shop", name: "Marketplace"),
                                              (image: "icons8_business", name: "Company"),
                                              (image: "icons8_security_lock", name: "Privacy"),
                                              (image: "icons8_privacy", name: "Password"),
                                              (image: "icons8_unavailable", name: "Blocking"),
                                              (image: "icons8_debit_card_1", name: "Membership"),
                                              (image: "icons8_purchase_order", name: "Billing"),
                                              (image: "icons8_exit", name: "Logout"),
                                              (image: "icons8_secure_cloud", name: "Your Data")
                                              ]
    
    static let kSettingImprtrColScreenDict = [
                                              (image: "icons8_settings", name: "Settings"),
                                              (image: "icons8_shop", name: "Marketplace"),
                                              (image: "icons8_security_lock", name: "Privacy"),
                                              (image: "icons8_privacy", name: "Password"),
                                              (image: "icons8_unavailable", name: "Blocking"),
                                              (image: "icons8_debit_card_1", name: "Membership"),
                                              (image: "icons8_purchase_order", name: "Billing"),
                                              (image: "icons8_exit", name: "Logout"),
                                              (image: "icons8_secure_cloud", name: "Your Data")
                                             
                                              ]
    
    static let kSettingRestColScreenDict = [
                                            (image: "icons8_settings", name: "Settings"),
                                            (image: "icons8_shop", name: "Marketplace"),
                                            (image: "calendar (2)", name: "Events"),
                                            (image: "icons8_security_lock", name: "Privacy"),
                                            (image: "icons8_privacy", name: "Password"),
                                            (image: "icons8_unavailable", name: "Blocking"),
                                            (image: "icons8_debit_card_1", name: "Membership"),
                                            (image: "icons8_purchase_order", name: "Billing"),
                                            (image: "icons8_exit", name: "Logout"),
                                            (image: "icons8_secure_cloud", name: "Your Data")
                                            
                                            ]
    
    static let kSettingVoyaColScreenDict = [(image: "icons8_settings", name: "Settings"),
                                            
                                            (image: "icons8_security_lock", name: "Privacy"),
                                            (image: "icons8_privacy", name: "Password"),
                                            (image: "icons8_unavailable", name: "Blocking"),
                                            (image: "icons8_debit_card_1", name: "Membership"),
                                            (image: "icons8_purchase_order", name: "Billing"),
                                            (image: "icons8_exit", name: "Logout"),
                                            (image: "icons8_secure_cloud", name: "Your Data")
                                            
                                            
                                            ]

    static let kSettingTravlColScreenDict = [
                                             (image: "icons8_settings", name: "Settings"),
                                             (image: "icons8_shop", name: "Marketplace"),
                                             (image: "icons8_security_lock", name: "Privacy"),
                                             (image: "icons8_privacy", name: "Password"),
                                             (image: "icons8_unavailable", name: "Blocking"),
                                             (image: "icons8_debit_card_1", name: "Membership"),
                                             (image: "icons8_purchase_order", name: "Billing"),
                                             (image: "icons8_exit", name: "Logout"),
                                             (image: "icons8_secure_cloud", name: "Your Data")
                                              
                                             
    ]
    
    static let kSettingExpertColScreenDict = [
                                              (image: "icons8_settings", name: "Settings"),
                                             (image: "icons8_shop", name: "Marketplace"),
                                              (image: "Featured", name: "Featured"),
                                              (image: "icons8_security_lock", name: "Privacy"),
                                              (image: "icons8_privacy", name: "Password"),
                                              (image: "icons8_unavailable", name: "Blocking"),
                                              (image: "icons8_debit_card_1", name: "Membership"),
                                              (image: "icons8_purchase_order", name: "Billing"),
                                                (image: "icons8_exit", name: "Logout"),
                                              (image: "icons8_secure_cloud", name: "Your Data")
                                              
                                              ]
    
    //MARK: EditSettingCollectionView
    static let kEditSettingUserColScreenDict = [
                                              (image: "editSettingprofile", name: "User Settings"),
                                               (image: "community", name: "Edit Hub")
                                              ]
    
    static let kEditSettingVoyColScreenDict = [
                                              (image: "editSettingprofile", name: "Edit Profile")
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
    
    
    static let kBusinessCategoryDict = [(image: "b2btab1_icon", name: "Hubs"),
                                        (image: "b2btab2_icon", name: "Importers & Distributors"),
                                        (image: "b2btab3_icon", name: "Italian Restaurants in US"),
                                        (image: "b2btab4_icon", name: "Voice of Experts"),
                                        (image: "b2btab5_icon", name: "Travel Agencies"),
                                        (image: "b2btab6_icon", name: "Producer"),
    ]
    
    static let kNetworkCategoryDict = [(image: "icons_invitations", name: "Invitations"),
                                       (image: "icons8_people", name: "Connections"),
                                       (image: "icons_pending", name: "Pending"),
                                       kSharedUserDefaults.loggedInUserModal.memberRoleId == "10" ? (image: "icons_invitations", name: "Following") : (image: "icons_invitations", name: "Followers")]
    
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
    
}

enum LoadCell {
    case stateList
    case hubList
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

