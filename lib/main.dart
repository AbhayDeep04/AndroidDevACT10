import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Navigation Demo',
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
  // A GlobalKey to uniquely identify the FormBuilder and allow validation
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
          child: Column(
            children: [
              // First Name
              FormBuilderTextField(
                name: 'first_name',
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(
                  errorText: 'First name is required',
                ),
              ),
              const SizedBox(height: 16),

              // Last Name
              FormBuilderTextField(
                name: 'last_name',
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(
                  errorText: 'Last name is required',
                ),
              ),
              const SizedBox(height: 16),

              // Email
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Email is required'),
                  FormBuilderValidators.email(
                      errorText: 'Enter a valid email address'),
                ]),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Contact Number
              FormBuilderTextField(
                name: 'contact_no',
                decoration: const InputDecoration(
                  labelText: 'Contact No.',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Contact number is required'),
                  FormBuilderValidators.numeric(errorText: 'Must be digits only'),
                  FormBuilderValidators.minLength(7, errorText: 'Too short'),
                ]),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Date of Birth
              FormBuilderDateTimePicker(
                name: 'dob',
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                validator: FormBuilderValidators.required(
                    errorText: 'Date of birth is required'),
              ),
              const SizedBox(height: 16),

              // Aadhar No
              FormBuilderTextField(
                name: 'aadhar_no',
                decoration: const InputDecoration(
                  labelText: 'Aadhar No.',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Aadhar number is required'),
                  FormBuilderValidators.numeric(
                      errorText: 'Must be digits only'),
                  FormBuilderValidators.minLength(12,
                      errorText: 'Must be at least 12 digits'),
                  FormBuilderValidators.maxLength(12,
                      errorText: 'Must be 12 digits'),
                ]),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Address
              FormBuilderTextField(
                name: 'address',
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(
                    errorText: 'Address is required'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),

              // Password
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Password is required'),
                  FormBuilderValidators.minLength(6,
                      errorText: 'Minimum 6 characters'),
                ]),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    // If valid, retrieve form data
                    final formData = _formKey.currentState?.value;
                    // Navigate to ConfirmationPage, passing formData
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationPage(
                          formData: formData,
                        ),
                      ),
                    );
                  } else {
                    // Show error if validation fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Validation failed. Please check your inputs.'),
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

class ConfirmationPage extends StatelessWidget {
  final Map<String, dynamic>? formData;
  const ConfirmationPage({super.key, this.formData});

  @override
  Widget build(BuildContext context) {
    // Retrieve first_name from formData for display
    final firstName = formData?['first_name'] ?? 'No Name';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Signup Successful, $firstName!',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Pop back to the SignUpPage (or wherever you came from)
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
