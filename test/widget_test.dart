import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:indones_ai/main.dart';

// Fake implementations for testing
class FakeFlutterTts implements FlutterTts {
  @override
  Future<dynamic> speak(String text) async => 1;

  @override
  Future<dynamic> stop() async => 1;

  @override
  Future<dynamic> setLanguage(String language) async => 1;

  @override
  Future<dynamic> setSpeechRate(double rate) async => 1;

  @override
  Future<dynamic> setVolume(double volume) async => 1;

  @override
  Future<dynamic> setPitch(double pitch) async => 1;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeFirebaseFirestore extends Fake implements FirebaseFirestore {
  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) {
    return FakeCollectionReference();
  }
}

class FakeCollectionReference extends Fake
    implements CollectionReference<Map<String, dynamic>> {
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> get([GetOptions? options]) async {
    return FakeQuerySnapshot();
  }

  @override
  String get path => 'fake/path';

  @override
  Future<DocumentReference<Map<String, dynamic>>> add(
      Map<String, dynamic> data) async {
    return createFakeDocumentReference();
  }

  @override
  Query<Map<String, dynamic>> where(
    Object field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    Iterable<Object?>? arrayContainsAny,
    Iterable<Object?>? whereIn,
    Iterable<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return FirebaseFirestore.instance.collection('fake').where(field);
  }
}

class FakeQuerySnapshot extends Fake
    implements QuerySnapshot<Map<String, dynamic>> {
  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs => [];

  @override
  int get size => 0;

  @override
  SnapshotMetadata get metadata => FakeSnapshotMetadata();

  @override
  List<DocumentChange<Map<String, dynamic>>> get docChanges => [];
}

class FakeSnapshotMetadata implements SnapshotMetadata {
  @override
  bool get hasPendingWrites => false;

  @override
  bool get isFromCache => false;
}

// Factory function to create DocumentReference without extending the sealed class
DocumentReference<Map<String, dynamic>> createFakeDocumentReference() {
  return FirebaseFirestore.instance.collection('fake').doc('fake-id');
}

class FakeFirebaseAuth extends Fake implements FirebaseAuth {
  @override
  User? get currentUser => null;

  @override
  Future<UserCredential> signInAnonymously() async {
    return FakeUserCredential();
  }
}

class FakeUserCredential extends Fake implements UserCredential {
  @override
  User? get user => null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeFlutterTts fakeTts;
  late FakeFirebaseFirestore fakeFirestore;
  late FakeFirebaseAuth fakeAuth;

  setUp(() {
    fakeTts = FakeFlutterTts();
    fakeFirestore = FakeFirebaseFirestore();
    fakeAuth = FakeFirebaseAuth();
  });

  testWidgets('App initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(
      flutterTts: fakeTts,
      firestore: fakeFirestore,
      auth: fakeAuth,
    ));

    // Verify the app renders without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
