class Booking {
  final String id, voucherNo,customerName, status;
  final double total;
  final DateTime date;
  final String billwiseStatus;
  Booking({
    required this.id,
    required this.voucherNo,
    required this.date,
    required this.customerName,
    required this.status,
    required this.total,
    required this.billwiseStatus,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      voucherNo: json['VoucherNo'] as String,
      date:DateTime.parse( json['Date']),
      customerName: json['CustomerName'] as String,
      status: json['Status'] as String,
      billwiseStatus: json['billwise_status'] ?? '',
      total: (json['GrandTotal_Rounded'] as num).toDouble(),
    );
  }
}
