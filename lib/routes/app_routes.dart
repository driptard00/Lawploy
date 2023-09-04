import 'package:get/get.dart';
import 'package:lawploy_app/routes/app_route_names.dart';
import 'package:lawploy_app/screens/Auth/Law%20Firm/lawFirmDetails.dart';
import 'package:lawploy_app/screens/Auth/Lawyers/personalDetailsScreen.dart';
import 'package:lawploy_app/screens/Auth/createNewPassword.dart';
import 'package:lawploy_app/screens/Auth/forgotPassword.dart';
import 'package:lawploy_app/screens/Auth/loginScreen.dart';
import 'package:lawploy_app/screens/Auth/otpVerificationScreen.dart';
import 'package:lawploy_app/screens/Auth/signUpScreen.dart';
import 'package:lawploy_app/screens/Auth/typeOfAccountScreen.dart';
import 'package:lawploy_app/screens/Main/BreifsScreen/briefsScreen.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/getLawFirmProfileScreen.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/holderScreen.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Briefs/briefDescriptionScreen.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Home/sendBriefScreen.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Profile/editProfileScreen.dart';
import 'package:lawploy_app/screens/Main/Law%20Firm/views/Settings/updatePasswordScreen.dart';
import 'package:lawploy_app/screens/Main/Lawyers/holderScreen.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Briefs/briefDescriptionScreen.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Briefs/briefsScreen.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/JOBS/jobDetailsScreen.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Settings/updatePasswordScreen.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/interview/jobsScreen.dart';
import 'package:lawploy_app/screens/Main/Messages/chatRoom.dart';
import 'package:lawploy_app/screens/Main/Notification/notificationScreen.dart';
import 'package:lawploy_app/screens/Main/PAYMENT/paymentScreen.dart';
import 'package:lawploy_app/screens/Main/Private%20Individual/views/Jobs/jobDetailScreen.dart';
import 'package:lawploy_app/screens/Main/Private%20Individual/views/Settings/updatePasswordScreen.dart';
import 'package:lawploy_app/screens/Main/SwitchAccountFLow/Company/companyDetails.dart';
import 'package:lawploy_app/screens/Main/SwitchAccountFLow/Firm/firmDetails.dart';
import 'package:lawploy_app/screens/Main/SwitchAccountFLow/Lawyer/personalDetails.dart';
import 'package:lawploy_app/screens/Main/SwitchAccountFLow/Lawyer/workDetails.dart';
import 'package:lawploy_app/screens/Main/SwitchAccountFLow/PrivateInd/individualDetails.dart';
import 'package:lawploy_app/screens/Main/SwitchAccountFLow/availableAccountScreen.dart';
import 'package:lawploy_app/screens/Main/jobFeedsScreen.dart';
import 'package:lawploy_app/screens/Main/jobApplicationScreen.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Profile/sharedBreifsScreen.dart';
import 'package:lawploy_app/screens/Main/Lawyers/views/Profile/switchAccountScreen.dart';
import 'package:lawploy_app/screens/Main/Private%20Individual/views/Home/postJobOfferScreen.dart';
import 'package:lawploy_app/screens/Onboarding%20Screens/onboardingScreen.dart';
import '../screens/Auth/Cooperation/companyDetails.dart';
import '../screens/Auth/Lawyers/profileAvailablity.dart';
import '../screens/Auth/Lawyers/workDetailsScreen.dart';
import '../screens/Auth/Private Individual/personalDetailsScreenPI.dart';
import '../screens/Auth/verifyEmailScreen.dart';
import '../screens/Main/Company/getCompanyDetailScreen.dart';
import '../screens/Main/Company/holderScreen.dart';
import '../screens/Main/Company/views/Home/HomeTabView/SEE ALL LAWYERS company/seeAllLawyersEmployment.dart';
import '../screens/Main/Company/views/Home/interviewScreen.dart';
import '../screens/Main/Company/views/Home/interviewScreenTabs/sendInterviewInvite.dart';
import '../screens/Main/Company/views/Home/postJobOfferScreen.dart';
import '../screens/Main/Company/views/Home/profileEmploymentScreen.dart';
import '../screens/Main/Company/views/Jobs/jobDetailsScreen.dart';
import '../screens/Main/Company/views/Profile/editProfileScreen.dart';
import '../screens/Main/Company/views/Profile/switchAccountScreen.dart';
import '../screens/Main/Company/views/Settings/companySettingScreen.dart';
import '../screens/Main/Company/views/Settings/updatePasswordScreen.dart';
import '../screens/Main/Law Firm/views/Home/SEE ALL LAWYERS (firm)/seeAllLawyersScreen.dart';
import '../screens/Main/Law Firm/views/Home/profileEmploymentScreen.dart';
import '../screens/Main/Law Firm/views/Home/profileHoldBriefScreen.dart';
import '../screens/Main/Law Firm/views/Settings/lawFirmSettingScreen.dart';
import '../screens/Main/Lawyers/getLawyerProfileScreen.dart';
import '../screens/Main/Lawyers/views/Home/SEE ALL LAWYERS/seeAllLawyersScreen.dart';
import '../screens/Main/Lawyers/views/Home/profileEmploymentScreen.dart';
import '../screens/Main/Lawyers/views/Home/profileHoldBriefScreen.dart';
import '../screens/Main/Lawyers/views/JOBS/feedbackScreen.dart';
import '../screens/Main/Lawyers/views/Profile/settingsScreen.dart';
import '../screens/Main/Lawyers/views/Settings/lawyerSettingScreen.dart';
import '../screens/Main/PAYMENT/paymentSummaryScreen.dart';
import '../screens/Main/Private Individual/getPrivateProfileScreen.dart';
import '../screens/Main/Private Individual/views/Home/SEE ALL LAWYERS private/seeAllLawyersEmployment.dart';
import '../screens/Main/Private Individual/views/Home/profileEmploymentScreen.dart';
import '../screens/Main/Private Individual/views/Settings/privateSettingScreen.dart';
import '../screens/Main/Profiles/faqsScreen.dart';
import '../screens/Main/Profiles/helpScreen.dart';
import '../screens/Main/SEARCH SCREEN/searchScreen.dart';
import '../screens/Main/inviteForInterviewScreen.dart';
import '../screens/Main/Lawyers/views/Home/sendBriefScreen.dart';
import '../screens/Main/Lawyers/views/Profile/editProfileScreen.dart';
import '../screens/Main/Private Individual/holderScreen.dart';
import '../screens/Main/Private Individual/views/Profile/editProfileScreen.dart';
import '../screens/Main/Private Individual/views/Profile/switchAccountScreen.dart';
import '../screens/Splash Screen/splashScreen.dart';

