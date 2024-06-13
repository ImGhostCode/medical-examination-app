// class HealthInsuranceCardEntity {
//   final String publisher;
//   final String code;
//   final String start;
//   final String end;
//   final String delegate;
//   final String address;
//   final String living;
//   final String longtime;
//   final String timeFree;
//   final bool unline;

//   HealthInsuranceCardEntity({
//     required this.publisher,
//     required this.code,
//     required this.start,
//     required this.end,
//     required this.delegate,
//     required this.address,
//     required this.living,
//     required this.longtime,
//     required this.timeFree,
//     required this.unline,
//   });
// }

class HealthInsuranceCardEntity {
  final int seq;
  final String code;
  final int rate;
  final PeriodEntity period;
  final String delegate;
  final ExpensedEntity expensed;
  final List<dynamic> pictures;
  final String cardObject;

  HealthInsuranceCardEntity({
    required this.seq,
    required this.code,
    required this.rate,
    required this.period,
    required this.delegate,
    required this.expensed,
    required this.pictures,
    required this.cardObject,
  });

  // Add fromJson and toJson methods here
}

class ExpensedEntity {
  final String crdAd;
  final String crdCt;
  final String crdLa;

  ExpensedEntity({
    required this.crdAd,
    required this.crdCt,
    required this.crdLa,
  });

  // Add fromJson and toJson methods here
}

class PeriodEntity {
  final String end;
  final String start;

  PeriodEntity({
    required this.end,
    required this.start,
  });

  // Add fromJson and toJson methods here
}

/*
       "card": {
            "seq": 2403191044786,
            "code": "PO447895232652001001",
            "rate": 80,
            "period": {
                "end": "2025-01-01",
                "start": "2024-01-01"
            },
            "delegate": "01001",
            "expensed": {
                "crd_ad": "12313123",
                "crd_ct": "80",
                "crd_la": "K2"
            },
            "pictures": [],
            "card_object": "ICL_01"
        },
*/
