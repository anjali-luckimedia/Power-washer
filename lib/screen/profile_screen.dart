import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_washer/blocs/user_edit_profile/user_edit_profile_bloc.dart';
import 'package:power_washer/blocs/user_edit_profile/user_edit_profile_state.dart';
import 'package:power_washer/blocs/user_profile/user_profile_bloc.dart';
import 'package:power_washer/blocs/user_profile/user_profile_event.dart';
import 'package:power_washer/blocs/user_profile/user_profile_state.dart';
import 'package:power_washer/utils/app_colors.dart';
import 'package:power_washer/utils/app_common/Bottom_navigation.dart';
import 'package:power_washer/utils/app_common/app_common_appbar.dart';
import 'package:power_washer/utils/app_common/app_font_styles.dart';
import 'package:power_washer/utils/app_images.dart';
import 'package:power_washer/utils/app_string.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/user_edit_profile/user_edit_profile_event.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final ImagePicker _photolibraryPicker = ImagePicker();
  File? _image;
  File _imageFile = File('');
  bool isSaveLoading = false;
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences preferences;

  String name = '';
  String email = '';
  String phone = '';
  bool isDataLoading = false; // Add this state to track loading

  void clearControllers() {

    nameController.clear();
    emailController.clear();
    phoneController.clear();

  }
  @override
  void initState() {
    // TODO: implement initState
    initPreference();
    super.initState();
  }

  void initPreference() async {
    preferences = await SharedPreferences.getInstance();

    // Retrieve the values from SharedPreferences
    name = preferences.getString(AppString.kName) ?? 'N/A';
    email = preferences.getString(AppString.kPEmail) ?? 'N/A';
    phone = preferences.getString(AppString.kPPhoneNo) ?? 'N/A';


    // String formattedDob = 'N/A';
    // if (dob != 'N/A') {
    //   try {
    //     DateTime parsedDob = DateTime.parse(dob); // Parse the string to DateTime
    //     formattedDob = DateFormat('dd-MM-yyyy').format(parsedDob); // Format it
    //   } catch (e) {
    //     print('Error parsing dob: $e');
    //   }
    // }
    // Print all the values
    print('Name: $name');
    print('Email: $email');
    print('Phone: $phone');

    setState(() {
      // Populate the controllers with the retrieved values
      nameController.text = name;
      emailController.text = email;
      phoneController.text = phone;

    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserProfileBLoc>().add(LoadUserProfilePageData());

    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      bottomNavigationBar: BottomNavigation(currentIndex: 3),
      appBar: CommonAppBar(
        backgroundColor: AppColors.kWhite,

        title: AppString.profile,
        iconData: Icons.arrow_back,
      ),
      body: BlocBuilder<UserProfileBLoc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator(color: AppColors.kBlack,));
          } else if (state is UserProfileLoaded) {
            final userData = state.userProfileModel;

            // nameController.text = userData.data!.name.toString();
            // emailController.text = userData.data!.email.toString();
            // phoneController.text = userData.data!.phone.toString();

            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Divider(color: AppColors.kLightGrey,thickness: 1,),
                      SizedBox(height: 20,),
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.kRed, AppColors.kRed1], // Define your gradient colors here
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                            ),
                            padding: EdgeInsets.all(2), // Adding padding for the border effect
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.kWhite,
                                    AppColors.kWhite,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                              ),
                              child: _image == null
                                  ? (userData.data!.profileImage?.isEmpty ?? true
                                  ?
                              ClipOval(
                                child: Image.network(
                                  AppImages.dummyImage,
                                  fit: BoxFit.cover,
                                  width: 120, // Ensures the image fully fits inside the container
                                  height: 120,
                                ),
                              )
                                  : ClipOval(child: Image.network(userData.data!.profileImage.toString(), fit: BoxFit.cover,
                                width: 120, // Ensures the image fully fits inside the container
                                height: 120,)))
                                  : ClipOval(child: Image.file(_image!, fit: BoxFit.cover,
                                width: 120, // Ensures the image fully fits inside the container
                                height: 120,)),


                              // child: ClipOval(
                              //   child: Image.network(
                              //     userData.data!.profileImage.toString(),
                              //     fit: BoxFit.cover,
                              //     width: 120, // Ensures the image fully fits inside the container
                              //     height: 120,
                              //   ),
                              // ),
                            ),
                          ),

                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),

                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(2), // Adding padding for the border effect

                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(100.0)),

                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.kWhite,
                                        AppColors.kWhite,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: AppColors.kRed,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text(userData.data!.name.toString().toUpperCase(),style: AppFontStyles.headlineMedium(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.kBlack,
                      )),
                      SizedBox(height: 40,),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              ),
                              padding: EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: const BorderRadius.all(Radius.circular(10.0)),),

                                child: Center(
                                  child: TextFormField(
                                    style: AppFontStyles.headlineMedium(fontSize: 16,fontWeight: FontWeight.w400),
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(vertical: 12),

                                        prefixIcon: Icon(Icons.account_circle_rounded,  color: AppColors.kYellow,)
                                    ),
                                  ),
                                ),
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              ),
                              padding: EdgeInsets.all(2),
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: const BorderRadius.all(Radius.circular(10.0)),),
                                child: Center(
                                  child: TextFormField(
                                    style: AppFontStyles.headlineMedium(fontSize: 16,fontWeight: FontWeight.w400),
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                                      border: InputBorder.none,
                                        prefixIcon: Icon(Icons.email_outlined,  color: AppColors.kYellow,)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [ AppColors.kRed,AppColors.kRed1], // Define your gradient colors here
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              ),
                              padding: EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: const BorderRadius.all(Radius.circular(10.0)),),
                                child: Center(
                                  child: TextFormField(

                                    style: AppFontStyles.headlineMedium(fontSize: 16,fontWeight: FontWeight.w400),
                                    controller: phoneController,
                                   maxLength: 10,
                                   keyboardType: TextInputType.phone,
                                   decoration: InputDecoration(
                                     counterText: '',
                                       contentPadding: EdgeInsets.symmetric(vertical: 12),
                                       border: InputBorder.none,
                                       prefixIcon: Icon(Icons.phone,  color: AppColors.kYellow,)

                                   ),
                                  ),
                                ),),
                            ),
                          ),
                          SizedBox(height: 35),

                          // Apply Button
                          BlocListener<UserEditProfileBloc, UserEditProfileState>(
                            listener: (context, state) {
                              if (state is UserEditProfileLoading) {
                                // Show a loading indicator or perform any other action when loading
                                showDialog(
                                  context: context,
                                  barrierDismissible: false, // Prevent dismissing the dialog
                                  builder: (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.kBlack,
                                    ),
                                  ),
                                );
                              } else if (state is UserEditProfileSuccess) {
                                Navigator.of(context).pop(); // Close the loading dialog
                                setState(() {
                                  isSaveLoading = false;
                                });

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                      (Route<dynamic> route) => false,
                                );
                              } else if (state is UserEditProfileFailure) {
                                Navigator.of(context).pop(); // Close the loading dialog
                                setState(() {
                                  isSaveLoading = false;
                                });
                                // Show error message or handle failure case
                              }
                            },
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.kRed,
                                      AppColors.kRed1,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      print('Name: ${nameController.text.trim()}');
                                      print('Email: ${emailController.text.trim()}');
                                      print('Phone: ${phoneController.text.trim()}');

                                      if (_image == null) {
                                        // Trigger the event without the image field
                                        context.read<UserEditProfileBloc>().add(
                                          EditProfileButtonPressed(
                                            name: nameController.text.trim(),
                                            email: emailController.text.trim(),
                                            phone: phoneController.text.trim(),
                                          ),
                                        );
                                      } else {
                                        // Trigger the event with the selected image
                                        context.read<UserEditProfileBloc>().add(
                                          EditProfileButtonPressed(
                                            name: nameController.text.trim(),
                                            email: emailController.text.trim(),
                                            phone: phoneController.text.trim(),
                                            image: _image!,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 12.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Text(
                                    AppString.update.toUpperCase(),
                                    style: AppFontStyles.headlineMedium(
                                      color: AppColors.kWhite,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 15),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          } else if (state is UserProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }


  void _showPicker(context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.kBlack
          : AppColors.kWhite,
      context: context,
      useSafeArea: true,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading:  Icon(Icons.photo_library,  color:AppColors.kBlack,),
              title:  Text('Photo Library',  style: AppFontStyles.headlineMedium(
                fontSize: 14,
                color: AppColors.kBlack,
                fontWeight: FontWeight.w400,
              ),),
              onTap: () {
                _imgFromGallery();
                Navigator.of(context).pop();
              },
            ),
            Divider(height: 10,  color: AppColors.kBlack,),
            ListTile(
              leading:  Icon(Icons.photo_camera,  color: AppColors.kBlack,),
              title:  Text('Camera',  style: AppFontStyles.headlineMedium(
                fontSize: 14,
                color: AppColors.kBlack,
                fontWeight: FontWeight.w400,
              ),),
              onTap: () {
                _imgFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _imgFromCamera() async {
    try {
      final image =
      // ignore: invalid_use_of_visible_for_testing_member
      await _photolibraryPicker.pickImage(
          source: ImageSource.camera, imageQuality: 70, maxWidth: 1000);

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          //CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ]
            : [
          //CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          //CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio5x3,
          // CropAspectRatioPreset.ratio5x4,
          // CropAspectRatioPreset.ratio7x5,
          // CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop',
          )
        ],
      );

      if (croppedFile != null) {
        //File _imageFile = File(croppedFile.path);
        setState(() {
          _image = File(croppedFile.path);

          // _imageFile = File(croppedFile!.path);
          // _image = new File(croppedFile.path);
        });
        // Dispatch the event to upload the image
        // BlocProvider.of<UploadUserProfileBloc>(context)
        //     .add(UploadUserProfileImageEvent(file: _imageFile));

        // Optionally, you can navigate to the settings page after a successful upload
        // This can be done inside the Bloc's listener when the success state is emitted
      }

      // UploadImgBloc().uploadImgSink(_image!).then((userResponse) {
      //   profileImage = userResponse.data[0].filename;
      // });
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  _imgFromGallery() async {
    try {
      final image =
      // ignore: invalid_use_of_visible_for_testing_member
      await _photolibraryPicker.pickImage(
          source: ImageSource.gallery, imageQuality: 70, maxWidth: 1000);

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          //CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ]
            : [
          //CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          //CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio5x3,
          // CropAspectRatioPreset.ratio5x4,
          // CropAspectRatioPreset.ratio7x5,
          // CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop',
          )
        ],
      );

      if (croppedFile != null) {
      //  File _imageFile = File(croppedFile.path);
        setState(() {
         // _imageFile = File(croppedFile!.path);
          _image = File(croppedFile.path);

        });
        // Dispatch the event to upload the image
        // BlocProvider.of<UploadUserProfileBloc>(context)
        //     .add(UploadUserProfileImageEvent(file: _imageFile));

        // Optionally, you can navigate to the settings page after a successful upload
        // This can be done inside the Bloc's listener when the success state is emitted
      }
      // UploadImgBloc().uploadImgSink(_image!).then((userResponse) {
      //   profileImage = userResponse.data[0].filename;
      // });
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }
}
