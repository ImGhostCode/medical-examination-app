class SubclinicDesignationEntity {
  String id;
  String ref;
  List<Para> para;
  int encounter;
  String fileName;
  String pageSize;

  SubclinicDesignationEntity(
      {required this.id,
      required this.ref,
      required this.para,
      required this.encounter,
      required this.fileName,
      required this.pageSize});
}

class Para {
  String code;
  String value;

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