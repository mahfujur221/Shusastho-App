import 'package:ecommerce_shop/controllers/auth_service.dart';
import 'package:flutter/material.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 120),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                    const Text("Create a new account and get started"),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) => value!.isEmpty ? "Name cannot be empty." : null,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Name"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) => value!.isEmpty ? "Email cannot be empty." : null,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) =>
                      value!.length < 8 ? "Password should have at least 8 characters." : null,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      String result = await AuthService().createAccountWithEmail(
                        _nameController.text.trim(),
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );

                      setState(() {
                        isLoading = false;
                      });

                      if (!mounted) return;

                      if (result == "Account Created") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Account Created")),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/home", (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result, style: const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.red.shade400,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Sign Up", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
