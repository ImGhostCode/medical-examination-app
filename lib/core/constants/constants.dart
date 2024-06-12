class RouteNames {
  static const String home = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String accountSetting = '/account-setting';

  static const String tools = '/tools';

  static const String crePatientProfile = '/create-patient-profile';
  static const String searchPatients = '/search-patients';

  static const String medialExamine = '/medial-examine';
  static const String addSignal = '/add-signal';
  static const String addStreatmentSheet = '/add-streatment-sheet';
  static const String editStreatmentSheet = '/edit-streatment-sheet';

  static const String requestClinicalService = '/request-clinical-service';

  static const String addCareSheet = '/add-care-sheet';
  static const String editCareSheet = '/edit-care-sheet';
}

String kTemplate = 'template';

// Response
String kCode = 'code';
String kMessage = 'message';
String kStatus = 'status';
String kType = 'type';
String kData = 'value';

// User
String kId = 'id';
String kWork = 'work';
String kToken = 'token';
String kDisplay = 'display';
String kExpired = 'expired';
String kUserName = 'user_name';
String kIsChangeNow = 'is_change_now';
String kFunctions = 'functions';
String kOrganization = 'organization';

// Function
String kAllow = 'allow';
String kFDefault = 'default';

// Organization
String kOrganizationCode = 'code';
String kValue = 'value';

// Department
String kAdmin = 'admin';
String kDDefault = 'default';
String kTypeCode = 'type_code';
String kRoleGroup = 'role_group';
String kTypeDisplay = 'type_display';

// Patient
// String kCode = 'code';
String kName = 'name';
String kStart = 'start';
String kGender = 'gender';
String kSubject = 'subject';
String kBirthdate = 'birthdate';
String kEncounter = 'encounter';
String kFeeObject = 'fee_object';
String kClassifyCode = 'classify_code';
String kClassifyName = 'classify_name';
String kProcessingStatus = 'processing_status';

// Signal
String kSeq = 'seq';
String kValueString = 'value_string';
String kUnit = 'unit';
String kAuthored = 'authored';
String kPerformer = 'performer';
String kLocation = 'location';
String kRequester = 'requester';
String kUnitRoot = 'unit_root';
String kNote = 'note';

// Subclinic Service
String kCc = 'cc';
String kDv = 'dv';
String kTt = 'tt';
String kPrice = 'price';
String kReport = 'report';
String kChoosed = 'choosed';
String kGroupId = 'group_id';
String kQuantity = 'quantity';
String kIsPublic = 'is_public';
String kObsGroup = 'obs_group';
String kCreateUid = 'create_uid';
String kObsResult = 'obs_result';
String kEditQuantity = 'edit_quantity';
String kPriceRequired = 'price_required';
String kPriceInsurance = 'price_insurance';

// Streatment Sheet
String kDoctor = 'doctor';
String kRequest = 'request';
String kCreated = 'created';
