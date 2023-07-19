import 'package:myarcher_enterprise/core/services/environment.dart';

final String baseUrl = Environment.apiUrl;

///AUTH
final String urlLogin = '$baseUrl/web/v1/auth/login';
final String urlRegister = '$baseUrl/web/v1/auth/register';
final String urlForgotPass = '$baseUrl/web/v1/auth/forgot-password';
final String urlValidateForgotOtp = '$baseUrl/web/v1/auth/validate-code-password';
final String urlResetPassword = '$baseUrl/web/v1/auth/reset-password';
final String urlCheckEmail = '$baseUrl/web/v1/auth/check-admin-register';

final String urlProfile = '$baseUrl/web/v1/user';
final String urlProvince = '$baseUrl/api/general/get-province';
final String urlCity = '$baseUrl/api/general/get-city';

///Venue
final String urlHistoryOtherFacilities = '$baseUrl/web/enterprise/v1/venue/list-facilities-by-eo-id';
final String urlHideHistoryOtherFacilities = '$baseUrl/web/enterprise/v1/venue/update-is-hide-other-facilities';
final String urlFacilityVeneu = '$baseUrl/web/enterprise/v1/venue/list-facilities';
final String urlVenue = '$baseUrl/web/enterprise/v1/venue';
final String urlUpdateVenue = '$baseUrl/web/enterprise/v1/venue/update';
final String urlListVenue = '$baseUrl/web/enterprise/v1/venue/list-venue-place';
final String urlDeleteVenue = '$baseUrl/web/enterprise/v1/venue/delete-draft';
final String urlDeleteImageVenue = '$baseUrl/web/enterprise/v1/venue/delete-image-venue-place';

///operational venue
final String urlAddScheduleOperational = '$baseUrl/web/enterprise/v1/venue/schedule/operational/add';
final String urlUpdateScheduleOperational = '$baseUrl/web/enterprise/v1/venue/schedule/operational/update';
final String urlListScheduleOperational = '$baseUrl/web/enterprise/v1/venue/schedule/operational/get-all-list';

///holiday schedule venue
final String urlAddHolidaySchedule = '$baseUrl/web/enterprise/v1/venue/schedule/holiday/add';
final String urlUpdateHolidaySchedule = '$baseUrl/web/enterprise/v1/venue/schedule/holiday/update';
final String urlListHolidaySchedule = '$baseUrl/web/enterprise/v1/venue/schedule/holiday/get-all-list';
final String urlDeleteHolidaySchedule = '$baseUrl/web/enterprise/v1/venue/schedule/holiday/delete';

final String urlOptionDistance = '$baseUrl/web/enterprise/v1/venue/list-capacity-area';
final String urlPublishVenue = '$baseUrl/web/enterprise/v1/venue/complete-venue-place';
