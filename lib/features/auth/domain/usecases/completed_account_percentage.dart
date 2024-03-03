import '../../data/models/user_model.dart';

Map competedAccountPercentage(UserModel user) {
  // ==============================================================
  // UNCOMMEN,T IF I WANT TO CHECK FOR COMPLETE ACCOUNT
  // ==============================================================

  // Map account = {};
  // var percentage = 0.3;
  // bool status = false;

  // if (user.role! == 'user' || user.role! == 'old_student') {
  //   if (user.resume_path != null && user.resume_path != '') {
  //     percentage += 0.4;
  //   }

  //   if (user.avatar_path != null && user.avatar_path != '') {
  //     percentage += 0.4;
  //   }
  // } else {
  //   if (user.avatar_path != null && user.avatar_path != '') {
  //     percentage += 0.8;
  //   }
  // }

  // account['profile'] = percentage > 1;

  // if (user.submission_status == 'approved') {
  //   status = true;
  // }

  // account['submission'] = status;

  // return account;

  // ==============================================================
  // SKIP CHECK FOR COMPLETE ACCOUNT
  // ==============================================================

  return {
    "profile": true,
    "submission": true,
  };
}
