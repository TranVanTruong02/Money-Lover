class StatusModel {
  int? categoryId;
  String? caName;
  String? caImage;
  int? sumMoney;
  List<CategoryDetails>? categoryDetails;

  StatusModel(
      {categoryId,
      caName,
      caImage,
      sumMoney,
      categoryDetails});

  StatusModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    caName = json['ca_name'];
    caImage = json['ca_image'];
    sumMoney = json['sum_money'];
    if (json['category_details'] != null) {
      categoryDetails = <CategoryDetails>[];
      json['category_details'].forEach((v) {
        categoryDetails!.add(CategoryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId;
    data['ca_name'] = caName;
    data['ca_image'] = caImage;
    data['sum_money'] = sumMoney;
    if (categoryDetails != null) {
      data['category_details'] =
          categoryDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetails {
  int? categoryDetailsId;
  int? categoryId;
  String? cadName;
  String? cadImage;
  int? sumMoney;
  List<Pay>? pay;

  CategoryDetails(
      {categoryDetailsId,
      categoryId,
      cadName,
      cadImage,
      sumMoney,
      pay});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    categoryDetailsId = json['category_details_id'];
    categoryId = json['category_id'];
    cadName = json['cad_name'];
    cadImage = json['cad_image'];
    sumMoney = json['sum_money'];
    if (json['pay'] != null) {
      pay = <Pay>[];
      json['pay'].forEach((v) {
        pay!.add(Pay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_details_id'] = categoryDetailsId;
    data['category_id'] = categoryId;
    data['cad_name'] = cadName;
    data['cad_image'] = cadImage;
    data['sum_money'] = sumMoney;
    if (pay != null) {
      data['pay'] = pay!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pay {
  int? payId;
  int? categoryDetailsId;
  int? pType;
  int? pMoney;
  String? pDate;

  Pay(
      {payId,
      categoryDetailsId,
      pType,
      pMoney,
      pDate});

  Pay.fromJson(Map<String, dynamic> json) {
    payId = json['pay_id'];
    categoryDetailsId = json['category_details_id'];
    pType = json['p_type'];
    pMoney = json['p_money'];
    pDate = json['p_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pay_id'] = payId;
    data['category_details_id'] = categoryDetailsId;
    data['p_type'] = pType;
    data['p_money'] = pMoney;
    data['p_date'] = pDate;
    return data;
  }
}