import 'package:flutter_test/flutter_test.dart';
import 'package:vimes_app/core/errors/failures.dart';

void main() {
  group('Failure Tests', () {
    test('ServerFailure should contain correct message', () {
      const message = 'Server error occurred';
      const failure = ServerFailure(message);

      expect(failure.message, message);
    });

    test('NetworkFailure should contain correct message', () {
      const message = 'Network connection failed';
      const failure = NetworkFailure(message);

      expect(failure.message, message);
    });

    test('CacheFailure should contain correct message', () {
      const message = 'Cache read failed';
      const failure = CacheFailure(message);

      expect(failure.message, message);
    });

    test('ValidationFailure should contain correct message', () {
      const message = 'Invalid input data';
      const failure = ValidationFailure(message);

      expect(failure.message, message);
    });

    test('UnknownFailure should contain correct message', () {
      const message = 'Unknown error occurred';
      const failure = UnknownFailure(message);

      expect(failure.message, message);
    });

    test('Different failure types should not be equal', () {
      const serverFailure = ServerFailure('error');
      const networkFailure = NetworkFailure('error');

      expect(serverFailure, isNot(equals(networkFailure)));
    });

    test('Same failure types with same message should be equal', () {
      const failure1 = ServerFailure('error');
      const failure2 = ServerFailure('error');

      expect(failure1, equals(failure2));
    });

    test('Same failure types with different messages should not be equal', () {
      const failure1 = ServerFailure('error1');
      const failure2 = ServerFailure('error2');

      expect(failure1, isNot(equals(failure2)));
    });
  });
}
