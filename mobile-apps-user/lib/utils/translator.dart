import 'package:get/get.dart';

class Translator extends Translations {
  static const String appName = "app_name";
  static const String login = "login";
  static const String save = "save";
  static const String nameScorer = "name_scorer";
  static const String usernameOrEmail = "username_or_email";
  static const String email = "email";
  static const String hintEmail = "hint_email";
  static const String password = "password";
  static const String welcome = "welcome";
  static const String hintUsername = "hint_username";
  static const String hintPassword = "hint_password";
  static const String hintConfirmPassword = "hint_confirm_password";
  static const String pleaseEnter = "please_enter";
  static const String cancel = "cancel";
  static const String liveScore = "liveScore";
  static const String by = "by";
  static const String registerFee = "registerFee";
  static const String availableQuota = "availableQuota";
  static const String available = "available";
  static const String description = "description";
  static const String day = "day";
  static const String hour = "hour";
  static const String minute = "minute";
  static const String second = "second";
  static const String registerEvent = "registerEvent";
  static const String expired = "expired";
  static const String fullName = "fullName";
  static const String birthdate = "birthdate";
  static const String male = "male";
  static const String female = "female";
  static const String hintFullName = "hintFullName";
  static const String hintBirthday = "hintBirthday";
  static const String pleaseRegister = "pleaseRegister";
  static const String dataUser = "dataUser";
  static const String alreadyHaveAccount = "alreadyHaveAccount";
  static const String back = "back";
  static const String forgotPass = "forgotPass";
  static const String home = "home";
  static const String event = "event";
  static const String profile = "profile";
  static const String verify = "verify";
  static const String createNewPassword = "createNewPassword";
  static const String newPass = "newPass";
  static const String confirmNewPass = "confirm_new_pass";
  static const String repeatPass = "repeatPass";
  static const String inputMin6Char = "inputMin6Char";
  static const String resendOtp = "resendOtp";
  static const String resetOtp = "resetOtp";
  static const String inputCode = "inputCode";
  static const String register = "register";
  static const String next = "next";
  static const String payNow = "payNow";
  static const String somethingWentWrong = "somethingWentWrong";
  static const String verifyPhotoProfile = "verifyPhotoProfile";
  static const String goToEditProfile = "goToEditProfile";
  static const String thereIsUpdateNeedUploadPhoto = "thereIsUpdateNeedUploadPhoto";
  static const String pleaseVerifyDataToFollowMatch = "pleaseVerifyDataToFollowMatch";
  static const String yourAccountRequestedVerify = "yourAccountRequestedVerify";
  static const String seeDetail = "seeDetail";
  static const String requestRejected = "requestRejected";
  static const String reRequest = "reRequest";
  static const String yourAccountVerified = "yourAccountVerified";
  static const String failedGetFaq = "failedGetFaq";
  static const String officialPayment = "officialPayment";
  static const String backToMainpage = "backToMainpage";
  static const String msgSuccessRequestVerify = "msgSuccessRequestVerify";
  static const String noDescription = "noDescription";
  static const String faq = "faq";
  static const String registerYourselfsoon = "registerYourselfsoon";
  static const String earlyBirdUntil = "earlyBirdUntil";
  static const String all = "all";
  static const String payment = "payment";
  static const String qualification = "qualification";
  static const String elimination = "elimination";
  static const String myEvent = "myEvent";
  static const String participant = "participant";
  static const String document = "document";
  static const String match = "match";
  static const String comingSoon = "comingSoon";
  static const String eventName = "eventName";
  static const String eventType = "eventType";
  static const String location = "location";
  static const String date = "date";
  static const String editBoundary = "editBoundary";
  static const String listParticipant = "listParticipant";
  static const String maxHmin1Event = "maxHmin1Event";
  static const String dataRegistrant = "dataRegistrant";
  static const String nameRegistrant = "nameRegistrant";
  static const String phoneNumber = "phoneNumber";
  static const String teamName = "teamName";
  static const String clubName = "clubName";
  static const String changeParticipant = "changeParticipant";
  static const String chooseParticipant = "chooseParticipant";
  static const String alreadyAdded = "alreadyAdded";
  static const String pleaseChooseParticipant1First = "pleaseChooseParticipant1First";
  static const String pleaseChooseParticipant2First = "pleaseChooseParticipant2First";
  static const String pleaseChooseParticipant3First = "pleaseChooseParticipant3First";
  static const String pleaseChooseParticipant4First = "pleaseChooseParticipant4First";


