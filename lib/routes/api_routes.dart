// ============= API ROUTES ==============

String baseUrl = "https://api.lawploy.com/api/v1"; // BASE URL

// ======= AUTH ROUTES ==========
String registerRoute = "/auth/register"; // REGISTER ROUTE
String loginRoute = "/auth/login"; // LOGIN ROUTE
String logoutRoute = "/auth/logout"; // LOGOUT ROUTE
String resendRegisterOtpRoute = "/auth/resend/signup/otp"; // RESEND REGISTER OTP ROUTE
String forgotPasswordRoute = "/auth/forgot-password"; // FORGOT PASSWORD ROUTE
String resetPasswordRoute = "/auth/reset-password"; // RESET PASSWORD ROUTE
String verifyRegisterOtpRoute = "/auth/verify/otp"; // VERIFY REGISTER OTP ROUTE
String verifyPasswordOtpRoute = "/auth/verify/password"; // VERIFY PASSWORD OTP ROUTE

// ======== ONBOARDING ROUTES ==========

// COMPANY ROUTES
String companyOnboardingRoute = "/corporation/onboarding";
String getCompanyProfileRoute = "/corporation/profile";
String updateCompanyProfileRoute = "/corporation/profile/update";
String updateCompanyProfileImageRoute = "/corporation/profile/update/image";
String updateCompanyPasswordRoute = "/corporation/profile/update/password";
String companyGetAllLawyersRoute = "/corporation/";
String companySinlgeLawyerRoute = "/corporation/read/";
String companyUpdateInAppNotificationRoute = "/corporation/profile/update/inapp";
String companyUpdateEmailNotificationRoute = "/corporation/profile/update/email";
String companyUpdateVisibilityRoute = "/corporation/profile/update/visiblity";

// LAW FIRM ROUTES
String lawFirmOnboardingRoute = "/firm/onboarding";
String getLawFirmProfileRoute = "/firm/profile";
String updateLawFirmProfileRoute = "/firm/profile/update";
String updateLawFirmProfileImageRoute = "/firm/profile/update/image";
String updateLawFirmPasswordRoute = "/firm/profile/update/password";
String lawFirmGetAllLawyersRoute = "/firm/";
String lawFirmSinlgeLawyerRoute = "/firm/read/";
String firmUpdateInAppNotificationRoute = "/firm/profile/update/inapp";
String firmUpdateEmailNotificationRoute = "/firm/profile/update/email";
String firmUpdateVisibilityRoute = "/firm/profile/update/visiblity";

// LAWYER ROUTES
String lawyerOnboardingRoute = "/lawyer/onboarding";
String getLawyerProfileRoute = "/lawyer/profile";
String updateLawyerProfileRoute = "/lawyer/profile/update";
String updateLawyerProfileImageRoute = "/lawyer/profile/update/image";
String updateLawyerPasswordRoute = "/lawyer/profile/update/password";
String applyForJobsRoute = "/jobs/apply/";
String getMyApplicationsRoute = "/jobs/applications";
String getAnpplicationsRoute = "/jobs/application/";
String getAllLawyersRoute = "/lawyer/";
String getSingleLawyer = "/lawyer/read/";
String lawyerUpdateInAppNotificationRoute = "/lawyer/profile/update/inapp";
String lawyerUpdateEmailNotificationRoute = "/lawyer/profile/update/email";
String lawyerUpdateVisibilityRoute = "/lawyer/profile/update/visiblity";

// PRIVATE INDIVIDUAL ROUTES
String piOnboardingRoute = "/private/onboarding";
String getPIProfileRoute = "/private/profile";
String updatePrivateProfileRoute = "/private/profile/update";
String updatePrivateProfileImageRoute = "/private/profile/update/image";
String updatePrivatePasswordRoute = "/private/profile/update/password";
String privateGetAllLawyersRoute = "/private/";
String privateSinlgeLawyerRoute = "/private/read/";
String privateUpdateInAppNotificationRoute = "/private/profile/update/inapp";
String privateUpdateEmailNotificationRoute = "/private/profile/update/email";
String privateUpdateVisibilityRoute = "/private/profile/update/visiblity";

// ======== BRIEFS ROUTES ==========
String getMyBriefsRoute = "/brief"; 
String deleteBriefRoute = "/brief/";
String getSingleBriefRoute = "/brief/read/:id";
String createBriefRoute = "/brief";
String getSharedBriefRoute = "/brief/shared";

// ========= JOB ROUTES ==========
String createJobRoute = "/jobs/create";
String getActiveJobsRoute = "/jobs";
String getAJobRoute = "/jobs/read/";
String deleteJobRoute = "/jobs/";
String editJobRoute = "/jobs/";
String getMyJobsRoute = "/jobs/manage/";
String getSingleJobRoute = "/jobs/manage/";
String manageApplicantRoute = "/jobs/manage/";
String getAllJobData = "/jobs/all";

// ============= CHAT/MESSAGING ROUTE =================
String createConversationRoute = "/chats";
String getConversationRoute = "/chats";
String loadAllMessagesRoute = "/chats";
String markChatAsReadRoute = "/chats";
String sendMessageRoute = "/chats";
String deleteMessageRoute = "/chats/:id/message/:chat";
String onlineStatusRoute = "/chats/user/status/";

// ================ NOTIFICATION ROUTE ================
String getNotifcationRoute = "/notifications";
String markAllNotificationRead = "/notifications/seen";

// ============== SEARCH ROUTE ===============
String searchForLawyerRoute = "/search/lawyer";
String searchForCompanyRoute = "/search/coporation";

// ============ INTERVIEW ROUTES ===========
String sendInterviewInvite = "/interview/send";
String getAllSentInterview = "/interview/sent";
String getSingleSentInterview = "/interview/sent/";
String sendFeedback = "/interview/feedback/";

String getAllRecievedInterviews = "/interview/received";
String getSingleRecievedInterviews = "/interview/received/";
String acceptInterviewInvite = "/interview/received/";

// =========== SWITCH ACCOUNT ============
String getAllAccountsRoute = "/auth/accounts";
String createNewAccountTypeRoute = "/auth/account";
String switchAccountRoute = "/auth/account";