class ICDEntity {
  final String code;
  final bool reason;
  final String display;
  final bool accident;
  final bool isLeftRight;
  bool isSelected;

  ICDEntity({
    required this.code,
    required this.reason,
    required this.display,
    required this.accident,
    required this.isLeftRight,
    this.isSelected = false,
  });
} 

/*
 {
            "code": "A00",
            "reason": false,
            "display": "Bệnh tả",
            "accident": false,
            "is_left_right": false
        },
*/