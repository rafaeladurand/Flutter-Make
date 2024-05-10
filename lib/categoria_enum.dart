enum CategoriaEnum {
  base,
  corretivo,
  sombra,
  batom,
  outros;

  String get toLabel {
    switch (this) {
      case CategoriaEnum.base:
        return 'Base';
      case CategoriaEnum.batom:
        return 'Batom';
      case CategoriaEnum.sombra:
        return 'Sombra';
      case CategoriaEnum.corretivo:
        return 'Corretivo';
      case CategoriaEnum.outros:
        return 'Outros';
    }
  }

  String get toJson {
    switch (this) {
      case CategoriaEnum.base:
        return 'Base';
      case CategoriaEnum.batom:
        return 'Batom';
      case CategoriaEnum.sombra:
        return 'Sombra';
      case CategoriaEnum.corretivo:
        return 'Corretivo';
      default:
        return 'Outros';
    }
  }

  static CategoriaEnum? fromJson(String? value) {
    switch (value) {
      case 'Base':
        return CategoriaEnum.base;
      case 'Batom':
        return CategoriaEnum.batom;
      case 'Sombra':
        return CategoriaEnum.sombra;
      case 'Corretivo':
        return CategoriaEnum.corretivo;
      case 'Outros':
        return CategoriaEnum.outros;
      default:
        return null;
    }
  }
}
