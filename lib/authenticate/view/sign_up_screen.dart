import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../googlemap/service/location_service.dart';
import '../../loading/loading_cubit.dart';
import '../../tools/constants.dart';
import '../../viewmodel/viewmodel.dart';
import '../service/authentication_bloc.dart';
import '../signupService/sign_up_bloc.dart';
import '../signupService/sign_up_event.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  Uint8List? _imageData;
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  String? firstName, lastName, email, password, confirmPassword, phonenumber;
  double? lat, long;
  AutovalidateMode _validate = AutovalidateMode.disabled;
  bool acceptEULA = false;
  String userType = 'Customer';
  late LocationData location;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: Builder(
        builder: (context) {
          if (!kIsWeb && Platform.isAndroid) {
            context.read<SignUpBloc>().add(RetrieveLostDataEvent());
          }
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  context.read<LoadingCubit>().hideLoading();
                  if (state.authState == AuthState.authenticated) {
                    return ViewModel.route(context);
                  } else {
                    ViewModel.showSnackBar(
                        context,
                        state.message ??
                            'Couldn\'t sign up, Please try again.');
                  }
                },
              ),
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) async {
                  if (state is ValidFields) {
                    await context.read<LoadingCubit>().showLoading(
                        context, 'Creating new account, Please wait...', false);
                    if (!mounted) return;
                    context.read<AuthenticationBloc>().add(
                        SignupWithEmailAndPasswordEvent(
                            emailAddress: email!,
                            password: password!,
                            imageData: _imageData,
                            lastName: lastName,
                            firstName: firstName,
                            userType: userType,
                            lat: lat,
                            phonenumber: phonenumber,
                            rate: 0,
                            long: long));
                  } else if (state is SignUpFailureState) {
                    ViewModel.showSnackBar(context, state.errorMessage);
                  }
                },
              ),
            ],
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(
                    color: ViewModel.isDarkMode(context)
                        ? Colors.white
                        : Colors.black),
              ),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (old, current) =>
                      current is SignUpFailureState && old != current,
                  builder: (context, state) {
                    if (state is SignUpFailureState) {
                      _validate = AutovalidateMode.onUserInteraction;
                    }
                    return Form(
                      key: _key,
                      autovalidateMode: _validate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Create new account',
                              style: TextStyle(
                                  color: Color(0xffae0001),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 32, right: 8, bottom: 8),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                BlocBuilder<SignUpBloc, SignUpState>(
                                  buildWhen: (old, current) =>
                                      current is PictureSelectedState &&
                                      old != current,
                                  builder: (context, state) {
                                    if (state is PictureSelectedState) {
                                      _imageData = state.imageData;
                                    }
                                    return state is PictureSelectedState
                                        ? SizedBox(
                                            height: 130,
                                            width: 130,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(65),
                                                child: state.imageData == null
                                                    ? Image.asset(
                                                        'assets/images/placeholder.jpg',
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.memory(
                                                        state.imageData!,
                                                        fit: BoxFit.cover,
                                                      )),
                                          )
                                        : SizedBox(
                                            height: 130,
                                            width: 130,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(65),
                                              child: Image.asset(
                                                'assets/images/placeholder.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                  },
                                ),
                                Positioned(
                                  right: 0,
                                  child: FloatingActionButton(
                                    backgroundColor: const Color(0xffae0001),
                                    mini: true,
                                    onPressed: () => _onCameraClick(context),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: ViewModel.isDarkMode(context)
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              validator: ViewModel.validateName,
                              onSaved: (String? val) {
                                firstName = val;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: ViewModel.getInputDecoration(
                                  hint: 'First Name',
                                  darkMode: ViewModel.isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              validator: ViewModel.validateName,
                              onSaved: (String? val) {
                                lastName = val;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: ViewModel.getInputDecoration(
                                  hint: 'Last Name',
                                  darkMode: ViewModel.isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: ViewModel.validateEmail,
                              onSaved: (String? val) {
                                email = val;
                              },
                              decoration: ViewModel.getInputDecoration(
                                  hint: 'Email',
                                  darkMode: ViewModel.isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              textCapitalization: TextCapitalization.words,
                              onSaved: (String? val) {
                                phonenumber = val;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: ViewModel.getInputDecoration(
                                  hint: 'Phone Number',
                                  darkMode: ViewModel.isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              controller: _passwordController,
                              validator: ViewModel.validatePassword,
                              onSaved: (String? val) {
                                password = val;
                              },
                              style:
                                  const TextStyle(height: 0.8, fontSize: 18.0),
                              cursorColor: Color(colorPrimary),
                              decoration: ViewModel.getInputDecoration(
                                  hint: 'Password',
                                  darkMode: ViewModel.isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 8.0, left: 8.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) =>
                                  context.read<SignUpBloc>().add(
                                        ValidateFieldsEvent(_key,
                                            acceptEula: acceptEULA),
                                      ),
                              obscureText: true,
                              validator: (val) =>
                                  ViewModel.validateConfirmPassword(
                                      _passwordController.text, val),
                              onSaved: (String? val) {
                                confirmPassword = val;
                              },
                              style:
                                  const TextStyle(height: 0.8, fontSize: 18.0),
                              cursorColor: const Color(colorPrimary),
                              decoration: ViewModel.getInputDecoration(
                                  hint: 'Confirm Password',
                                  darkMode: ViewModel.isDarkMode(context),
                                  errorColor: Theme.of(context).errorColor),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 16.0, right: 15, left: 15),
                            child: Text(
                              "Enter your Role Type :",
                              style: TextStyle(fontSize: 15, color: gold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 8.0, left: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: DropdownButtonFormField(
                                borderRadius: BorderRadius.circular(25.0),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: primecolor,
                                        width: 2), //<-- SEE HERE
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                        color: gold, width: 1), //<-- SEE HERE
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                dropdownColor: Colors.white,
                                value: userType,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    userType = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Customer',
                                  'Truck',
                                  'Mechanic',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black54),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 40.0, left: 40.0, top: 40.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(
                                      MediaQuery.of(context).size.width / 1.5),
                                  backgroundColor: black,
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                      color: black,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Enter Your Location',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  location =
                                      await LocationService().getLocation();
                                  setState(() {
                                    lat = location.latitude;
                                    long = location.longitude;
                                    print(lat);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 40.0, left: 40.0, top: 40.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(
                                    MediaQuery.of(context).size.width / 1.5),
                                backgroundColor: primecolor,
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: const BorderSide(
                                    color: primecolor,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              onPressed: () => context.read<SignUpBloc>().add(
                                  ValidateFieldsEvent(_key,
                                      acceptEula: acceptEULA)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ListTile(
                            trailing: BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (old, current) =>
                                  current is EulaToggleState && old != current,
                              builder: (context, state) {
                                if (state is EulaToggleState) {
                                  acceptEULA = state.eulaAccepted;
                                }
                                return Checkbox(
                                  onChanged: (value) =>
                                      context.read<SignUpBloc>().add(
                                            ToggleEulaCheckboxEvent(
                                              eulaAccepted: value!,
                                            ),
                                          ),
                                  activeColor: const Color(0xffae0001),
                                  value: acceptEULA,
                                );
                              },
                            ),
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text:
                                        'By creating an account you agree to our ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextSpan(
                                    style: const TextStyle(
                                      color: Color(0xffae0001),
                                    ),
                                    text: 'Terms of Use',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (await canLaunchUrl(
                                            Uri.parse(eula))) {
                                          await launchUrl(
                                            Uri.parse(eula),
                                          );
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onCameraClick(BuildContext context) {
    if (kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      context.read<SignUpBloc>().add(ChooseImageFromGalleryEvent());
    } else {
      final action = CupertinoActionSheet(
        title: const Text(
          'Add Profile Picture',
          style: TextStyle(fontSize: 15.0),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: false,
            onPressed: () async {
              Navigator.pop(context);
              context.read<SignUpBloc>().add(ChooseImageFromGalleryEvent());
            },
            child: const Text('Choose from gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () async {
              Navigator.pop(context);
              context.read<SignUpBloc>().add(CaptureImageByCameraEvent());
            },
            child: const Text('Take a picture'),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context)),
      );
      showCupertinoModalPopup(context: context, builder: (context) => action);
    }
  }

  // Gradient gradient2 = LinearGradient(
  //   colors: [
  //     Theme.of(context).primaryColorLight.withOpacity(0.8),
  //     Theme.of(context).primaryColorLight.withOpacity(0.8),
  //   ],
  //   begin: Alignment.centerLeft,
  //   end: Alignment.centerRight,
  // );

  TextStyle basicStyle = const TextStyle(color: Colors.white, fontSize: 16);

  @override
  void dispose() {
    _passwordController.dispose();
    _imageData = null;
    super.dispose();
  }
}
