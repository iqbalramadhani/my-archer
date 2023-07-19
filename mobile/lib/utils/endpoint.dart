import 'package:my_archery/core/services/environment.dart';

final baseUrl = Environment.apiUrl;
final webBaseUrl =  Environment.webUrl;
final urlMidtransSnap = Environment.urlMidtransSnap;

final urlLogin = '$baseUrl/web/v1/auth/login';
final urlScanQr = '$baseUrl/web/v1/archery/scorer/participant/detail';
final urlSaveTempScore = '$baseUrl/web/v1/archery/scorer';
final urlScanQrIdCard = '$baseUrl/web/v2/id-card/find-id-card-by-code';

//PUT web/v2/schedule-full-day/change_bud_rest?event_id=58&schedule_id=27&bud_rest_number=1B
final urlSetBudrestNumberQualification = '$baseUrl/web/v2/schedule-full-day/change_bud_rest';

//POST web/v2/event-elimination/set-budrest
final urlSetBudrestNumberElimination = '$baseUrl/web/v2/event-elimination/set-budrest';
