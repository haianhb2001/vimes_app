import 'package:flutter_test/flutter_test.dart';
import 'package:vimes_app/core/utils/either.dart';

void main() {
  group('Either Tests', () {
    test('Left should contain left value', () {
      const leftValue = 'error';
      const either = Left<String, int>(leftValue);

      expect(either.isLeft, true);
      expect(either.isRight, false);
      expect(either.left, leftValue);
    });

    test('Right should contain right value', () {
      const rightValue = 42;
      const either = Right<String, int>(rightValue);

      expect(either.isLeft, false);
      expect(either.isRight, true);
      expect(either.right, rightValue);
    });

    test('fold should call left function for Left', () {
      const either = Left<String, int>('error');
      final result = either.fold((left) => 'Left: $left', (right) => 'Right: $right');

      expect(result, 'Left: error');
    });

    test('fold should call right function for Right', () {
      const either = Right<String, int>(42);
      final result = either.fold((left) => 'Left: $left', (right) => 'Right: $right');

      expect(result, 'Right: 42');
    });

    test('Left equality', () {
      const either1 = Left<String, int>('error');
      const either2 = Left<String, int>('error');
      const either3 = Left<String, int>('different');

      expect(either1, equals(either2));
      expect(either1, isNot(equals(either3)));
    });

    test('Right equality', () {
      const either1 = Right<String, int>(42);
      const either2 = Right<String, int>(42);
      const either3 = Right<String, int>(100);

      expect(either1, equals(either2));
      expect(either1, isNot(equals(either3)));
    });

    test('Left and Right should not be equal', () {
      const left = Left<String, int>('error');
      const right = Right<String, int>(42);

      expect(left, isNot(equals(right)));
    });

    test('toString should return correct representation', () {
      const left = Left<String, int>('error');
      const right = Right<String, int>(42);

      expect(left.toString(), 'Left(error)');
      expect(right.toString(), 'Right(42)');
    });
  });
}