// =============== APP ROUTE ===============

List<GetPage> getPages = [
  // ========== SPLASH SCREEN =============
  GetPage(
    name: splashScreen,
    page: ()=> const SplashScreen()
  ),

  // ======== ONBOARDING SCREEN ==========
  GetPage(
    name: onboardingScreen,
    page: () => OnboardingScreens(),
  ),

  // ======== LOGIN SCREEN ==========
  GetPage(
    name: signUpScreen,
    page: () => SignUpScreen(),
  ),

  // ======== EMAIL VERIFICATION SCREEN ==========
  GetPage(
    name: otpVerificationScreen,
    page: () => OtpVerificationScreen(),
  ),

  // ======== TYPE OF ACCOUNT SCREEN ==========
  GetPage(
    name: typeOfAccountScreen,
    page: () => TypeOfAccountScreen(),
  ),

  // ======== PERSONAL DETAILS (LAWYER) SCREEN ==========
  GetPage(
    name: lawyerpersonalDetailsScreen,
    page: () => PersonalDetailsScreen(),
  ),

  // ======== PERSONAL DETAILS (PI) SCREEN ==========
  GetPage(
    name: pipersonalDetailsScreen,
    page: () => PersonalDetailsScreenPI(),
  ),

  // ======== WORK DETAILS (LAWYER) SCREEN ==========
  GetPage(
    name: lawyerworkDetailsScreen,
    page: () => WorkDetailsScreen(),
  ),

  // ======== WORK DETAILS (LAWYER) SCREEN ==========
  GetPage(
    name: lawyerprofileAvailabilityScreen,
    page: () => ProfileAvailabilityScreen(),
  ),

  // ======== COMPANY DETAILS (CO OPERATION) SCREEN ==========
  GetPage(
    name: comapanyDetailsScreen,
    page: () => CompanyDetailScreen(),
  ),

  // ======== COMPANY DETAILS (CO OPERATION) SCREEN ==========
  GetPage(
    name: lawFirmDetails,
    page: () => LawFirmDetails(),
  ),

  // ======== LOGIN SCREEN ==========
  GetPage(
    name: loginScreen,
    page: () => LoginScreen(),
  ),

  // ======== FORGOT PASSWORD SCREEN ==========
  GetPage(
    name: forgotPassword,
    page: () => ForgotPassword(),
  ),

  // ======== VERIFICATION EMAIL SCREEN ==========
  GetPage(
    name: verifyEmailScreen,
    page: () => VerifyEmailScreen(),
  ),

  // ======== CREATE NEW PASSWORD SCREEN ==========
  GetPage(
    name: createNewPassword,
    page: () => CreateNewPassword(),
  ),

  // ======== INVITE FOR INTERVIEW SCREEN ==========
  GetPage(
    name: inviteForInterviewScreen,
    page: () => InviteForInterviewScreen(),
  ),

  // ======== EMPLOYMENT MAIN ==========
  GetPage(
    name: profileEmploymentScreen,
    page: () => ProfileEmploymentScreen(),
  ),

  // ======== HOLD BRIEF MAIN ==========
  GetPage(
    name: profileHoldBriefScreen,
    page: () => ProfileHoldBriefScreen(),
  ),

  // ======== JOB FEED MAIN ==========
  GetPage(
    name: jobFeedProfileScreen,
    page: () => JobFeedProfileScreen(),
  ),

  // ======== JOB APPLICATION (UPLOAD CV) SCREEN ==========
  GetPage(
    name: jobApplicationScreen,
    page: () => JobApplicationScreen(),
  ),

  // ======== SEND BRIEF SCREEN ==========
  GetPage(
    name: sendBriefScreen,
    page: () => LawyerSendBriefScreen(),
  ),

  // ======== SETTING SCREEN ==========
  GetPage(
    name: lawyerSettingScreen,
    page: () => LawyerSettingScreen(),
  ),

  // ======== SETTING SCREEN ==========
  GetPage(
    name: privateSettingsScreen,
    page: () => PrivateSettingScreen(),
  ),

  // ======== SETTING SCREEN ==========
  GetPage(
    name: companySettingsScreen,
    page: () => CompanySettingScreen(),
  ),

  // ======== SETTING SCREEN ==========
  GetPage(
    name: lawFirmSettingScreen,
    page: () => LawFirmSettingScreen(),
  ),
  
  // ======== HELP SCREEN ==========
  GetPage(
    name: helpScreen,
    page: () => HelpScreen(),
  ),
  
  // ======== FAQS SCREEN ==========
  GetPage(
    name: faqsScreen,
    page: () => FaqsScreen(),
  ),
  
  // ======== NOTIFICATION SCREEN ==========
  GetPage(
    name: notificationScreen,
    page: () => NotificationScreen(),
  ),
  
  // ======== CHAT ROOM ==========
  GetPage(
    name: chatRoom,
    page: () => ChatRoom(),
  ),
  
  // ======== SEARCH SCREEN ==========
  GetPage(
    name: searchScreen,
    page: () => SearchScreen(),
  ),

  // ======== LAWYER MAIN SCREEN ==========
  GetPage(
    name: lawyerHolderScreen,
    page: () => LawyerHolderScreen(),
  ),
  GetPage(
    name: editProfileScreen,
    page: () => EditProfileScreen(),
  ),
  GetPage(
    name: sharedBriefScreen,
    page: () => SharedBriefScreen(),
  ),
  GetPage(
    name: getLawyerDetailsScreen,
    page: () => GetLawyerProfileService(),
  ),
  GetPage(
    name: interviewJobDetailScreen,
    page: () => JobDetailScreen(),
  ),
  GetPage(
    name: interviewFeedbackScreen,
    page: () => FeedBackScreen(),
  ),
  GetPage(
    name: seeAllLawyersScreen,
    page: () => SeeAllLawyersScreen(),
  ),
  GetPage(
    name: lawyerUpdatePasswordScreen,
    page: () => LawyerUpdatePassword(),
  ),
  GetPage(
    name: lawyerBriefDescriptionScreen,
    page: () => LawyerBriefDescriptionScreen(),
  ),


  // ======== LAW FIRM MAIN SCREEN ==========
  GetPage(
    name: lawFirmHolderScreen,
    page: () => LawFirmHolderScreen(),
  ),
  GetPage(
    name: lfsendBriefScreen,
    page: () => LFSendBriefScreen(),
  ),
  GetPage(
    name: getLawFirmDetailScreen,
    page: () => GetLawFirmProfileScreen(),
  ),
  GetPage(
    name: lfeditProfileScreen,
    page: () => LFEditProfileScreen(),
  ),
  GetPage(
    name: lawFirmEmploymentScreen,
    page: () => LawFirmProfileEmploymentScreen(),
  ),
  GetPage(
    name: lfProfileHoldBriefScreen,
    page: () => LFProfileHoldBriefScreen(),
  ),
  GetPage(
    name: firmSeeAllLawyersScreen,
    page: () => SeeAllLawyersScreenFirm(),
  ),
  GetPage(
    name: firmUpdatePasswordScreen,
    page: () => LawFirmUpdatePassword(),
  ),
  GetPage(
    name: firmBriefDescriptionScreen,
    page: () => FirmBriefDescriptionScreen(),
  ),

  // ======== COMPANY MAIN SCREEN ==========
  GetPage(
    name: companyHolderScreen,
    page: () => CompanyHolderScreen(),
  ),
  GetPage(
    name: companyeditProfileScreen,
    page: () => CompanyEditProfileScreen(),
  ),
  GetPage(
    name: companyswitchAccountScreen,
    page: () => CompanySwitchAccountScreen(),
  ),
  GetPage(
    name: companyPostJobOfferScreen,
    page: () => CompanyPostJobOfferScreen(),
  ),
  GetPage(
    name: companyinterviewScreen,
    page: () => CompanyInterviewScreen(),
  ),
  GetPage(
    name: companySendInterviewInvite,
    page: () => CompanySendInterviewInviteScreen(),
  ),
  GetPage(
    name: getCompanyDetailsScreen,
    page: () => GetCompanyProfileScreen(),
  ),
  GetPage(
    name: companyEmploymentScreen,
    page: () => CompanyProfileEmploymentScreen(),
  ),
  GetPage(
    name: companyMyJobScreen,
    page: () => CompanyMyJobScreen(),
  ),
  GetPage(
    name: companySeeAllLawyersScreen,
    page: () => SeeAllLawyersScreenCompany(),
  ),
  GetPage(
    name: companyUpdatePasswordScreen,
    page: () => CompanyUpdatePassword(),
  ),

  // ======== PRIVATE INDIVIDUAL MAIN SCREEN ==========
  GetPage(
    name: piHolderScreen,
    page: () => PIHolderScreen(),
  ),
  GetPage(
    name: pieditProfileScreen,
    page: () => PIEditProfileScreen(),
  ),
  GetPage(
    name: piswitchAccountScreen,
    page: () => PISwitchAccountScreen(),
  ),
  GetPage(
    name: piPostJobOfferScreen,
    page: () => PIPostJobOfferScreen(),
  ),
  GetPage(
    name: getPrivateDetailsScreen,
    page: () => GetPrivateProfileScreen(),
  ),
  GetPage(
    name: privateEmploymentScreen,
    page: () => PrivateProfileEmploymentScreen(),
  ),
  GetPage(
    name: privateSeeAllLawyersScreen,
    page: () => SeeAllLawyersScreenPrivate(),
  ),
  GetPage(
    name: privateUpdatePasswordScreen,
    page: () => PrivateUpdatePassword(),
  ),
  GetPage(
    name: privateMyJobScreen,
    page: () => PrivateMyJobScreen(),
  ),

  // ========== PAYMENT SCREEN =========
  GetPage(
    name: paymentSummaryScreen,
    page: () => PaymentSummaryScreen(),
  ),
  GetPage(
    name: paymentScreen,
    page: () => PaymentScreen(),
  ),

  // =========== MY BRIEFS SCREEN ===========
  GetPage(
    name: myBriefsScreen,
    page: () => MyBriefsScreen(),
  ),

  // =========== JOBS SCREEN ===========
  GetPage(
    name: jobScreen,
    page: () => OtherJobScreen()
  ),

  // ============ SWITCH ACCOUNT FLOW ===========
  GetPage(
    name: allAvailableAccountScreen,
    page: () => AllAvailableAccountsScreen()
  ),

  GetPage(
    name: createNewAccountTypeCompany,
    page: () => SwitchCompanyDetailScreen()
  ),
  GetPage(
    name: createNewAccountTypePrivate,
    page: () => SwitchPersonalDetailsScreenPI()
  ),
  GetPage(
    name: createNewAccountTypeFirm,
    page: () => SwitchLawFirmDetails()
  ),
  GetPage(
    name: personalDetailsLawyer,
    page: () => SwitchPersonalDetailsScreen()
  ),
  GetPage(
    name: workDetailsLawyer,
    page: () => SwitchWorkDetailsScreen()
  ),

]; 