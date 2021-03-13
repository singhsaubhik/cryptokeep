import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/services/login_service.dart';
import 'package:cryptokeep/themes/app_theme.dart';
import 'package:cryptokeep/utils/common.dart';
import 'package:flutter/material.dart';

class CreateUpdateDialog extends StatelessWidget {
  final titleController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final CreateUpdateType _type;

  CreateUpdateDialog(this._type);

  final _formKey = GlobalKey<FormState>();

  void populateUpdateData(Login login) {
    titleController.value = titleController.value.copyWith(text: login.title);
    usernameController.value =
        usernameController.value.copyWith(text: login.username);
    passwordController.value =
        passwordController.value.copyWith(text: login.password);
  }

  void onSubmit(BuildContext context, {Login login}) {
    var state = _formKey.currentState.validate();
    if (!state) return;

    var value = {
      "title": titleController.value.text,
      "username": usernameController.value.text,
      "password": passwordController.value.text
    };

    if (_type == CreateUpdateType.create) {
      LoginService.instance(context).createLogin(Login.fromValue(value));
    } else {
      login.update(value);
      LoginService.instance(context).updateLogin(login.id, login);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Login _login;
    if (_type == CreateUpdateType.update) {
      _login = ModalRoute.of(context).settings.arguments;
      this.populateUpdateData(_login);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_type == CreateUpdateType.create ? "Create" : "Update"),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.clear,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              _CreateUpdateForm(
                formKey: _formKey,
                titleController: titleController,
                usernameController: usernameController,
                passwordController: passwordController,
              ),
              _CreateUpdateActions(
                onSubmit: () => onSubmit(context, login: _login),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateUpdateActions extends StatelessWidget {
  final Function onSubmit;

  const _CreateUpdateActions({@required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: MaterialButton(
            color: Theme.of(context).accentColor,
            onPressed: onSubmit,
            child: Text(
              "Save",
            ),
          ),
        ),
      ],
    );
  }
}

class _CreateUpdateForm extends StatelessWidget {
  const _CreateUpdateForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.titleController,
    @required this.usernameController,
    @required this.passwordController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController titleController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _CreateUpdateInput(
            titleController,
            "Enter Title",
            prefixIcon: Icons.text_fields,
          ),
          SizedBox(
            height: 10,
          ),
          _CreateUpdateInput(
            usernameController,
            "Enter User Name",
            prefixIcon: Icons.supervised_user_circle_outlined,
          ),
          SizedBox(
            height: 10,
          ),
          _CreateUpdateInput(
            passwordController,
            "Enter Password",
            obscureText: true,
            prefixIcon: Icons.lock,
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class _CreateUpdateInput extends StatelessWidget {
  const _CreateUpdateInput(this._controller, this.hintText,
      {this.obscureText = false, this.prefixIcon});

  final TextEditingController _controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: this.obscureText,
      validator: (value) {
        /// TODO: Add separate validator for each field
        if (value.isEmpty) {
          return "Please enter value";
        }
        return null;
      },
      style: TextStyle(color: Colors.white),
      decoration: AppTheme.textFieldDecoration.copyWith(
        hintText: this.hintText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.white38,
        ),
      ),
    );
  }
}
