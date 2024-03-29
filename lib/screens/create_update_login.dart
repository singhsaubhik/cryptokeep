import 'package:cryptokeep/controller/create_update_controller.dart';
import 'package:cryptokeep/models/login_model.dart';
import 'package:cryptokeep/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUpdatePage extends GetView<CreateUpdateController> {
  final controller = Get.put(CreateUpdateController());

  @override
  Widget build(BuildContext context) {
    final _login = ModalRoute.of(context).settings.arguments;
    controller.populateUpdateData(_login);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_login == null ? "Create Login" : "Update Login"),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                _CreateUpdateForm(),
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () async => controller.onGeneratePasswordClick(),
                  child: Text("Generate password"),
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
                _CreateUpdateActions(_login)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateUpdateActions extends GetView<CreateUpdateController> {
  final Login _login;

  const _CreateUpdateActions(this._login);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: MaterialButton(
            color: Theme.of(context).accentColor,
            onPressed: () => controller.onSubmit(context, this._login),
            child: Text(
              "Save",
            ),
          ),
        ),
      ],
    );
  }
}

class _CreateUpdateForm extends GetView<CreateUpdateController> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          _CreateUpdateInput(
            controller.titleController,
            "Enter Title",
            prefixIcon: Icons.text_fields,
            validator: (v) => controller.titleValidator(v),
          ),
          SizedBox(
            height: 10,
          ),
          _CreateUpdateInput(
            controller.usernameController,
            "Enter User Name",
            prefixIcon: Icons.supervised_user_circle_outlined,
            validator: (v) => controller.usernameValidator(v),
          ),
          SizedBox(
            height: 10,
          ),
          _CreateUpdateInput(
            controller.passwordController,
            "Enter Password",
            obscureText: true,
            prefixIcon: Icons.lock,
            validator: (v) => controller.passwordValidator(v),
          ),
          SizedBox(height: 10),
          CategoryDropdown(),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class CategoryDropdown extends GetView<CreateUpdateController> {
  const CategoryDropdown({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.blueGrey,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please select a category",
            style: TextStyle(color: Colors.white54),
          ),
          Obx(() {
            return DropdownButton<String>(
              elevation: 2,
              isExpanded: true,
              value: controller.category.value,
              items: <String>["Login", "Social Media", "Finance", "Other"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              hint: Text(
                "Please choose category",
              ),
              onChanged: (String v) => controller.onSelectCategory(v),
            );
          }),
        ],
      ),
    );
  }
}

class _CreateUpdateInput extends StatelessWidget {
  const _CreateUpdateInput(this._controller, this.hintText,
      {this.obscureText = false, this.prefixIcon, this.validator});

  final TextEditingController _controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: this.obscureText,
      validator: (v) => validator(v),
      decoration: AppTheme.textFieldDecoration.copyWith(
        hintText: this.hintText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        hintStyle: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
