import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../responsive.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return mobileHeader();
    } else {
      return tabHeader();
    }
  }

  Row tabHeader() {
    return Row(
      children: [
        Text(
          "Dashboard+",
          style: TextStyle(color: Color(0xff946b2d), fontSize: 25),
        ),
        Spacer(),
        Expanded(
          child: SearchField(),
        ),
        // ProfileCard(),
      ],
    );
  }

  Column mobileHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dashboard",
                style: TextStyle(color: Color(0xff946b2d), fontSize: 15)),
          ],
        ),
        SizedBox(
          height: defaultPadding,
        ),
        //Spacer(),
        Row(
          children: [
            Expanded(
              child: SearchField(),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(color: Colors.white),
        fillColor: Color(0xff222f5b),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          focusColor: Color(0xff946b2d),
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * .75),
            margin: EdgeInsets.all(defaultPadding / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
