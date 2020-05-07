import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class AuthProvider {
  final CollectionReference _firebaseCollection = Firestore.instance.collection("UserProfileCollection");
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String> signInWithEmail(String email, String password) async{
    try {

      AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);

      FirebaseUser user = result.user;

      if(user != null) {
        if (user.isEmailVerified) {

          //Set collection if user is verified his email
            var  blnIsEmailVerified = await _firebaseCollection.document(user.uid).get().then((document) => document.data['IsEmailVerified'].toString().toLowerCase());
           // print(1);
            if(blnIsEmailVerified == 'false') {
                await _firebaseCollection.document(user.uid).updateData({
                'IsEmailVerified': user.isEmailVerified
              });
            }
            //print(2);
            //Check first responder is validated based on IsFirstResponderValidated,IsFirstResponder collection value

/*            var  blnIsFirstResponder = await _firebaseCollection.document(user.uid).get().then((document) => document.data['IsFirstResponder'].toString().toLowerCase());
            var  blnIsFirstResponderValidated = await _firebaseCollection.document(user.uid).get().then((document) => document.data['IsFirstResponderValidated'].toString().toLowerCase());
            print(3);

            if(blnIsFirstResponder == 'true') {
              if(blnIsFirstResponderValidated == 'false')
              {


                await _auth.signOut();


                //print('Submitted Id proof is pending to validate. Please try again later.');
                return 'Submitted Id proof is pending to validate. Please try again later.';
              }
            }*/
          //print("final");

          /*  _auth.onAuthStateChanged.listen((newUser) {
              print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');
              user = newUser;
              //notifyListeners();
            }, onError: (e) {
              print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
            });*/
          return "1"; ///Login Success
        }
        else {
          await _auth.signOut();
          return "2"; ///Verify Email
        }
      }
      else {
        return "3";  ///Login Failed
      }
    }

    catch (e) {
      print('${e.message}');
      return '${e.message}';
    }
  }

  Future<String>  signUpWithEmail(String firstName, String lastName,String email, String password, bool isFirstResponder, String fileName, String filePath) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
      FirebaseUser user = result.user;
      if(user != null) {

        // Update the username
        await updateUserName(firstName +' ' + lastName, user);

        await _firebaseCollection.document(user.uid).setData({
          'FirstName': firstName,
          'LastName': lastName,
          'Email_Id': user.email,
          'IsEmailVerified': user.isEmailVerified,
          'IsFirstResponder': isFirstResponder,
          'IsFirstResponderValidated': false,
          'CreatedDateTime': DateTime.now().toString()
        });
        print(1);
        if(isFirstResponder && filePath != '') {
          final StorageReference storageRef = FirebaseStorage.instance.ref()
              .child(user.uid)
              .child(fileName);
          final StorageUploadTask uploadTask = storageRef.putFile(
              File(filePath));
          await uploadTask.onComplete;
        }

        await user.sendEmailVerification();

        await _auth.signOut();

        return "1";  //Signup Success
      }
      else {

          return "2"; //Signup failed
        }
    }
    catch (e) {
      print('${e.message}');
      return '${e.message}';
    }
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if(account == null )
        return false;
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if(res.user == null)
        return false;
      return true;
    } catch (e) {
      print(e.message);
      print("Error logging with google");
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
          await _auth.sendPasswordResetEmail(email: email);
          return true;
    }
    catch (e) {
        print(e);
       return false;
    }
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  // GET UID
  Future<String> getCurrentUserDisplayName() async {
    return (await _auth.currentUser()).displayName;
  }


  // GET CURRENT USER
  Future getCurrentUser() async {
    return await _auth.currentUser();
  }

  Future<bool> isLoggedIn() async {
    FirebaseUser _user = await _auth.currentUser();
    if (_user == null) {
      return false;
    }
    return true;
  }

  Future<String>  addNewIncident(String address, int conscious, int breathing, int bleedingHeavily, String description, String incidentType, String latitude, String longitude) async {
    try {
      CollectionReference _firebaseReportedIncidents = Firestore.instance.collection("ReportedIncidents");
      FirebaseUser _user = await _auth.currentUser();
      if(_firebaseReportedIncidents != null) {


        await _firebaseReportedIncidents.document(_user.uid + '_' + DateFormat("ddMMHHmmss").format(DateTime.now())).setData({
          'Address': address,
          'Latitude': latitude,
          'Longitude': longitude,
          'BleedingHeavily': bleedingHeavily == 1?'Yes':'No',
          'Breathing': breathing == 1?'Yes':'No',
          'Conscious': conscious == 1?'Yes':'No',
          'Description': description,
          'IncidentType': incidentType,
          'IsActive': true,
          'Time': DateFormat("h:mm a").format(DateTime.now()),
          'ReportedDateTime': DateTime.now().toString()
        });

        return "1";  //Successfully Inserted
      }
      else {
        return "Failed to report incident.";
      }
    }
    catch (e) {
      print('${e.message}');
      return '${e.message}';
    }
  }
}