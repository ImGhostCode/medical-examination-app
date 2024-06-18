class PatientSerPubResEntity {
  int? id;
  // Ext ext;
  // int org;
  String? code;
  // List<Reason> reason;
  int? requester;

  PatientSerPubResEntity(
      {this.id,
      // this.ext,
      //  this.org,
      this.code,
      // this.reason,
      this.requester});
}

/*
{
        "id": 4113496,
        "ext": {
            "note": "Lưu nè",
            "owner": {
                "id": 16631,
                "code": "bb6ab93d-4756-4850-9f03-b85c1b427fc3",
                "display": "Bs Nguyễn Tấn Tài"
            },
            "reason": {
                "text": "Bệnh thương hàn và phó thương hàn",
                "value": [
                    "A01"
                ]
            },
            "processing": "draft",
            "organization": {
                "code": "1949241c-5f56-4ec8-8f64-66860994f013",
                "value": 29583,
                "display": "Khoa Khám Bệnh"
            }
        },
        "org": 29583,
        "code": "efaf2a1a-b29e-4ac6-a150-946ca66ff298",
        "reason": [
            {
                "concept": {
                    "text": "Bệnh thương hàn và phó thương hàn"
                }
            }
        ],
        "requester": 16631
    }
*/
