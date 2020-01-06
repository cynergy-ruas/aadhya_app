import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:dwimay/pages/profile_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Key to access the [LoginWidget]. Used to execute
  /// login and logout
  GlobalKey<LoginWidgetState> loginKey = GlobalKey<LoginWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // using a [Builder] widget so that snackbars can be
      // shown.
      body: LoginWidget(
        key: loginKey,

        // widget to display when the login screen is not loaded
        // onUninitialized: SplashScreen(),

        // widget to display when the login process is on going
        onLoading: LoadingWidget(),

        // widget to display when the login process was successful
        onSuccess: ProfilePage(loginKey: loginKey),

        // the login form
        loginForm: LoginForm(
          loginKey: loginKey,
        ),

        // callback to execute when an error occurs during the
        // authentication process
        onError: (BuildContext context, Exception e) =>
            Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('${e.toString()}'),
          backgroundColor: Colors.red,
        )),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  /// The key to access the [LoginWidget]. Used
  /// for logging in.
  final GlobalKey<LoginWidgetState> loginKey;

  LoginForm({@required this.loginKey});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  // this is the style of the hint text e.g "Enter your Password"
  final HintTextStyle = TextStyle(
    color: Colors.white54,
    fontFamily: 'OpenSans',
  );

  // this the style of the label of the textfields
  final LabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  // the style for the textfields
  final BoxDecorationStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  // building the email textfield(tf)
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // the tf label
        Text(
          'Email',
          style: LabelStyle,
        ),

        SizedBox(height: 10.0),

        // the actual email tf
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: HintTextStyle,
            ),
            controller: emailController,
          ),
        ),
      ],
    );
  }

  // building the password tf
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // password tf label
        Text(
          'Password',
          style: LabelStyle,
        ),

        SizedBox(height: 10.0),

        // the actual password tf
        Container(
          alignment: Alignment.centerLeft,
          // decoration: BoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: HintTextStyle,
            ),
            controller: passwordController,
          ),
        ),
      ],
    );
  }

  // building the login button
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => widget.loginKey.currentState.login(
            email: emailController.text, password: passwordController.text),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // stacking two containers on top of each other, we can give a coustom
      // backgound color by changing the color of first container
      body: Stack(
        children: <Widget>[
          // gives a coustom gradient color to the page..(remove it later lol)
          // jus remove this container to give it the default theme color
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF222831),
                  Color(0xFF222831),
                  Color(0xFF25292e),
                  Color(0xFF28292b),
                ],
                stops: [0.05, 0.4, 0.7, 0.9],
              ),
            ),
          ),

          // the container containing all the tfs and login button,
          // this basically the whole login form
          Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // gap
                    SizedBox(height: 30.0),

                    // building email field
                    _buildEmailTF(),

                    // gap
                    SizedBox(
                      height: 30.0,
                    ),

                    // building password field
                    _buildPasswordTF(),
                    _buildLoginBtn(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// loading widget from the examples page
// TODO: maybe change the loading animation
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: Colors.grey[300])),
        Center(
            child: SizedBox(
          height: 60,
          width: 60,
          child: new CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ))
      ],
    );
  }
}
