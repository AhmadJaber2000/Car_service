import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
        backgroundColor: Color(0xff004c4c),
      ),
      backgroundColor: Color(0xffb2d8d8),
      body: ContactUs(
        logo: AssetImage(
            'assets/images/car-service-logo-template_175455-original (1)-fococlipping-standard.png'),
        email: 'ahmad.jper.aj@gmail.com',
        companyName: 'Abhishek Doshi',
        phoneNumber: '+962786667736',
        dividerThickness: 2,
        website: 'https://abhishekdoshi.godaddysites.com',
        githubUserName: 'AbhishekDoshi26',
        linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
        tagLine: 'Flutter Developer',
        twitterHandle: 'AbhishekDoshi26',
        textColor: Colors.black,
        cardColor: Colors.white,
        companyColor: Colors.white,
        taglineColor: Colors.white,
      ),
    );
  }
}
