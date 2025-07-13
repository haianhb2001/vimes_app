class WarehouseReceipt {
  final String? id;
  final String approvedBy;
  final String createdBy;
  final String creditAccount;
  final DateTime date;
  final String debitAccount;
  final String deliveredBy;
  final String department;
  final String number;
  final int originalDocumentCount;
  final String receivedBy;
  final DateTime referenceDate;
  final String referenceNumber;
  final String referenceOrganization;
  final String referenceType;
  final String storeKeeper;
  final double totalAmount;
  final String totalAmountText;
  final String unit;
  final DateTime createdAt;

  const WarehouseReceipt({
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
    required this.createdAt,
  });

  WarehouseReceipt copyWith({
    String? id,
    String? approvedBy,
    String? createdBy,
    String? creditAccount,
    DateTime? date,
    String? debitAccount,
    String? deliveredBy,
    String? department,
    String? number,
    int? originalDocumentCount,
    String? receivedBy,
    DateTime? referenceDate,
    String? referenceNumber,
    String? referenceOrganization,
    String? referenceType,
    String? storeKeeper,
    double? totalAmount,
    String? totalAmountText,
    String? unit,
    DateTime? createdAt,
  }) {
    return WarehouseReceipt(
      id: id ?? this.id,
      approvedBy: approvedBy ?? this.approvedBy,
      createdBy: createdBy ?? this.createdBy,
      creditAccount: creditAccount ?? this.creditAccount,
      date: date ?? this.date,
      debitAccount: debitAccount ?? this.debitAccount,
      deliveredBy: deliveredBy ?? this.deliveredBy,
      department: department ?? this.department,
      number: number ?? this.number,
      originalDocumentCount: originalDocumentCount ?? this.originalDocumentCount,
      receivedBy: receivedBy ?? this.receivedBy,
      referenceDate: referenceDate ?? this.referenceDate,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      referenceOrganization: referenceOrganization ?? this.referenceOrganization,
      referenceType: referenceType ?? this.referenceType,
      storeKeeper: storeKeeper ?? this.storeKeeper,
      totalAmount: totalAmount ?? this.totalAmount,
      totalAmountText: totalAmountText ?? this.totalAmountText,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WarehouseReceipt &&
        other.id == id &&
        other.approvedBy == approvedBy &&
        other.createdBy == createdBy &&
        other.creditAccount == creditAccount &&
        other.date == date &&
        other.debitAccount == debitAccount &&
        other.deliveredBy == deliveredBy &&
        other.department == department &&
        other.number == number &&
        other.originalDocumentCount == originalDocumentCount &&
        other.receivedBy == receivedBy &&
        other.referenceDate == referenceDate &&
        other.referenceNumber == referenceNumber &&
        other.referenceOrganization == referenceOrganization &&
        other.referenceType == referenceType &&
        other.storeKeeper == storeKeeper &&
        other.totalAmount == totalAmount &&
        other.totalAmountText == totalAmountText &&
        other.unit == unit &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      approvedBy,
      createdBy,
      creditAccount,
      date,
      debitAccount,
      deliveredBy,
      department,
      number,
      originalDocumentCount,
      receivedBy,
      referenceDate,
      referenceNumber,
      referenceOrganization,
      referenceType,
      storeKeeper,
      totalAmount,
      totalAmountText,
      unit,
      createdAt,
    );
  }

  @override
  String toString() {
    return 'WarehouseReceipt(id: $id, approvedBy: $approvedBy, createdBy: $createdBy, creditAccount: $creditAccount, date: $date, debitAccount: $debitAccount, deliveredBy: $deliveredBy, department: $department, number: $number, originalDocumentCount: $originalDocumentCount, receivedBy: $receivedBy, referenceDate: $referenceDate, referenceNumber: $referenceNumber, referenceOrganization: $referenceOrganization, referenceType: $referenceType, storeKeeper: $storeKeeper, totalAmount: $totalAmount, totalAmountText: $totalAmountText, unit: $unit, createdAt: $createdAt)';
  }
}
