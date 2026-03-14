import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/utils/api_result.dart';
import 'package:movies/core/utils/app_errors.dart';
import 'package:movies/features/auth/data/model/remoteUser.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthRemoteDataSourceImpl(this._auth, this._firestore);

  @override
  Future<ApiResult<RemoteUser>> signUp(
    String email,
    String password,
    String name,
    String phoneNumber,
    String avatarUrl,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw Exception('Failed to create user');
      }
      final remoteUser = RemoteUser(
        id: credential.user!.uid,
        email: email,
        name: name,
        phoneNumber: phoneNumber,
        avatarPath: avatarUrl,
      );
      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(remoteUser.toJson());
      return SuccessApiResult(remoteUser);
    } on Exception catch (e) {
      return ErrorApiResult(ServerErrors(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> login(String email, String pass) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return SuccessApiResult(null);
    } on FirebaseException catch (e) {
      return ErrorApiResult(ServerErrors(errorMessage: e.toString()));
    }
  }
  @override
  Future<ApiResult<void>>loginWithGoogle() async{
      try {
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;
        await googleSignIn.initialize(
          serverClientId:
          "676420712720-1mmbc0vf8iijpcdngsbsffkops7kcpic.apps.googleusercontent.com",
        );
        final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

        final GoogleSignInAuthentication googleAuth = googleUser.authentication;

        final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
         UserCredential userCredential=await _auth.signInWithCredential(credential);
         final remoteUser=RemoteUser(
           id: userCredential.user!.uid,
           email: userCredential.user!.email,
           name: userCredential.user!.displayName,
           avatarPath: userCredential.user!.photoURL,
           phoneNumber: userCredential.user?.phoneNumber??"Un Known"
         );
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(remoteUser.toJson());
        return SuccessApiResult(null);
      } on FirebaseException catch (e) {
      return ErrorApiResult(ServerErrors(errorMessage: e.message!));
      }




  }

  @override
  Future<ApiResult<void>> logout() async {
    try {
      await _auth.signOut();
      return SuccessApiResult(null);
    } on FirebaseException catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<RemoteUser>> getCurrentUser() async {
    try {
      var firebaseUser = _auth.currentUser;
      if (firebaseUser == null) {
        return ErrorApiResult(
          UnKnownErrors(errorMessage: "No user is currently signed in"),
        );
      }
      var userCollection = _firestore.collection("users");
      DocumentSnapshot snapshot = await userCollection
          .doc(firebaseUser.uid)
          .get();
      Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
      var currentUser = RemoteUser.fromJson(json);
      return SuccessApiResult(currentUser);
    } on FirebaseException catch (e) {
      return ErrorApiResult(UnKnownErrors(errorMessage: e.message ?? ""));
    }
  }
  @override
  Future<ApiResult<void>> forgotPass(String email)async{
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return SuccessApiResult(null);
    } on FirebaseException catch (e) {
      return ErrorApiResult(ServerErrors(errorMessage: e.message!));
    }
  }
  @override
  Future<ApiResult<void>> deleteAccount()async{
    try {
      var currentUser= _auth.currentUser;
      DocumentReference documentRef=_firestore.collection("users").doc(currentUser!.uid);
      await documentRef.delete();
      await currentUser.delete();
      return SuccessApiResult(null);
    } on FirebaseException catch (e) {
      return ErrorApiResult(ServerErrors(errorMessage: e.message!));
    }
  }

}
