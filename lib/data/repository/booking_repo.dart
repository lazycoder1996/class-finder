import 'package:get/get_connect/connect.dart';
import 'package:timetable_app/data/api/api_client.dart';
import 'package:timetable_app/utils/app_constants.dart';

import '../models/body/booking_body.dart';

class BookingRepo {
  final ApiClient apiClient;

  const BookingRepo({required this.apiClient});

  // DELETE BOOKING
  Future<Response> deleteBooking(int bookingId) async {
    return await apiClient.deleteData('${AppConstants.bookings}/$bookingId');
  }

  // EDIT BOOKING
  Future<Response> editBooking(int bookingId, body) async {
    return await apiClient.putData('${AppConstants.bookings}/$bookingId', body);
  }

  // CREATE BOOKING
  Future<Response> addBooking(BookingBody body) async {
    return await apiClient.postData(AppConstants.schedules, body.toMap());
  }

  // GET USER BOOKINGS
  Future<Response> getUserBookings(Map<String, dynamic> query) async {
    return await apiClient.getData(AppConstants.bookings, query: query);
  }
}
