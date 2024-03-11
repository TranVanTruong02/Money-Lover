class RecnetNoteHome {
  int? categoryDetailsId;
  String? categoryName;
  String? cadImage;
  int? pType;
  int? pMoney;
  String? pDate;
  String? acName;

  RecnetNoteHome(
      {categoryDetailsId,
      categoryName,
      cadImage,
      pType,
      pMoney,
      pDate,
      acName});

  RecnetNoteHome.fromJson(Map<String, dynamic> json) {
    categoryDetailsId = json['category_details_id'];
    categoryName = json['category_name'];
    cadImage = json['cad_image'];
    pType = json['p_type'];
    pMoney = json['p_money'];
    pDate = json['p_date'];
    acName = json['ac_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_details_id'] = categoryDetailsId;
    data['category_name'] = categoryName;
    data['cad_image'] = cadImage;
    data['p_type'] = pType;
    data['p_money'] = pMoney;
    data['p_date'] = pDate;
    data['ac_name'] = acName;
    return data;
  }
}