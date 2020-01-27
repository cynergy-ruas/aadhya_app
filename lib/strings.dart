class Strings {

  /// Text of back button
  static const backButton = "Back";

  /// Text of confirm button
  static const confirmButton = "Confirm";

  /// login button text
  static const loginButton = "Login";

  /// Register button text
  static const registerButton = "Register";

  /// logout button text
  static const logoutButton = "Logout";

  /// The scan buton text
  static const scanButton = "Scan";

  /// The forgot password text
  static const forgotPassword = "forgot password?";

  /// The password field hint
  static const passwordHint = "password";

  /// Content of the about page
  static const aboutContent = '''
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  ''';

  /// Name of the fest
  static const festName = "Aadhya";

  /// FAQ page title
  static const faqTitle = "Frequently Asked \nQuestions";

  /// The frequently asked questions
  static const faqs = [
    {
      "question": "Question 1",
      "answer": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },

    {
      "question": "Question 2",
      "answer": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },

    {
      "question": "Question 3",
      "answer": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },

    {
      "question": "Question 4",
      "answer": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
  ];

  /// Wrong email address error message
  static const invalidEmailMessage = "Looks like the email address is wrong. Please try again.";

  /// Wrong password error message
  static const wrongPasswordMessage = "Oops! Wrong password. Please Try again.";

  /// User not found error
  static const userNotFoundMessage = "Looks like you haven't registered yet. Please try registering first";

  /// Unknown error message
  static const unknownError = "Error occurred. Please try again";

  /// Password reset page title
  static const passwordResetPageTitle = "Reset Password";

  /// The message to display while resetting the password
  static const passwordResetPageMessage = "Please enter the email id associated with your account. A password reset email will be sent to that email id.";

  /// The title of the qr code
  static const qrTitle = "Your pass for the events:";

  /// Title of the QR scan page
  static const qrScanPageTitle = "Scan QR code";

  /// Success message after scanning qr code
  static const qrScanSuccess = "shall pass!";

  /// Failure message after scanning qr code
  static const qrScanFail = "shall not pass!";

  /// The title of the field in the Qr scan form, to select the event to scan for
  static const qrScanFormEventFieldTitle = "Select the event to scan for";

  /// The message to display when no event is selected in the QR scan form
  static const noEventSelected = "Please select an event.";

  /// The title for the registered events
  static const registeredEvents = "Your Events";

  /// The message to display when there are no registered events for a user
  static const noRegEvents = "You have not paid for any event yet.";

  /// The title of the collapsed sheet
  static const collapsedSheetTitle = "Pass";

  /// The title of the events page
  static const eventsPageTitle = "Events";

  /// The title of the details page
  static const detailsPageTitle = "OVERVIEW";

  /// the title for the events for all departments
  static const eventsForAll = "For All";

  /// the title for the events for aero and auto
  static const aeroAndAuto = "Aerospace and Automotive";

  /// the title for the events for CS
  static const cse = "Computer Science";

  /// the title for the events for EC and EEE
  static const electricAndElectronics = "Electrical and Electronics";

  /// the title for the events for design
  static const design = "Design";

  /// the title for the events for mechanical
  static const mechanical = "Mechanical";

  /// the message to print if there are no events for a day
  static const noEventsMessage = "No Events";

  /// The title of the announcements page
  static const announcementsPageTitle = "Announcements";

  /// The subtitle of the announcements page
  static const announcementsPageSubtitle = "Season Announcements!";

  /// The text to display when there are no announcements
  static const noAnnouncementsText = "No Announcements for Now!";

  /// The title of the clearance page
  static const clearancePageTitle = "Update Clearance";

  /// The success message when the clearance level is successfully 
  /// updated
  static const clearancePageSuccess = "Clearance updated.";

  /// The title of the email id field in the clearance modifier form
  static const formEmailTitle = "Email ID";

  /// The hint for the email id field in the clearance modifier form
  static const formEmailHint = "email id";

  /// The error message to show when the email id field is empty in
  /// the clearance modifier form
  static const formEmailEmpty = "email id cannot be empty";

  /// The error message when password field is empty
  static const formPasswordEmpty = "password cannot be empty";

  /// The title of the clearance level radio buttons in the clearance modifier
  /// form
  static const clearanceFormLevelTitle = "Clearance Level";

  /// The title of the notification publishing page
  static const notificationPublishTitle = "Publish Notification";

  /// The title of the notification publishing form title field
  static const titleFieldTitle = "Title";

  /// The hint text for the title field
  static const titleFieldHint = "Title of the notification";

  /// the error when the title field is empty
  static const titleFieldEmpty = "Title cannot be empty";

  /// The title of the notification publishing form title field
  static const subtitleFieldTitle = "Subtitle";

  /// The hint text for the title field
  static const subtitleFieldHint = "Short, one line description";

  /// The error when the title field is empty
  static const subtitleFieldEmpty = "Subtitle cannot be empty";

  /// The title of the notification publishing form title field
  static const detailsFieldTitle = "Details";

  /// The hint text for the title field
  static const detailsFieldHint = "Long description";

  /// The title of the notification publishing form title field
  static const notificationsPublishEventsFieldTitle = "Event to publish for";

  /// The hint text for the title field
  static const eventsFieldHint = "The event";

  /// The error when the title field is empty
  static const eventsFieldEmpty = "Please select an event";

  /// The error message when no matching events are found
  static const noEventsFound = "No events found";

  /// The error message when a valid event is not selected
  static const notValidEvent = "Please select a valid event";

  /// The title of the assign events page
  static const assignEventsPageTitle = "Assign Events";

  /// The success message
  static const assignEventsSuccess = "Successfully assigned event.";

  /// The title of the event auto complete form field
  static const eventFormFieldTitle = "Event";

  /// The network error message
  static const networkError = "Please check your internet connection";
}