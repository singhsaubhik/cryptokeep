import 'package:cryptokeep/utils/constants.dart';
import 'package:flutter/material.dart';

class PasswordGrid extends StatelessWidget {
  const PasswordGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          for (var data in kPasswordData)
            PasswordCard(Key(data["_id"]), data["name"])
        ],
      ),
    );
  }
}

class PasswordCard extends StatelessWidget {
  PasswordCard(Key key, this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              border: Border.all(
                width: 5,
                style: BorderStyle.solid,
                color: Color(0xFFD1D1D1),
              ),
            ),
            child: Text(
              name[0],
              style: TextStyle(
                color: Color(0xFFD1D1D1),
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            name,
            style: TextStyle(
                color: Color(0xFFD7D7D7),
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWidget(
                "Edit",
                borderColor: Colors.blue,
              ),
              ButtonWidget(
                "Copy",
                borderColor: Colors.green,
              ),
            ],
          )
        ],
      ),
      color: Color(0xFF5C5C5C).withOpacity(.5),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  ButtonWidget(this.text, {this.onClick, this.borderColor});

  final String text;
  final Function onClick;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 65,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          width: 1.5,
          style: BorderStyle.solid,
          color: this.borderColor,
        ),
      ),
      child: Text(
        this.text,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}
