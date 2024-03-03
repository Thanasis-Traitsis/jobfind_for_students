enum PAGES {
  auth,
  login,
  signupOld,
  signupComp,
  home,
  majorId,
  listing,
  profile,
  favourite,
  jobDetails,
  userListings,
  account,
  requestDegree,
  applicantsList,
  newListing,
  error,
}

extension AppPageExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.auth:
        return "/auth";
      case PAGES.login:
        return "/login";
      case PAGES.signupOld:
        return "/signup-old-student";
      case PAGES.signupComp:
        return "/signup-company";
      case PAGES.home:
        return "/";
      case PAGES.majorId:
        return "/major-id";
      case PAGES.listing:
        return "/job-listing";
      case PAGES.profile:
        return "/profile";
      case PAGES.favourite:
        return "/favourite";
      case PAGES.jobDetails:
        return "/job-details";
      case PAGES.userListings:
        return "/user-listings";
      case PAGES.account:
        return "/account";
      case PAGES.requestDegree:
        return "/request-degree";
      case PAGES.applicantsList:
        return "/applicants-list";
      case PAGES.newListing:
        return "/new-listing";
      case PAGES.error:
        return "/error";
      default:
        return "/auth";
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.auth:
        return "auth";
      case PAGES.login:
        return "login";
      case PAGES.signupOld:
        return "signup-old-student";
      case PAGES.signupComp:
        return "signup-company";
      case PAGES.home:
        return "home";
      case PAGES.majorId:
        return "major-id";
      case PAGES.listing:
        return "job-listing";
      case PAGES.profile:
        return "profile";
      case PAGES.favourite:
        return "favourite";
      case PAGES.jobDetails:
        return "job-details";
      case PAGES.userListings:
        return "user-listings";
      case PAGES.account:
        return "account";
      case PAGES.requestDegree:
        return "request-degree";
      case PAGES.applicantsList:
        return "applicants-list";
      case PAGES.newListing:
        return "new-listing";
      case PAGES.error:
        return "error";
      default:
        return "auth";
    }
  }

  String get screenTitle {
    switch (this) {
      case PAGES.auth:
        return "auth";
      case PAGES.login:
        return "login";
      case PAGES.signupOld:
        return "signup-old-student";
      case PAGES.signupComp:
        return "signup-company";
      case PAGES.home:
        return "home";
      case PAGES.majorId:
        return "major-id";
      case PAGES.listing:
        return "job-listing";
      case PAGES.profile:
        return "profile";
      case PAGES.favourite:
        return "favourite";
      case PAGES.jobDetails:
        return "job-details";
      case PAGES.userListings:
        return "user-listings";
      case PAGES.account:
        return "account";
      case PAGES.requestDegree:
        return "request-degree";
      case PAGES.applicantsList:
        return "applicants-list";
      case PAGES.newListing:
        return "new-listing";
      case PAGES.error:
        return "error";
      default:
        return "auth";
    }
  }
}
