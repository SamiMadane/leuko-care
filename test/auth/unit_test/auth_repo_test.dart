import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:leuko_care/core/helpers/network_helper.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:leuko_care/feature/auth/data/repository/auth_repo.dart';
import 'package:leuko_care/core/networking/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirestoreService extends Mock implements FirestoreService {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class FakeAuthCredential extends Fake implements AuthCredential {}

class MockInternetConnection extends Mock implements InternetConnection {}



void main() {
  setUpAll(() {
    registerFallbackValue(FakeAuthCredential());
  });
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFirebaseAuth mockAuth;
  late MockFirestoreService mockFirestoreService;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockFirebaseFirestore mockFirestoreInstance;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockDocumentSnapshot mockDoc;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocument;
  late MockDocumentSnapshot mockDocSnapshot;
  late MockGoogleSignInAccount mockGoogleUser;
  late MockGoogleSignInAuthentication mockGoogleAuth;
  late AuthRepository authRepository;
  final mockInternetConnection = MockInternetConnection();

  setUp(() {
    NetworkHelper.internetConnectionForTest = mockInternetConnection;

    when(
      () => mockInternetConnection.hasInternetAccess,
    ).thenAnswer((_) async => true);
    SharedPreferences.setMockInitialValues({});

    mockAuth = MockFirebaseAuth();
    mockFirestoreService = MockFirestoreService();
    mockGoogleSignIn = MockGoogleSignIn();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockDoc = MockDocumentSnapshot();
    mockFirestoreInstance = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocument = MockDocumentReference();
    mockDocSnapshot = MockDocumentSnapshot();
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockGoogleUser = MockGoogleSignInAccount();
    mockGoogleAuth = MockGoogleSignInAuthentication();
    // تمهيد استدعاء collection على mockFirestoreInstance
    when(
      () => mockFirestoreInstance.collection(any()),
    ).thenReturn(mockCollection);
    when(
      () => mockFirebaseMessaging.onTokenRefresh,
    ).thenAnswer((_) => Stream<String>.empty());

    // تمهيد استدعاء document على mockCollection
    when(() => mockCollection.doc(any())).thenReturn(mockDocument);

    // تمهيد استدعاء set على mockDocument (عادةً يتم تحديث بيانات FCM token)
    when(() => mockDocument.set(any())).thenAnswer((_) async => Future.value());

    when(() => mockDocument.get()).thenAnswer((_) async => mockDocSnapshot);

    when(() => mockDocSnapshot.exists).thenReturn(true);

    authRepository = AuthRepository(
      auth: mockAuth,
      firestoreService: mockFirestoreService,
      googleSignIn: mockGoogleSignIn,
      firestore: mockFirestoreInstance,
      firebaseMessaging: mockFirebaseMessaging,
    );
  });

  // ---------  Login Test -----------

  test(
    '✅ login succeeds when user is verified and exists in Firestore',
    () async {
      const email = 'test@example.com';
      const password = '123456';
      const userType = 'admin';
      const userId = 'abc123';

      // Mock FirebaseAuth
      when(
        () => mockAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn(userId);
      when(() => mockUser.emailVerified).thenReturn(true);

      // Mock FirestoreService
      when(
        () => mockFirestoreService.getUserDocument(
          userType: userType,
          userId: userId,
        ),
      ).thenAnswer((_) async => mockDoc);

      when(() => mockDoc.exists).thenReturn(true);
      when(() => mockDoc['userType']).thenReturn(userType);

      when(
        () => mockFirebaseMessaging.getToken(),
      ).thenAnswer((_) async => 'mocked_fcm_token');

      // اختبر login
      final result = await authRepository.login(email, password, userType);

      // تحقق من النتيجة
      result.when(
        success: (user) => expect(user?.uid, userId),
        failure: (error) {
          print('Login failed with error: $error');
          fail('Expected success, but got failure');
        },
      );
    },
  );

  test('❌ login fails when user email is not verified', () async {
    const email = 'test@example.com';
    const password = '123456';
    const userType = 'doctor';
    const userId = 'abc123';

    // Mock FirebaseAuth
    when(
      () =>
          mockAuth.signInWithEmailAndPassword(email: email, password: password),
    ).thenAnswer((_) async => mockUserCredential);

    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(userId);
    when(() => mockUser.emailVerified).thenReturn(false); // 👈 هنا الاختلاف
    when(
      () => mockUser.sendEmailVerification(),
    ).thenAnswer((_) async => Future.value());

    // تنفيذ الدالة
    final result = await authRepository.login(email, password, userType);

    // التحقق من أن النتيجة فشل وليس نجاح
    result.when(
      success: (_) => fail('Expected failure, but got success'),
      failure: (error) {
        print('Login failed as expected: $error');
        expect(error, 'error_email_verification_sent'); // أو أي كود خطأ تستخدمه
      },
    );
  });

  test(
    '❌ login fails when user document does not exist in any collection',
    () async {
      const email = 'ghost@example.com';
      const password = 'password123';
      const userType = 'patient';
      const userId = 'ghost123';

      when(
        () => mockAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn(userId);
      when(() => mockUser.emailVerified).thenReturn(true);
      when(() => mockAuth.signOut()).thenAnswer((_) async => Future.value());

      when(
        () => mockFirestoreService.getUserDocument(
          userType: any(named: 'userType'),
          userId: any(named: 'userId'),
        ),
      ).thenAnswer((_) async => mockDoc);
      // user not found in our servers.
      when(() => mockDoc.exists).thenReturn(false);

      final result = await authRepository.login(email, password, userType);

      result.when(
        success: (_) => fail('Expected failure, but got success'),
        failure: (error) {
          print('Login failed as expected: $error');
          expect(error, 'user_not_registered');
        },
      );
    },
  );

  test('❌ login fails when user logs in from wrong page', () async {
    const email = 'test@example.com';
    const password = '123456';
    const attemptedUserType = 'patient'; // الصفحة التي يحاول الدخول منها
    const actualUserType = 'doctor'; // النوع المسجل في قاعدة البيانات
    const userId = 'abc123';

    // Mock FirebaseAuth
    when(
      () =>
          mockAuth.signInWithEmailAndPassword(email: email, password: password),
    ).thenAnswer((_) async => mockUserCredential);

    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(userId);
    when(() => mockUser.emailVerified).thenReturn(true);

    // Mock FirestoreService: المستند موجود ولكن بنوع مستخدم مختلف
    when(
      () => mockFirestoreService.getUserDocument(
        userType: attemptedUserType,
        userId: userId,
      ),
    ).thenAnswer((_) async => mockDoc);
    when(() => mockDoc.exists).thenReturn(true);
    when(() => mockDoc['userType']).thenReturn(actualUserType);

    // توقّع استدعاء signOut عند اكتشاف الفرق في النوع
    when(() => mockAuth.signOut()).thenAnswer((_) async {});

    final result = await authRepository.login(
      email,
      password,
      attemptedUserType,
    );

    result.when(
      success: (_) => fail('Expected failure, but got success'),
      failure: (error) {
        print('Login failed as expected: $error');
        expect(error, 'login_in_the_wrong_page');
      },
    );
  });

  // --------- signInWithGoogle Test -----------

  test(
    '✅ signInWithGoogle succeeds when user is verified and exists in Firestore',
    () async {
      const userType = 'doctor';
      const userId = 'user123';

      when(() => mockAuth.signOut()).thenAnswer((_) async => Future.value());
      when(
        () => mockGoogleSignIn.signOut(),
      ).thenAnswer((_) async => Future.value());
      when(
        () => mockGoogleSignIn.signIn(),
      ).thenAnswer((_) async => mockGoogleUser);
      when(
        () => mockGoogleUser.authentication,
      ).thenAnswer((_) async => mockGoogleAuth);
      when(() => mockGoogleAuth.accessToken).thenReturn('accessToken');
      when(() => mockGoogleAuth.idToken).thenReturn('idToken');

      when(
        () => mockAuth.signInWithCredential(any()),
      ).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn(userId);
      when(() => mockUser.emailVerified).thenReturn(true);

      when(
        () => mockFirestoreService.getUserDocument(
          userId: userId,
          userType: userType,
        ),
      ).thenAnswer((_) async => mockDoc);
      when(() => mockDoc.exists).thenReturn(true);
      when(() => mockDoc['userType']).thenReturn(userType);

      when(
        () => mockFirebaseMessaging.getToken(),
      ).thenAnswer((_) async => 'mocked_fcm_token');

      final result = await authRepository.signInWithGoogle(userType);

      result.when(
        success: (user) => expect(user?.uid, userId),
        failure: (error) => fail('Expected success but got failure: $error'),
      );
    },
  );

  test('❌ signInWithGoogle fails when user cancels login', () async {
    const userType = 'patient';

    when(() => mockAuth.signOut()).thenAnswer((_) async => Future.value());
    when(
      () => mockGoogleSignIn.signOut(),
    ).thenAnswer((_) async => Future.value());
    when(
      () => mockGoogleSignIn.signIn(),
    ).thenAnswer((_) async => null); // المستخدم ألغى

    final result = await authRepository.signInWithGoogle(userType);

    result.when(
      success: (_) => fail('Expected failure but got success'),
      failure: (error) => expect(error, 'User canceled the login'),
    );
  });

  test('❌ signInWithGoogle fails if email is not verified', () async {
    const userType = 'doctor';
    const userId = 'user123';

    when(() => mockAuth.signOut()).thenAnswer((_) async => Future.value());
    when(
      () => mockGoogleSignIn.signOut(),
    ).thenAnswer((_) async => Future.value());
    when(
      () => mockGoogleSignIn.signIn(),
    ).thenAnswer((_) async => mockGoogleUser);
    when(
      () => mockGoogleUser.authentication,
    ).thenAnswer((_) async => mockGoogleAuth);
    when(() => mockGoogleAuth.accessToken).thenReturn('accessToken');
    when(() => mockGoogleAuth.idToken).thenReturn('idToken');

    when(
      () => mockAuth.signInWithCredential(any()),
    ).thenAnswer((_) async => mockUserCredential);
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(userId);
    when(() => mockUser.emailVerified).thenReturn(false); // غير موثق
    when(
      () => mockUser.sendEmailVerification(),
    ).thenAnswer((_) async => Future.value());

    final result = await authRepository.signInWithGoogle(userType);

    result.when(
      success: (_) => fail('Expected failure but got success'),
      failure: (error) => expect(error, 'error_email_verification_sent'),
    );
  });

  test(
    '❌ signInWithGoogle fails when user not registered in any collection',
    () async {
      const userType = 'patient';
      const userId = 'userNotFound';

      when(() => mockAuth.signOut()).thenAnswer((_) async => Future.value());
      when(
        () => mockGoogleSignIn.signOut(),
      ).thenAnswer((_) async => Future.value());
      when(
        () => mockGoogleSignIn.signIn(),
      ).thenAnswer((_) async => mockGoogleUser);
      when(
        () => mockGoogleUser.authentication,
      ).thenAnswer((_) async => mockGoogleAuth);
      when(() => mockGoogleAuth.accessToken).thenReturn('accessToken');
      when(() => mockGoogleAuth.idToken).thenReturn('idToken');

      when(
        () => mockAuth.signInWithCredential(any()),
      ).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn(userId);
      when(() => mockUser.emailVerified).thenReturn(true);

      // المستند غير موجود في الكولكشن الافتراضي
      when(
        () => mockFirestoreService.getUserDocument(
          userId: userId,
          userType: userType,
        ),
      ).thenAnswer((_) async => mockDoc);
      when(() => mockDoc.exists).thenReturn(false);

      // كذلك غير موجود في كل الكولكشنات الأخرى
      when(
        () => mockFirestoreService.getUserDocument(
          userId: userId,
          userType: any(named: 'userType'),
        ),
      ).thenAnswer((_) async => mockDoc);
      when(() => mockDoc.exists).thenReturn(false);

      final result = await authRepository.signInWithGoogle(userType);

      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure:
            (error) =>
                expect(error, 'This user is not registered on our servers.'),
      );
    },
  );

  test('❌ signInWithGoogle fails when user logs in from wrong page', () async {
    const userType = 'patient';
    const userId = 'userWrongPage';

    when(() => mockAuth.signOut()).thenAnswer((_) async => Future.value());
    when(
      () => mockGoogleSignIn.signOut(),
    ).thenAnswer((_) async => Future.value());
    when(
      () => mockGoogleSignIn.signIn(),
    ).thenAnswer((_) async => mockGoogleUser);
    when(
      () => mockGoogleUser.authentication,
    ).thenAnswer((_) async => mockGoogleAuth);
    when(() => mockGoogleAuth.accessToken).thenReturn('accessToken');
    when(() => mockGoogleAuth.idToken).thenReturn('idToken');

    when(
      () => mockAuth.signInWithCredential(any()),
    ).thenAnswer((_) async => mockUserCredential);
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(userId);
    when(() => mockUser.emailVerified).thenReturn(true);

    // مستند موجود لكن userType مختلف
    when(
      () => mockFirestoreService.getUserDocument(
        userId: userId,
        userType: userType,
      ),
    ).thenAnswer((_) async => mockDoc);
    when(() => mockDoc.exists).thenReturn(true);
    when(() => mockDoc['userType']).thenReturn('doctor'); // نوع مختلف

    final result = await authRepository.signInWithGoogle(userType);

    result.when(
      success: (_) => fail('Expected failure but got success'),
      failure: (error) {
        expect(error.contains('login_in_the_wrong_page'), true);
      },
    );
  });

  // --------- resetPassword Test -----------

  test('✅ resetPassword success', () async {
    const email = 'test@example.com';

    when(
      () => mockAuth.sendPasswordResetEmail(email: email),
    ).thenAnswer((_) async => Future.value());

    final result = await authRepository.resetPassword(email);

    result.when(
      success: (_) => expect(true, true),
      failure: (_) => fail('Expected success but got failure'),
    );
  });

  test('❌ resetPassword fails on FirebaseAuthException', () async {
    const email = 'bademail@example.com';

    when(() => mockAuth.sendPasswordResetEmail(email: email)).thenThrow(
      FirebaseAuthException(code: 'user-not-found', message: 'User not found'),
    );

    final result = await authRepository.resetPassword(email);

    result.when(
      success: (_) => fail('Expected failure but got success'),
      failure: (error) => expect(error, isNotEmpty),
    );
  });

  test('❌ resetPassword fails on unexpected error', () async {
    const email = 'test@example.com';

    when(
      () => mockAuth.sendPasswordResetEmail(email: email),
    ).thenThrow(Exception('Unexpected error'));

    final result = await authRepository.resetPassword(email);

    result.when(
      success: (_) => fail('Expected failure but got success'),
      failure: (error) => expect(error, 'An unexpected error occurred.'),
    );
  });

  // --------- saveFcmToken Test -----------

  // doc and token already exists
  test('✅ saveFcmToken updates tokens if document exists', () async {
    const uid = 'user123';
    const userType = 'doctor';
    const token = 'token1';

    when(() => mockDocument.get()).thenAnswer((_) async => mockDocSnapshot);
    when(() => mockDocSnapshot.exists).thenReturn(true);
    when(() => mockDocSnapshot.data()).thenReturn({
      'tokens': [token],
    });

    // هلقيت انا لما استدعي الدالة الحقيقية رح تعمل تحديث للبيانات ف أنا من هلقيت بحكيله انه اذا صار بالمستقبل استدعاء لدالة ال update
    // رجعلي بيانات future ولا ترمي error
    when(
      () => mockDocument.update(any()),
    ).thenAnswer((_) async => Future.value());

    await authRepository.saveFcmToken(uid, userType, token);

    // الكود وصل فعلا لدالة التحديث ابديت وتم استدعاءها مرة واحدة
    verify(() => mockDocument.update(any())).called(1);
  });

  test('✅ saveFcmToken sets tokens if document does not exist', () async {
    const uid = 'user123';
    const userType = 'patient';
    const token = 'token2';

    when(() => mockDocument.get()).thenAnswer((_) async => mockDocSnapshot);
    when(() => mockDocSnapshot.exists).thenReturn(false);

    when(() => mockDocument.set(any())).thenAnswer((_) async => Future.value());

    await authRepository.saveFcmToken(uid, userType, token);

    verify(() => mockDocument.set(any())).called(1);
  });

  test('✅ saveFcmToken handles exceptions gracefully', () async {
    const uid = 'user123';
    const userType = 'doctor';
    const token = 'tokenError';

    when(() => mockDocument.get()).thenThrow(Exception('Firestore error'));

    await authRepository.saveFcmToken(uid, userType, token);
  });

  // --------- اختبارات updateUserLanguage -----------

  test('✅ updateUserLanguage updates user language successfully', () async {
    const uid = 'user123';
    const userType = 'doctor';
    SharedPreferences.setMockInitialValues({'app_locale': 'en'});

    when(
      () => mockFirestoreInstance.collection(any()),
    ).thenReturn(mockCollection);
    when(() => mockCollection.doc(uid)).thenReturn(mockDocument);
    when(() => mockDocument.get()).thenAnswer((_) async => mockDocSnapshot);
    when(() => mockDocSnapshot.exists).thenReturn(true);
    when(
      () => mockDocument.update(any()),
    ).thenAnswer((_) async => Future.value());

    await authRepository.updateUserLanguage(uid, userType);

    verify(() => mockDocument.update(any())).called(1);
  });

  test('✅ updateUserLanguage handles exceptions gracefully', () async {
    const uid = 'user123';
    const userType = 'patient';
    SharedPreferences.setMockInitialValues({'app_locale': 'en'});

    when(
      () => mockFirestoreInstance.collection(any()),
    ).thenThrow(Exception('Firestore error'));

    await authRepository.updateUserLanguage(uid, userType);
  });

  // --------- اختبارات signOut -----------

  test('✅ signOut clears user data and deletes FCM token doc', () async {
    const uid = 'user123';

    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(uid);

    when(
      () => mockFirestoreInstance.collection('fcmTokens'),
    ).thenReturn(mockCollection);
    when(() => mockCollection.doc(uid)).thenReturn(mockDocument);
    when(() => mockDocument.delete()).thenAnswer((_) async => Future.value());

    when(() => mockAuth.signOut()).thenAnswer((_) async => Future.value());

    await authRepository.signOut();

    verify(() => mockDocument.delete()).called(1);
    verify(() => mockAuth.signOut()).called(1);
  });

  test('❌ signOut throws exception on failure', () async {
    when(() => mockAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn('uid123');

    when(
      () => mockFirestoreInstance.collection('fcmTokens'),
    ).thenReturn(mockCollection);
    when(() => mockCollection.doc(any())).thenReturn(mockDocument);
    when(() => mockDocument.delete()).thenThrow(Exception('Delete failed'));

    expect(() => authRepository.signOut(), throwsException);
  });
}