  @override
  Map<String, Map<String, String>> get keys => {
    'id_ID': {
      appName: 'My Archery',
      login : 'Masuk',
      save : 'Simpan',
      usernameOrEmail : 'Username atau Email',
      email : 'Email',
      hintEmail : 'Masukkan Email',
      password : 'Kata Sandi',
      welcome : 'Selamat Datang,',
      hintUsername : 'Masukkan Username atau Email',
      hintPassword : 'Masukkan Kata Sandi',
      hintConfirmPassword : 'Masukkan Konfirmasi Kata Sandi',
      pleaseEnter : 'Silahkan Masuk',
      cancel : 'Batal',
      by : 'Oleh',
      registerFee : 'Biaya Pendaftaran',
      availableQuota : 'Kuota Tersedia',
      available : 'Tersedia',
      description : 'Deskripsi',
      day : 'Hari',
      hour : 'Jam',
      minute : 'Menit',
      second : 'Detik',
      registerEvent : 'Pendaftaran Event',
      expired : 'Expired',
      fullName : 'Nama Lengkap',
      birthdate : 'Tanggal Lahir',
      hintFullName : 'Sesuai dengan KTP / KK',
      hintBirthday : 'Pilih Tanggal Lahir',
      pleaseRegister : 'Silahkan Daftar',
      dataUser : 'Data Pengguna',
      alreadyHaveAccount : 'Sudah punya akun',
      back : 'Kembali',
      forgotPass : 'Lupa Kata Sandi',
      home : 'Beranda',
      event : 'Event',
      profile : 'Profil',
      verify : 'Verifikasi',
      createNewPassword : 'Buat Sandi Baru',
      newPass : 'Sandi Baru',
      confirmNewPass : 'Konfirmasi Sandi Baru',
      inputMin6Char : 'Masukkan minimal 6 Karakter',
      repeatPass : 'Ulangi kata sandi',
      liveScore : "Live Score",
      male : "Laki-Laki",
      female : "Perempuan",
      resendOtp : "Kirim Ulang OTP",
      resetOtp : "Atur Ulang Sandi",
      inputCode : "Masukkan Kode",
      register : "Daftar",
      next : "Selanjutnya",
      payNow : "Bayar Sekarang",
      somethingWentWrong : "Terjadi kesalahan, harap ulangi kembali",
      verifyPhotoProfile : "Verifikasi Foto Profil",
      goToEditProfile : "Ke Edit Profil",
      thereIsUpdateNeedUploadPhoto : "Terdapat pembaharuan dalam ketentuan foto profil, lihat lebih lanjut dan abaikan jika foto sudah sesuai",
      pleaseVerifyDataToFollowMatch : "Harap melakukan verifikasi data jika Anda akan mengikuti pertandingan.",
      yourAccountRequestedVerify : "Akun Anda dalam proses pengajuan. Silakan tunggu hingga proses verifikasi selesai.",
      seeDetail : "Lihat Detail",
      requestRejected : "Pengajuan ditolak. Silakan ajukan ulang verifikasi data Anda. Catatan: KTP Tidak jelas. Catatan :",
      reRequest : "Ajukan Ulang",
      yourAccountVerified : "Akun Anda telah terverifikasi",
      failedGetFaq : "Gagal mendapatkan data F.A.Q",
      officialPayment : "Pembayaran Official",
      backToMainpage : "Kembali ke Halaman Utama",
      msgSuccessRequestVerify : "Terima kasih telah melengkapi data. Data Anda akan diverifikasi dalam 1x24 jam",
      noDescription : "Tidak ada Deskripsi",
      faq : "FAQ",
      registerYourselfsoon : "Segera daftarkan dirimu dan timmu pada kompetisi",
      earlyBirdUntil : "Early Bird sampai",
      all : "Semua",
      payment : "Pembayaran",
      qualification : "Kualifikasi",
      elimination : "Eliminasi",
      myEvent : "Event Saya",
      participant : "Peserta",
      document : "Dokumen",
      match : "Pertandingan",
      comingSoon : "Coming Soon",
      eventName : "Nama Event",
      eventType : "Tipe Event",
      location : "Lokasi",
      date : "Tanggal",
      editBoundary : "Batas edit",
      listParticipant : "daftar peserta",
      maxHmin1Event : "maksimal H-1 event dilaksanakan",
      dataRegistrant : "Data Pendaftar",
      nameRegistrant : "Nama Pendaftar",
      phoneNumber : "Nomor Telepon",
      teamName : "Nama Tim",
      clubName : "Nama Klub",
      changeParticipant : "Ubah Peserta",
      chooseParticipant : "Pilih Peserta",
      alreadyAdded : "sudah ditambahkan sebelumnya",
      pleaseChooseParticipant1First : "Harap pilih Peserta 1 terlebih dahulu",
      pleaseChooseParticipant2First : "Harap pilih Peserta 2 terlebih dahulu",
      pleaseChooseParticipant3First : "Harap pilih Peserta 3 terlebih dahulu",
      pleaseChooseParticipant4First : "Harap pilih Peserta 4 terlebih dahulu",
    },
  };
}