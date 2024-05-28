class DepartmentEntity {
  String code;
  String type;
  bool admin;
  bool allow;
  int value;
  bool dDefault;
  String display;
  String typeCode;
  bool roleGroup;
  String typeDisplay;

  DepartmentEntity({
    required this.code,
    required this.type,
    required this.admin,
    required this.allow,
    required this.value,
    required this.dDefault,
    required this.display,
    required this.typeCode,
    required this.roleGroup,
    required this.typeDisplay,
  });
}


/* Department data example:
{
            "code": "9362c2cd-27f6-45f2-b868-e4afbf2fc685",
            "type": "dept",
            "admin": false,
            "allow": true,
            "value": 29587,
            "default": false,
            "display": "Khoa Bán cấp tính Nam",
            "type_code": "dept",
            "role_group": true,
            "type_display": ""
        },
*/