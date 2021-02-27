import 'package:cryptokeep/components/app_snackbar.dart';
import 'package:cryptokeep/models/password_model.dart';
import 'package:flutter/material.dart';

class LoginDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Password _login = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF538CFF),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppSnackBar.getInstance.showAppSnackBar("Not yet implemented");
          },
          child: Icon(Icons.edit),
        ),
        body: Column(
          children: [
            BuildTopTitle(_login),
            SizedBox(height: 5),
            TopSecondPanel(),
            SizedBox(height: 20),
            _LoginDetailsPanel(_login)
          ],
        ),
      ),
    );
  }
}

class _LoginDetailsPanel extends StatefulWidget {
  const _LoginDetailsPanel(this._login);

  final Password _login;

  @override
  __LoginDetailsPanelState createState() => __LoginDetailsPanelState();
}

class __LoginDetailsPanelState extends State<_LoginDetailsPanel> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    /// TODO: Remove this line with better way.
    /// This registers the snackbar with scaffold for global use
    final _ = AppSnackBar.init(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextFormField(
            readOnly: true,
            initialValue: widget._login.username,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.verified_user,
                color: Colors.blue,
              ),
              suffix: Icon(
                Icons.copy,
                color: Colors.white.withOpacity(.8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(.7),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: !this.showPassword,
            readOnly: true,
            initialValue: widget._login.password,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.blue,
              ),
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white.withOpacity(.8),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.copy,
                    color: Colors.white.withOpacity(.8),
                  ),
                ],
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(.7),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(.7),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(.7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildTopTitle extends StatelessWidget {
  final Password _login;

  BuildTopTitle(this._login);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Color(0xFF538CFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Text(
            _login.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          // Text(
          //   _login.createdAt,
          //   style: TextStyle(color: Color(0xFFD7D7D7), fontSize: 16),
          // ),
        ],
      ),
    );
  }
}

class TopSecondPanel extends StatelessWidget {
  const TopSecondPanel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Color(0xFF797979).withOpacity(.2),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildIconWithText(
            "Category",
            Icon(
              Icons.account_tree_sharp,
              color: Colors.blue,
              size: 30,
            ),
          ),
          BuildIconWithText(
            "Password Score",
            Text(
              "100 %",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          BuildIconWithText(
            "Favorite",
            Icon(
              Icons.favorite,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildIconWithText extends StatelessWidget {
  final String title;
  final Widget child;

  const BuildIconWithText(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(.8),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        child
      ],
    );
  }
}
