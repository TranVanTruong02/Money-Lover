class RecnetNote {
  String? pDate;
  int? pMoneyType;
  int? pMoneyPay;
  int? pMoneyCollect;
  List<Category>? category;

  RecnetNote(
      {pDate,
      pMoneyType,
      pMoneyPay,
      pMoneyCollect,
      category});

  RecnetNote.fromJson(Map<String, dynamic> json) {
    pDate = json['p_date'];
    pMoneyType = json['p_money_type'];
    pMoneyPay = json['p_money_pay'];
    pMoneyCollect = json['p_money_collect'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['p_date'] = pDate;
    data['p_money_type'] = pMoneyType;
    data['p_money_pay'] = pMoneyPay;
    data['p_money_collect'] = pMoneyCollect;
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? pDate;
  int? categoryDetailsId;
  String? categoryName;
  String? cadImage;
  int? pType;
  int? pMoney;
  String? acName;

  Category(
      {pDate,
      categoryDetailsId,
      categoryName,
      cadImage,
      pType,
      pMoney,
      acName});

  Category.fromJson(Map<String, dynamic> json) {
    pDate = json['p_date'];
    categoryDetailsId = json['category_details_id'];
    categoryName = json['category_name'];
    cadImage = json['cad_image'];
    pType = json['p_type'];
    pMoney = json['p_money'];
    acName = json['ac_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['p_date'] = pDate;
    data['category_details_id'] = categoryDetailsId;
    data['category_name'] = categoryName;
    data['cad_image'] = cadImage;
    data['p_type'] = pType;
    data['p_money'] = pMoney;
    data['ac_name'] = acName;
    return data;
  }
}