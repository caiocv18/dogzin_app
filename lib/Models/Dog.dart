class Dog {
  final String message;
  final String status;

  Dog({this.message, this.status});

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(message: json['message'], status: json['status']);
  }
}
