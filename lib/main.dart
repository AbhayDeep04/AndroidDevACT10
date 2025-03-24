import 'package:flutter/material.dart';
// Add form builder and validators:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // A GlobalKey to uniquely identify the FormBuilder widget and allow validation
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          // Optional: Enable autovalidation behavior
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              // FIRST NAME
              FormBuilderTextField(
                name: 'first_name',
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'First name is required'),
                ]),
              ),
              const SizedBox(height: 16),

              // LAST NAME
              FormBuilderTextField(
                name: 'last_name',
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Last name is required'),
                ]),
              ),
              const SizedBox(height: 16),

              // EMAIL
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Email is required'),
                  FormBuilderValidators.email(errorText: 'Enter a valid email address'),
                ]),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // CONTACT NUMBER
              FormBuilderTextField(
                name: 'contact_no',
                decoration: const InputDecoration(
                  labelText: 'Contact No.',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Contact number is required'),
                  FormBuilderValidators.numeric(errorText: 'Must be digits only'),
                  FormBuilderValidators.minLength(7, errorText: 'Too short'),
                ]),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // DATE OF BIRTH with calendar widget
              FormBuilderDateTimePicker(
                name: 'dob',
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                // Example: limit range if needed
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                validator: FormBuilderValidators.required(errorText: 'Date of birth is required'),
              ),
              const SizedBox(height: 16),

              // AADHAR NO
              FormBuilderTextField(
                name: 'aadhar_no',
                decoration: const InputDecoration(
                  labelText: 'Aadhar No.',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Aadhar number is required'),
                  FormBuilderValidators.numeric(errorText: 'Must be digits only'),
                  FormBuilderValidators.minLength(12, errorText: 'Must be at least 12 digits'),
                  FormBuilderValidators.maxLength(12, errorText: 'Must be 12 digits'),
                ]),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // ADDRESS
              FormBuilderTextField(
                name: 'address',
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(errorText: 'Address is required'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),

              // PASSWORD (if required)
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Password is required'),
                  FormBuilderValidators.minLength(6, errorText: 'Minimum 6 characters'),
                ]),
              ),
              const SizedBox(height: 24),

              // SUBMIT BUTTON
              ElevatedButton(
                onPressed: () {
                  // Validate the form and save values
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    // If valid, retrieve form data
                    final formData = _formKey.currentState?.value;
                    // For demonstration, just show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Signup Successful! Data: $formData'),
                      ),
                    );
                    // Navigate to another page or do further processing here
                  } else {
                    // If invalid, show a snackbar or highlight errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Validation failed. Please check your inputs.'),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
