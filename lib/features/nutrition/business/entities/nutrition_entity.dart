class NutritionEntity {
  int code;
  String unit;
  int price;
  String report;
  bool choosed;
  String display;
  bool editQuantity;
  int priceRequired;
  int priceInsurance;
  int? quantity;

  NutritionEntity(
      {required this.code,
      required this.unit,
      required this.price,
      required this.report,
      required this.choosed,
      required this.display,
      required this.editQuantity,
      required this.priceRequired,
      required this.priceInsurance,
      this.quantity = 1});
}

/*
        {
            "code": 30994,
            "unit": "ngày",
            "price": 46000,
            "report": "FEE_014",
            "choosed": false,
            "display": "CHÁO THỊT (BT02_M)",
            "edit_quantity": false,
            "price_required": 0,
            "price_insurance": 0
        },
*/