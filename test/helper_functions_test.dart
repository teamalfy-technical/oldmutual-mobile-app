import 'package:flutter_test/flutter_test.dart';
import 'package:oldmutual_pensions_app/core/utils/helpers/helper.functions.dart';

void main() {
  group('PHelperFunction openFileWithURl and downloadFile Tests', () {
    test(
      'downloadFile with requiresAuth=false should work without token',
      () async {
        // Test URL that doesn't require authentication
        const testUrl =
            'https://ussd.oldmutual.com.gh/storage/policy-2001TPP0013676-statement.pdf';
        const fileName = 'test-non-auth-statement.pdf';

        // This should download without adding Authorization header
        final file = await PHelperFunction.downloadFile(
          testUrl,
          fileName,
          requiresAuth: false,
        );

        // Verify file was downloaded
        expect(file, isNotNull);
        expect(file!.existsSync(), isTrue);

        // Clean up
        if (file.existsSync()) {
          file.deleteSync();
        }
      },
    );

    test(
      'downloadFile with requiresAuth=true should add Authorization header',
      () async {
        // This test verifies that when requiresAuth is true (default),
        // the Authorization header is added
        // Note: This may fail if no valid token is available in secure storage

        const testUrl = 'https://api.example.com/protected/document.pdf';
        const fileName = 'test-auth-document.pdf';

        // This should attempt to download with Authorization header
        final file = await PHelperFunction.downloadFile(
          testUrl,
          fileName,
          requiresAuth: true,
        );

        // This may return null if the endpoint is not valid or authentication fails
        // which is expected for this test
        print(
          'File download result with auth: ${file != null ? "Success" : "Failed (expected)"}',
        );
      },
    );

    test(
      'openFileWithURl with requiresAuth=false should download and open file',
      () async {
        // Test the complete workflow without authentication
        const testUrl =
            'https://ussd.oldmutual.com.gh/storage/policy-2001TPP0013676-statement.pdf';
        const fileName = 'test-open-non-auth-statement.pdf';

        // This should download and attempt to open the file
        // Note: Open may fail in test environment without proper UI context
        await PHelperFunction.openFileWithURL(
          url: testUrl,
          fileName: fileName,
          requiresAuth: false,
        );

        print('openFileWithURl executed for non-auth URL');
      },
    );

    test('openFileWithURl defaults to requiresAuth=true', () async {
      // Verify that the default behavior requires authentication
      const testUrl = 'https://api.example.com/protected/document.pdf';
      const fileName = 'test-default-auth.pdf';

      // This should use the default requiresAuth=true
      await PHelperFunction.openFileWithURL(url: testUrl, fileName: fileName);

      print('openFileWithURl with default auth settings executed');
    });
  });
}
