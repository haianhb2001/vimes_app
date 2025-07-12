class MaterialItem {
  String? id; // Document ID từ subcollection
  String code;
  String name;
  String unit;
  int quantityDocument;
  int quantityReceived;
  double unitPrice;
  double totalPrice;
  int index;

  MaterialItem({
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

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'unit': unit,
      'quantityDocument': quantityDocument,
      'quantityReceived': quantityReceived,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'index': index,
    };
  }

  // Create from JSON
  factory MaterialItem.fromJson(Map<String, dynamic> json, String documentId) {
    return MaterialItem(
      id: documentId,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      quantityDocument: json['quantityDocument'] ?? 0,
      quantityReceived: json['quantityReceived'] ?? 0,
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      index: json['index'] ?? 0,
    );
  }
}

class WarehouseReceipt {
  String? id; // Document ID từ Firestore
  String approvedBy;
  String createdBy;
  String creditAccount;
  DateTime date;
  String debitAccount;
  String deliveredBy;
  String department;
  String number;
  int originalDocumentCount;
  String receivedBy;
  DateTime referenceDate;
  String referenceNumber;
  String referenceOrganization;
  String referenceType;
  String storeKeeper;
  double totalAmount;
  String totalAmountText;
  String unit;
  DateTime createdAt; // Thời gian tạo

  WarehouseReceipt({
    this.id,
    required this.approvedBy,
    required this.createdBy,
    required this.creditAccount,
    required this.date,
    required this.debitAccount,
    required this.deliveredBy,
    required this.department,
    required this.number,
    required this.originalDocumentCount,
    required this.receivedBy,
    required this.referenceDate,
    required this.referenceNumber,
    required this.referenceOrganization,
    required this.referenceType,
    required this.storeKeeper,
    required this.totalAmount,
    required this.totalAmountText,
    required this.unit,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'approvedBy': approvedBy,
      'createdBy': createdBy,
      'creditAccount': creditAccount,
      'date': date.toIso8601String(),
      'debitAccount': debitAccount,
      'deliveredBy': deliveredBy,
      'department': department,
      'number': number,
      'originalDocumentCount': originalDocumentCount,
      'receivedBy': receivedBy,
      'referenceDate': referenceDate.toIso8601String(),
      'referenceNumber': referenceNumber,
      'referenceOrganization': referenceOrganization,
      'referenceType': referenceType,
      'storeKeeper': storeKeeper,
      'totalAmount': totalAmount,
      'totalAmountText': totalAmountText,
      'unit': unit,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory WarehouseReceipt.fromJson(Map<String, dynamic> json, String documentId) {
    return WarehouseReceipt(
      id: documentId,
      approvedBy: json['approvedBy'] ?? '',
      createdBy: json['createdBy'] ?? '',
      creditAccount: json['creditAccount'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      debitAccount: json['debitAccount'] ?? '',
      deliveredBy: json['deliveredBy'] ?? '',
      department: json['department'] ?? '',
      number: json['number'] ?? '',
      originalDocumentCount: json['originalDocumentCount'] ?? 0,
      receivedBy: json['receivedBy'] ?? '',
      referenceDate: DateTime.tryParse(json['referenceDate'] ?? '') ?? DateTime.now(),
      referenceNumber: json['referenceNumber'] ?? '',
      referenceOrganization: json['referenceOrganization'] ?? '',
      referenceType: json['referenceType'] ?? '',
      storeKeeper: json['storeKeeper'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      totalAmountText: json['totalAmountText'] ?? '',
      unit: json['unit'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
