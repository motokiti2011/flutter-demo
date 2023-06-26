enum ProductCategory {
  food,
  chemicals,
  autumn,
  weapon,
}

extension CategoryExtension on ProductCategory {
  static final names = {
    ProductCategory.food: '食品',
    ProductCategory.chemicals: '薬品',
    ProductCategory.autumn: '武器',
    ProductCategory.weapon: '防具'
  };

  String get typeName => names[this]!;
}
