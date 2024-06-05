import 'package:crystalclear/core/enum/service_status.dart';

class ServiceReturn {
  ServiceReturn({
    required this.status,
    this.message,
    this.data,
  });

  final ServiceStatus status;
  final String? message;
  final dynamic data;
}