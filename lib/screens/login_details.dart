import 'package:cryptokeep/models/password_model.dart';
import 'package:flutter/material.dart';

class LoginDetails extends StatefulWidget {
  @override
  _LoginDetailsState createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Password _login = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF538CFF),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.edit),
        ),
        body: Column(
          children: [
            BuildTopTitle(_login),
            SizedBox(height: 5),
            TopSecondPanel(),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    initialValue: _login.username,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(.7),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    readOnly: true,
                    initialValue: _login.password,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(.7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
          Text(
            _login.createdAt,
            style: TextStyle(color: Color(0xFFD7D7D7), fontSize: 16),
          ),
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
          BuildIconWithText("Category", Icons.calendar_today),
          BuildIconWithText("Password Score", Icons.account_balance),
          BuildIconWithText("Favorite", Icons.favorite),
        ],
      ),
    );
  }
}

class BuildIconWithText extends StatelessWidget {
  final String title;
  final IconData icon;

  const BuildIconWithText(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Icon(
          icon,
          color: Colors.blue,
          size: 35,
        )
      ],
    );
  }
}
