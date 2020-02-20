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

  /// The warning text
  static const warning = "Warning";

  /// The password field hint
  static const passwordHint = "password";

  /// Title of the about us section
  static const aboutContentTitle = "About Us";

  /// Content of the about page
  static const aboutContent = '''Ola everyone! We are the students of the Ramaiah University of Applied Sciences. We have taken an initiative to bring students of RUAS as well as all the other Universities around to experience amazing technical events, unforgettable memories, and unlimited learning opportunities. We present to you the first-ever TechFest of RUAS, Aadhya 2020. This fest is going to be a melting pot for the techies, a platform where you could showcase your talent, a launchpad for sowing the seed of passion and above all, a paragon of incredible human experience. Amidst the gleam of bonfires and some tech talk, we want to bring in people creating memories lasting for a lifetime. Aadhya aims to capture the vitality of the technological world succinctly, and we strive for Aadhya to be one of the premier fests of our nation. We aspire to broaden our horizons and strengthen plenteous creative brains framing the future. With “The Decade In Review” as its theme, the first edition of Aadhya brings to you a quick look covering all that has happened in past this decade. We invite you to share our vision and be a part of the legacy that carries forward technical excellence.''';

  /// Title of the fest theme description
  static const festThemeDescriptionTitle = "Theme: A Decade in Review";

  /// Fest theme description
  static const festThemeDescription = '''The first edition of the Aadhya brings to you the theme, A Decade in Review. As the calendar turns to 2020, like many of you, Aadhya 2020 invites you to pause and reflect on the last decade. There is no future without the past, so why not acknowledge it? This decade created a vast number of opportunities and helped the young generations to garner sufficient knowledge to put forth in the hope of creating a better tomorrow. There were multiple theories that evolved, and multiple events occurred doing a vital chance in how we perceive life. Here this Aadhya 2020 talks about the events which occurred in the decade, and to start a new outlook mapping, an outline of the past event is a must.''';

  /// The title for the special thanks section
  static const poweredByTitle = "Powered By";

  /// Name of the fest
  static const festName = "Aadhya";

  /// FAQ page title
  static const faqTitle = "Frequently Asked \nQuestions";

  /// FAQ page poc section title
  static const faqPoc = "For Further Queries Contact";

  /// The frequently asked questions
  static const faqs = [
    {
      "question": "Will certificates be provided?",
      "answer": "Yes certificates will be provided if you participate in workshops and competitions."
    },

    {
      "question": "How do I register for Aadhya 2020?",
      "answer": "You can either register for individual events or buy combo packages (i.e. passes) for full day access."
    },

    {
      "question": "Is there an entry fee?",
      "answer": "Some talks are free to attend but there is a price for participating in each workshop and competitions. you can also buy special passes which grant you full day access to events and stalls."
    },

    {
      "question": "Where can i stay during techfest in RUAS?",
      "answer": "Our team will contact you once you register for the event. if you want an accomodation, it will be provided with minimal charges. (a small price to pay for salvation. :')"
    },
    {
      "question": "How many members should be there in a team during a team event",
      "answer": "The number might vary for each event. although individual participation is encouraged."
    },

    {
      "question": "What to do after registering?",
      "answer": "Sit back and chill. our team will contact you shortly. make sure you book your transportation tho'."
    },

    {
      "question": "Is parking available?",
      "answer": "Yes. The parking lot will be allocated to you. unless it's not a chopper."
    },

    {
      "question": "Where is the venue of the event and how to reach there?",
      "answer": "Ramaiah University of Applied Science, peenya 2nd stage, Bengaluru \nP.S: c'mon you know how to use google maps. :)"
    },
  ];
  
  /// Error message when data cannot be retrieved from townscript API
  static const townscriptNotRecognized = "Cannot retrieve registration ids. QR codes in townscript confirmation email and passes will not be recognized.";

  /// Wrong email address error message
  static const invalidEmailMessage = "Looks like the email address is wrong. Please try again.";

  /// Wrong password error message
  static const wrongPasswordMessage = "Oops! Wrong password. Please Try again.";

  /// User not found error
  static const userNotFoundMessage = "Looks like you haven't registered yet. Please try registering first";

  /// email already in use
  static const emailAlreadyInUse = "Looks like you have already registered. Try logging in!";

  /// Unknown error message
  static const unknownError = "Error occurred. Please try again";

  /// invlaid URL message
  static const invalidUrl = "URL is invalid.";

  /// Password reset page title
  static const passwordResetPageTitle = "Reset Password";

  /// The message to display while resetting the password
  static const passwordResetPageMessage = "Please enter the email id associated with your account. A password reset email will be sent to that email id.";

  /// The title of the qr code
  static const qrTitle = "Your pass for the events:";

  /// The title of the passes view in the events page
  static const passesViewTitle = "Check out these passes!";

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

  /// The error message when the poc cannot be called
  static const callError = "Cannot call number.";

  /// The title of the collapsed sheet
  static const collapsedSheetTitle = "Pass";

  /// When user has registered for an event
  static const registered = "Registered";

  /// The title of the events page
  static const eventsPageTitle = "Events";

  /// The title of the details page
  static const detailsPageTitle = "OVERVIEW";

  /// The title of the speakers section
  static const speakerSectionTitle = "SPEAKER";

  /// The title of the POC section
  static const pocSectionTitle = "POINT OF CONTACT";

  /// the title for the events for all departments
  static const eventsForAll = "For All";

  /// the title for the events for aero and auto
  static const aeroAndAuto = "Aerospace and Automotive";

  /// the title for the events for CS
  static const cse = "Computer Science";

  /// the title for the events for Civil
  static const civil = "Civil";

  /// the title for the events for EC and EEE
  static const electricAndElectronics = "Electrical and Electronics";

  /// the title for the events for design
  static const design = "Design";

  /// the title for the events for mechanical
  static const mechanical = "Mechanical";

  /// the message to print if there are no events for a day
  static const noEventsMessage = "No Events";

  /// the message to display if there are no passes
  static const noPassesMessage = "No Passes.";

  /// The title of the announcements page
  static const announcementsPageTitle = "Announcements";

  /// The subtitle of the announcements page
  static const announcementsPageSubtitle = "Season Announcements!";

  /// The text to display when there are no announcements
  static const noAnnouncementsText = "No Announcements for Now!";

  /// The part of text to display for level 1 users in profile page
  static const level1ProfileHeader = "You are managing the event\n";

  /// The part of text to display for level 2 users in profile page
  static const level2ProfileHeader = "You are managing the events for\n";

  /// The text for level 1 users error
  static const level1ProfileErrorHeader = "You have not been assigned an event\n";

  /// The text for level 2 users error
  static const level2ProfileErrorHeader = "You have not been assigned a department.\n";

  /// The subtitle for the level 1 users error
  static const level1ProfileErrorSubtitle = "Contact your lead to get an event assigned to you.";
  
  /// The subtitle for the level 2 users error
  static const level2ProfileErrorSubtitle = "Contact the core committee.";

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
  static const detailsFieldHint = "Info you want to send";

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