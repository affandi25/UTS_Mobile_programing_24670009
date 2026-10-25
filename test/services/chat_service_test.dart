import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_2/services/chat_service.dart';

void main() {
  group('ChatService Tests', () {
    late ChatService chatService;

    setUp(() {
      chatService = ChatService.instance;
    });

    test('Memiliki nomor telepon WhatsApp Admin default yang valid', () {
      expect(chatService.adminPhoneNumber, equals('6281234567890'));
      expect(chatService.adminPhoneNumber.startsWith('62'), isTrue);
    });

    test('Menghasilkan link WhatsApp wa.me dengan pesan default', () {
      final uri = chatService.getWhatsAppUrl(customerName: 'Yusuf Affandi');
      expect(uri.scheme, equals('https'));
      expect(uri.host, equals('wa.me'));
      expect(uri.path, equals('/6281234567890'));
      expect(uri.queryParameters['text'], contains('Yusuf Affandi'));
      expect(uri.queryParameters['text'], contains('SweetBite'));
    });

    test('Menghasilkan link WhatsApp dengan pesan kustom pelanggan', () {
      const customQuery = 'Apakah donat choco almond masih tersedia?';
      final uri = chatService.getWhatsAppUrl(
        customMessage: customQuery,
        customerName: 'Budi',
      );
      expect(uri.host, equals('wa.me'));
      expect(uri.queryParameters['text'], equals(customQuery));
    });
  });
}
