import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FaqsScreen extends StatelessWidget {
  FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Iconsax.arrow_left,
            color: Color(0xff041C40),
          ),
        ),
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 1,
        title: const Text(
          "FAQs",
          style: TextStyle(
            color: Color(0xff03132B),
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Accordion(
        maxOpenSections: 1,
        headerBackgroundColorOpened: Colors.black54,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding:
            const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: [
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'What is Lawploy?', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              "Lawploy is a platform that opens employment opportunities for lawyer, to employ and be employed, smooth and easy employment process for lawyers to employ another lawyer to hold brief, for corporate organization, recruitment firms and individuals is to employ lawyers for respective roles.", 
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'Is Lawploy free?', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              "Yes, Lawploy is 100% free for all users from all the locations.", 
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'Must I register to use Lawploy?', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              "Yes, every user of Lawploy would need an account to be able to have a full access to Lawploy services; A new user coming on the platform should create a user account to be able to enjoy the full benefits that Lawploy represents, the existing account to enjoy the full services of Lawploy.", 
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'Can I use Lawploy from anywhere?', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              "Yes, Lawploy is available for use in all locations that you may be at the time you are accessing the platform.", 
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'What do I need to access Lawploy?', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              "You only need your smartphone or PC with internet connection to access Lawploy.", 
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'Who is eligible to use Lawploy?', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              """
              The following persons are eligible to use Lawploy:
              A lawyer who is qualified and called to practice law in his or her jurisdiction, country or region.
              A law firm that employs lawyers for associate positions, trainer positions, senior associate positions, management positions, principal positions etc.
              Corporation/Companies that employs lawyers for respective positions in the establishments.
              Recruitment firms that recruit lawyers for job placement for their respective corporate clients.
              Individuals that need to employ the services of lawyers on full time as personal lawyer, part time etc.
              """, 
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'How do I register on Lawploy', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              "To register on Lawploy, you need a working email address, address, phone number.\nYou can register on any one of the three categories: as a lawyer, as a corporation/recruitment firms or as an individual. First time on the platform, click on the registration button and follow the easy registration process.", 
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'What if a registered users chooses to switch to a different account ?', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              "A user who first registered as a private individual on certain category may switch to a different category by following the easy process", 
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
          AccordionSection(
            rightIcon: const Icon(Iconsax.arrow_down_1, color: Color(0xffCFCFCF)),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            header: const Text(
              'What can i do with Lawpoy as a non-lawyer?', 
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700
              )
            ),
            content: const Text(
              "Non-lawyers registered on Lawploy will be able to use Lawploy to employ lawyers for legal services.", 
              style: TextStyle(
                color: Color(0xff5E5E5E)
              )
            ),
            contentBorderColor: Colors.white,
            headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
          ),
        ]
      )
    );
  }
}