class MaterialItem {
  final String? id;
  final String code;
  final String name;
  final String unit;
  final int quantityDocument;
  final int quantityReceived;
  final double unitPrice;
  final double totalPrice;
  final int index;

  const MaterialItem({
    this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.quantityDocument,
    required this.quantityReceived,
    required this.unitPrice,
    required this.totalPrice,
    required this.index,
  });

  MaterialItem copyWith({
    String? id,
    String? code,
    String? name,
    String? unit,
    int? quantityDocument,
    int? quantityReceived,
    double? unitPrice,
    double? totalPrice,
    int? index,
  }) {
    return MaterialItem(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      quantityDocument: quantityDocument ?? this.quantityDocument,
      quantityReceived: quantityReceived ?? this.quantityReceived,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      index: index ?? this.index,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MaterialItem &&
        other.id == id &&
        other.code == code &&
        other.name == name &&
        other.unit == unit &&
        other.quantityDocument == quantityDocument &&
        other.quantityReceived == quantityReceived &&
        other.unitPrice == unitPrice &&
        other.totalPrice == totalPrice &&
        other.index == index;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      code,
      name,
      unit,
      quantityDocument,
      quantityReceived,
      unitPrice,
      totalPrice,
      index,
    );
  }

  @override
  String toString() {
    return 'MaterialItem(id: $id, code: $code, name: $name, unit: $unit, quantityDocument: $quantityDocument, quantityReceived: $quantityReceived, unitPrice: $unitPrice, totalPrice: $totalPrice, index: $index)';
  }
}
