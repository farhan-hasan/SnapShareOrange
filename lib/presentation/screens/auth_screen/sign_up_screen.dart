import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snap_share_orange/data/services/fire_base_auth.dart';
import 'package:snap_share_orange/presentation/screens/auth_screen/log_in_screen.dart';
import 'package:snap_share_orange/presentation/widgets/custom_elevated_button.dart';
import 'package:snap_share_orange/presentation/widgets/scaffold_message.dart';
import 'package:snap_share_orange/presentation/widgets/text_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool _isLoading = false;

  Future<void> _createUserSignUpDatabase(
      String email, String password, String name) async {
    try {
      _isLoading = true;
      setState(() {});
      await FireBaseAuth.createUserWithEmailAndPassword(email, password, name);
      await FireBaseAuth.signOutInEmailAndPassword();
      if (mounted) {
        ScaffoldMessage.showScafflodMessage(
            context, 'User Sign-Up Success', Colors.blueAccent);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LogInScreen()));
      }
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        if (mounted) {
          ScaffoldMessage.showScafflodMessage(
              context, 'Email is already in use', Colors.redAccent);
        }
      } else if (e.code == 'weak-password') {
        if (mounted) {
          ScaffoldMessage.showScafflodMessage(
              context, 'The password is too weak', Colors.redAccent);
        }
      }
    } catch (e) {
      print("Sign-Up Failed: ${e.toString()}");
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Inter your Name, Email and Password",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Name"),
                const SizedBox(
                  height: 5,
                ),
                _buildNameForm(),
                const Text("Email"),
                const SizedBox(
                  height: 5,
                ),
                _buildEmailForm(),
                const Text("Password"),
                const SizedBox(
                  height: 5,
                ),
                _buildPasswordForm(),
                const SizedBox(
                  height: 30,
                ),
                _buildSignUpButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return CustomElevatedButton(
      onPressed: _isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                await _createUserSignUpDatabase(_emailTEController.text,
                    _passwordTEController.text, _nameTEController.text);
              }
            },
      child: _isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            ),
    );
  }

  Widget _buildPasswordForm() {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: _passwordTEController,
        obscureText: !_passwordVisible,
        validator: (value) => TextValidator.passwordValidator(value),
        decoration: InputDecoration(
          hintText: 'Input Password',
          prefixIcon: const Icon(Icons.lock),
          suffix: IconButton(
            onPressed: () {
              _tooglePasswordVisible();
            },
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildNameForm() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: _nameTEController,
        decoration: InputDecoration(
          hintText: 'Input Name',
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) => TextValidator.textValidator(value),
      ),
    );
  }

  Widget _buildEmailForm() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: _emailTEController,
        decoration: InputDecoration(
          hintText: 'Input Email',
          prefixIcon: const Icon(Icons.email),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) => TextValidator.textValidator(value),
      ),
    );
  }

  void _tooglePasswordVisible() {
    _passwordVisible = !_passwordVisible;
    setState(() {});
  }
}
