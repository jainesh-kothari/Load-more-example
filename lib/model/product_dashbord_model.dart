class ProductDashBoardModel {
  int status;
  String message;
  Result result;

  ProductDashBoardModel({this.status, this.message, this.result});

  ProductDashBoardModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    result =
    json['Result'] != null ? new Result.fromJson(json['Result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<Category> category;

  Result({this.category});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['Category'] != null) {
      category = new List<Category>();
      json['Category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['Category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String name;
  int isAuthorize;
  int update080819;
  int update130919;
  List<SubCategories> subCategories;

  Category(
      {this.id,
        this.name,
        this.isAuthorize,
        this.update080819,
        this.update130919,
        this.subCategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isAuthorize = json['IsAuthorize'];
    update080819 = json['Update080819'];
    update130919 = json['Update130919'];
    if (json['SubCategories'] != null) {
      subCategories = new List<SubCategories>();
      json['SubCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['IsAuthorize'] = this.isAuthorize;
    data['Update080819'] = this.update080819;
    data['Update130919'] = this.update130919;
    if (this.subCategories != null) {
      data['SubCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int id;
  String name;
  List<Product> product;

  SubCategories({this.id, this.name, this.product});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    if (json['Product'] != null) {
      product = new List<Product>();
      json['Product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    if (this.product != null) {
      data['Product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String name;
  String priceCode;
  String imageName;
  int id;

  Product({this.name, this.priceCode, this.imageName, this.id});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    priceCode = json['PriceCode'];
    imageName = json['ImageName'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['PriceCode'] = this.priceCode;
    data['ImageName'] = this.imageName;
    data['Id'] = this.id;
    return data;
  }
}