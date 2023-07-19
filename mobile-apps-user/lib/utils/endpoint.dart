//STAGING
// const baseUrl = 'https://api-staging.myarchery.id';
// const webBaseUrl = 'https://staging.myarchery.id';
// const urlMidtransSnap = 'https://app.sandbox.midtrans.com/snap/v2/vtweb/';

//PRODUCTION
// const baseUrl = 'https://api.myarchery.id';
// const webBaseUrl = 'https://myarchery.id';
// const urlMidtransSnap = 'https://app.midtrans.com/snap/v2/vtweb/';

import 'package:myarchery_archer/core/services/environment.dart';

final baseUrl = Environment.apiUrl;
final webBaseUrl =  Environment.webUrl;
final urlMidtransSnap = Environment.urlMidtransSnap;

final urlLiveScore = '$webBaseUrl/live-score/';
final urlRegister = '$baseUrl/app/v1/auth/register';
final urlLogin = '$baseUrl/app/v1/auth/login';
final urlForgotPass = '$baseUrl/app/v1/auth/forgot-password';
final urlValidateForgotOtp = '$baseUrl/app/v1/auth/validate-code-password';
final urlMyClub = '$baseUrl/app/v1/archery/archery-club/my-club';
final urlClub = '$baseUrl/app/v1/archery/archery-club';
final urlMemberClub = '$baseUrl/app/v1/archery/archery-club/get-club-member';
final urlProfileClub = '$baseUrl/app/v1/archery/archery-club/profile';
final urlProvince = '$baseUrl/api/general/get-province';
final urlCity = '$baseUrl/api/general/get-city';
final urlCreateClub = '$baseUrl/app/v1/archery/archery-club/';
final urlUpdateClub = '$baseUrl/app/v1/archery/archery-club/update';
final urlJoinClub = '$baseUrl/app/v1/archery/archery-club/join';
final urlLeftClub = '$baseUrl/app/v1/archery/archery-club/left';
final urlResetPassword = '$baseUrl/app/v1/auth/reset-password';

//profile
final urlGetDataVerify = '$baseUrl/app/v1/user/data-verifikasi';
final urlUpdateVerify = '$baseUrl/app/v1/user/update-verifikasi';
final urlUpdateProfile = '$baseUrl/app/v1/user/update-profile';
final urlUpdateAvatar = '$baseUrl/app/v1/user/update-avatar';
final urlProfile = '$baseUrl/app/v1/user';

final urlShareClub = "$webBaseUrl/clubs/profile";

//EVENT
final urlEvent = '$baseUrl/api/archery-events';
final urlMyEvent = '$baseUrl/app/v1/archery-event/my-event';
final urlDetailMyEvent = '$baseUrl/app/v1/archery-event/my-category-event';
final urlMemberMyEvent = '$baseUrl/app/v1/archery-event/my-category-event-member';
final urlEditMemberMyEvent = '$baseUrl/app/v1/archery-event/update-category-event-member';
final urlEventOrder = '$baseUrl/app/v1/archery/event-order';
final urlDetailEventOrder = '$urlEventOrder/1';
final urlCategoryEventRegister = '$baseUrl/web/v1/archery/events/register/list-categories';
final urlCheckEmailMemberEvent = '$baseUrl/app/v1/archery/event-order/check-email';

//OFFICIAL
final urlDetailOfficial = '$baseUrl/app/v1/archery-event-official/event-official-detail';
final urlOrderOfficial = '$baseUrl/app/v1/archery-event-official/order';

//GENERAL
final urlFaq = '$baseUrl/general/v2/q-and-a/get-by-event_id'; //?event_id=22&page=1&limit=1000

//v2
final urlDetailEventV2 = '$baseUrl/general/v2/events/by-slug';
final urlCategoryEventRegisterV2 = '$baseUrl/general/v2/category-details';
final urlListOrderV2 = '$baseUrl/app/v1/archery/event-order/get-order-v2';
final urlDetailOrderOfficial = '$baseUrl/app/v1/archery-event-official/detail-order';

