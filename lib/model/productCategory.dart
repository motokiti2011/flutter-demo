enum ProductCategory {
  food,
  chemicals,
  autumn,
  weapon,
}

extension CategoryExtension on ProductCategory {
  String get name {
    switch (this) {
      case ProductCategory.food:
        return '食品';
      case ProductCategory.chemicals:
        return '薬品';
      case ProductCategory.autumn:
        return '武器';
      case ProductCategory.weapon:
        return '防具';
    }
  }

  String get id {
    switch (this) {
      case ProductCategory.food:
        return 'food';
      case ProductCategory.chemicals:
        return 'chemicals';
      case ProductCategory.autumn:
        return 'autumn';
      case ProductCategory.weapon:
        return 'weapon';
    }
  }
}
