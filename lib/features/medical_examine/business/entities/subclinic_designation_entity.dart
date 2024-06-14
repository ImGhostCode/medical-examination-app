class SubclinicDesignationEntity {
  String? id;
  String? ref;
  List<Para>? para;
  int? encounter;
  String? fileName;
  String? pageSize;
  String? code;

  SubclinicDesignationEntity(
      {this.id,
      this.ref,
      this.para,
      this.encounter,
      this.fileName,
      this.pageSize,
      this.code});
}

class Para {
  String code;
  dynamic value;

  Para({required this.code, required this.value});
}

/*
 {
            "id": "240613081342802995",
            "ref": "49f28c5a-0d75-4677-9684-2448591dcde9",
            "para": [
                {
                    "code": "code",
                    "value": "msr_005_01"
                },
                {
                    "code": "encounter",
                    "value": 23088696
                },
                {
                    "code": "id",
                    "value": "240613081342802995"
                }
            ],
            "encounter": 23088696,
            "file_name": "msr_005_01_23088696_240613081342802995",
            "page_size": "A5_landscape"
        }
*/