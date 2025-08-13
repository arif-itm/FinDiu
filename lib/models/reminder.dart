class Reminder {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;
  final String type;
  final bool isCompleted;

  Reminder({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.type,
    required this.isCompleted,
  });

  Reminder copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? dueDate,
    String? type,
    bool? isCompleted,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      dueDate: DateTime.parse(json['dueDate']),
      type: json['type'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'type': type,
      'isCompleted': isCompleted,
    };
  }
}
