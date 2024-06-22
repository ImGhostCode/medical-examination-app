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
  static const String patientServices = '/patient-services';
  static const String assignService = '/assign-service';

  static const String addCareSheet = '/add-care-sheet';
  static const String editCareSheet = '/edit-care-sheet';

  static const String assignNutrition = '/assign-nutrition';
  static const String addNutritionAssignation = '/add-nutrition-assignation';
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
String kBirthdate = 'birthdate';
String kGender = 'gender';
String kEthnic = 'ethnic';
String kStart = 'start';
String kEnd = 'end';
String kSubject = 'subject';
String kEncounter = 'encounter';
String kFeeObject = 'fee_object';
String kClassifyCode = 'classify_code';
String kClassifyName = 'classify_name';
String kProcessingStatus = 'processing_status';
String kOpen = 'open';
String kPictures = 'pictures';
String kBirthYear = 'birth_year';
String kDateStart = 'date_start';
String kDiagnostic = 'diagnostic';
String kNationality = 'nationality';
String kJob = 'job';
String kAddress = 'address';
String kGenderName = 'gender_name';
String kMedicalClass = 'medical_class';
String kMedicalObject = 'medical_object';
String kTreatmentStart = 'treatment_start';
String kTemplateClassify = 'template_classify';
String kCi = 'ci';
String kHealthInsuranceCard = 'card';
String kDateEnd = 'date_end';
String kLiteracy = 'literacy';
String kReligion = 'religion';
String kRelativeInfo = 'relative_info';

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
String kRefIdx = 'ref_idx';
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
String kResult = 'result';
String kCreators = 'creators';
String kIsCard = 'is_card';
String kEmergency = 'emergency';
String kOption = 'option';
String kRef = 'ref';
String kPara = 'para';
String kFileName = 'file_name';
String kPageSize = 'page_size';
String kOwner = 'owner';
String kService = 'service';
String kReportCode = 'report_code';

// Streatment Sheet
String kDoctor = 'doctor';
String kRequest = 'request';
String kCreated = 'created';

// CI
String kNumber = 'number';
String kDate = 'date';
String kIssuer = 'issuer';

// Health Insurance Card
String kRate = 'rate';
String kPeriod = 'period';
String kDelegate = 'delegate';
String kExpensed = 'expensed';
String kCardObject = 'card_object';
String kCrdAd = 'crd_ad';
String kCrdCt = 'crd_ct';
String kCrdLa = 'crd_la';

// ICD
String kReason = 'reason';
String kAccident = 'accident';
String kIsLeftRight = 'is_left_right';
