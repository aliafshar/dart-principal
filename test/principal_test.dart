
import 'package:principal/principal.dart';
import "package:unittest/unittest.dart";

void main() {

  group('Requirement', () {

    test('Value', () {
      var r = new Requirement<String>('banana');
      expect(
        r.value,
        equals('banana')
      );
    });

    test('Equality', () {
      var r1 = new Requirement<String>('banana');
      var r2 = new Requirement<String>('banana');
      expect(
        r1,
        equals(r2)
      );
    });

    test('In set', () {
      var r1 = new Requirement<String>('banana');
      var r2 = new Requirement<String>('banana');
      expect(
        new Set.from([r1]).containsAll(new Set.from([r2])),
        equals(true)
      );
    });
  });

  group('Principled', () {

    test('Add', () {
      var p = new Principled();
      p.add('banana');
      expect(
        p.reqs.length,
        equals(1)
      );
    });

    test('AddMany', () {
      var p = new Principled();
      p.addMany(['banana', 'apple']);
      expect(
        p.reqs.length,
        equals(2)
      );
    });

    test('Contains', () {
      var p1 = new Principled();
      p1.add('banana');
      var p2 = new Principled();
      p2.add('banana');
      expect(
        p1.contains(p2),
        equals(true)
      );
      expect(
          p2.contains(p1),
          equals(true)
      );
    });

    test('Not Contains', () {
      var p1 = new Principled();
      p1.add('banana');
      var p2 = new Principled();
      p2.add('lemon');
      print(p1.reqs);
      expect(p1.contains(p2), false);
      expect(p2.contains(p1), false);
    });

    test('Contains many', () {
      var p1 = new Principled();
      p1.addMany(['banana', 'lemon']);
      var p2 = new Principled();
      p2.add('banana');
      expect(p1.contains(p2), true);
    });
  });

  group('Identity and Permission', () {

    test('Key', () {
      var i = new Identity('idkey');
      expect(i.key, equals('idkey'));
    });

    test('Can', () {
      var i = new Identity('idkey');
      i.add('banana');
      var p = new Permission('banana');
      expect(i.can(p), true);
      expect(p.allows(i), true);
    });

    test('Can many', () {
      var i = new Identity('idkey');
      i.addMany(['banana', 'lemon']);
      var p = new Permission('banana');
      expect(i.can(p), true);
      expect(p.allows(i), true);
    });
  });


}