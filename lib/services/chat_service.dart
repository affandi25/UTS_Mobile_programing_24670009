import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service untuk menangani komunikasi dan bantuan pelanggan langsung ke WhatsApp Admin
class ChatService {
  static final ChatService instance = ChatService._internal();
  ChatService._internal();

  /// Nomor WhatsApp Admin Resmi SweetBite Donut (format internasional tanpa '+')
  String adminPhoneNumber = '6281234567890';

  /// Mendapatkan URI WhatsApp dengan pesan ter-encode
  Uri getWhatsAppUrl({String? customMessage, String? customerName}) {
    final name = customerName?.trim().isNotEmpty == true ? customerName!.trim() : 'Pelanggan';
    final message = (customMessage != null && customMessage.trim().isNotEmpty)
        ? customMessage.trim()
        : 'Halo Admin SweetBite, saya $name ingin bertanya seputar menu dan pesanan donat.';

    final encodedMessage = Uri.encodeComponent(message);
    return Uri.parse('https://wa.me/$adminPhoneNumber?text=$encodedMessage');
  }

  /// Membuka aplikasi WhatsApp atau WhatsApp Web ke nomor Admin
  Future<bool> openWhatsAppAdmin({String? customMessage, String? customerName}) async {
    final uri = getWhatsAppUrl(customMessage: customMessage, customerName: customerName);
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        return await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      debugPrint('ChatService: Gagal membuka WhatsApp: $e');
      return false;
    }
  }
}
