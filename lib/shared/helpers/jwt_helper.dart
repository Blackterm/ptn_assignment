import 'dart:convert';

String extractUserIdFromToken(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Geçersiz JWT formatı.');
    }

    final payload = parts[1];
    final normalizedPayload = base64Url.normalize(payload);
    final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));

    final payloadMap = json.decode(decodedPayload);

    return payloadMap['user_id']?.toString() ?? 'Kullanıcı ID bulunamadı';
  } catch (e) {
    return 'Hata: $e';
  }
}
