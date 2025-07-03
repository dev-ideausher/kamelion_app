import 'package:get/get.dart';

class FaqsController extends GetxController {
  //TODO: Implement FaqsController

  final count = 0.obs;
  List<String> faqQuestions = [
    "What is the purpose of the Kamelion app?",
    "Who is the app designed for?",
    "What features does the app include?",
    "How does the app personalise content for young people? ",
    "Is the app evidence-based?",
    "How does gamification work?",
    "Can young people access the app on different devices?",
    "How do young people log in?",
    "How does Kamelion align with schools that are reducing or restricting phone use?",
    "How does the app identify safeguarding concerns?",
    "What happens if a safeguarding concern is identified?",
    "When is confidentiality broken?",
    "What are the Licence Holder's safeguarding responsibilities?",
    "How is the community space moderated?",
    "What are the community guidelines?",
    "What data does Kamelion collect?",
    "How is data collected?",
    "What is the legal basis for data processing?",
    "How is data protected?",
    "Is personal data shared with third parties or schools?",
    "How is anonymised data used?",
    "What are users' data rights?",
    "Is parental consent required?",
    "What is the role of Licence Holders in implementation?",
    "How much staff involvement is needed?",
    "What onboarding and support is provided?",
    "How is student wellbeing progress measured?",
    "How can users or staff contact Kamelion?",
  ];
  final answers = <Object>[
    "Kamelion is a preventative mental health and wellbeing platform designed to empower young people. The app helps young people understand themselves better, cope with life’s challenges, and develop emotional literacy, resilience and healthy coping strategies. By combining interactive, gamified, and evidence-based content, Kamelion encourages self-reflection, builds positive mental habits, and supports long-term wellbeing outcomes. It aims to improve life engagement, school attendance, and academic performance through preventative, accessible support. ",
    "Kamelion is developed for young people aged 11 to 18. It is licensed by schools, local authorities, and organisations, who then distribute access to young people A license can also be purchased directly by a parent/carer. ",
    {
      'header': "Kamelion offers a comprehensive range of features including:",
      'bullets': <String>[
        "Educational courses and content on mental health, wellbeing and personal development topics.",
        "Challenges that encourage positive habits and goal-setting.",
        "Community Spaces that are safe, moderated environments for peer support and expression.",
        "Personality and wellbeing assessments to help young people gain personal insights and reflect.",
        "Gamification such as points, coins, badges, streaks, and rewards to motivate ongoing engagement.",
        "Personal wellbeing dashboard where young people can track their progress and activities.",
      ],
    },
    "The app begins with onboarding assessments that gauge a young person’s personality, interests, and wellbeing needs. Based on their results, Kamelion recommends personalised content and tracks individual engagement to further refine future recommendations. This ensures that each user receives a tailored experience aligned with their unique needs.",
        "Kamelion educational content is grounded in psychology, research and best practices to support youth mental health, wellbeing and personal development.  It is created by mental health and wellbeing professionals, and educators.",
    "Gamification is built into the app to promote motivation and build positive learning habits. Young people earn points/coins and badges for completing activities, courses, and challenges. Streaks and leaderboards encourage regular use, while rewards serve as incentives for building healthy self-investment habits early. These features are carefully designed to support intrinsic motivation and avoid undue pressure or competition.",
    "The app is available on iOS and Android.",
    "Young people receive secure licence codes distributed by a licence purchaser (e.g., a school, organisation, or parent/carer). The code is used to activate accounts and log in to the app. Each user’s account and data are tied to their individual login credentials.",
    "Kamelion is specifically designed to be used outside of school hours. Our aim is to meet young people where they are and provide a safe, positive and purposeful experience—after school, in the evenings, or on weekends. Through this, Kamelion complements the wellbeing support offered in schools while giving young people an outlet that’s aligned with their digital lives. Kamelion is about improving the quality of screen time young people get. It gives young people a healthy reason to pick up their phones and look after themselves, with content and activities that support, not distract from, their growth and mental health.",
    {
      'header': "Safeguarding risks may be flagged through several channels, including:",
      'bullets': <String>[
        "Moderated community interactions and flagged posts.",
        "Repeated or concerning use of the in‑app \"Support\" button.",
        "All risks are reviewed by trained safeguarding professionals.",
      ],
    },
    "When a concern is flagged, it is assessed by trained Kamelion safeguarding staff. If a risk is confirmed, the team provides appropriate support, including in-app guidance or signposting to trusted services. In serious cases, concerns are escalated to the nominated safeguarding lead at the young person’s school or local authority. If necessary, and in accordance with statutory guidance, relevant authorities may be informed.",
      "Confidentiality is always maintained except when there is a serious safeguarding concern, a legal requirement, or risk to life. In such cases, personal data may be shared with the appropriate safeguarding lead or external authorities in compliance with legal obligations and child protection policies.",
    {
      'header': "Schools, local authorities or organisations must:",
      'bullets': <String>[
        "Nominate a safeguarding contact.",
        "Have internal policies to respond to alerts.",
      ],
    },
    // 14 community moderation with footer
    {
      'header': "Community spaces are carefully moderated using a combination of:",
      'bullets': <String>[
        "Keyword filters.",
        "Manual review by moderators.",
        "User reporting tools.",
      ],
      'footer': "This ensures that the community remains a safe and respectful space.",
    },
    // 15 community guidelines with footer
    {
      'header': "Users must:",
      'bullets': <String>[
        "Treat others with respect.",
        "Not share personal or identifying information.",
        "Avoid promoting self-harm, hate, or violence.",
        "Uphold inclusivity and age-appropriate conduct.",
      ],
      'footer': "Violations result in content removal, education, warnings, or posting/account restrictions or deactivation. Repeated or serious breaches may be escalated.",
    },
    // 16 data collected
    {
      'header': "The platform collects:",
      'bullets': <String>[
        "User profile data (name, DOB, school, etc.)",
        "Device/browser information",
        "Usage and activity data",
        "Personality/wellbeing assessment results",
        "Special Category Data voluntarily shared by users (e.g., health and wellbeing information)",
      ],
    },
    // 17 data collection methods with footer
    {
      'header': "Data is collected as users engage with the app. This data can be both active (entered/given directly by the user) and passive (collected in the background).",
      'bullets': <String>[
        "Onboarding: Names, DOB, email addresses, school affiliation and onboarding questions.",
        "Mood tracking: Users log how they feel (e.g., happy, anxious, sad).",
        "Personality test insights: Support self-awareness and measure wellbeing levels (e.g., self-compassion, resilience).",
        "Journalling and content posted in the community.",
        "Goals: User sets personal goals and tracks their progress.",
        "Frequency and duration of app usage.",
        "Activities engaged with or interaction with specific features (e.g., challenges, journalling, community, courses, support button).",
        "Activity completion rate.",
        "Trends, habits and progress tracking.",
      ],
      'footer': "Data is collected and recorded to support mental health and wellbeing goals—to personalise the user experience, track progress, interventions, risk indicators, impact reporting, insights, research and improvement. Self-reported data is stored securely and treated as confidential.",
    },
    "Kamelion processes data under the basis of 'Legitimate Interest,' which allows it to provide the service, evaluate impact, and improve user outcomes in line with its stated purpose. Data is processed in accordance with GDPR and UK Data Protection legislation.",
    "Access is restricted to authorised personnel on a role-based, need-to-know basis. Data is encrypted during storage and transfer. User data is securely stored in the UK using trusted, encrypted cloud infrastructure.",
    {
      'header': "Personal data is not shared without explicit consent, except in the following situations:",
      'bullets': [
        "Service delivery: To operate the app effectively, limited personal data may be shared with trusted third-party service providers (e.g. hosting, technical support). These service providers are bound to handle data securely, confidentially and only for the purpose of providing services to Kamelion.",
        "Safeguarding: If there is a concern about a young person’s safety or wellbeing, relevant information may be shared with designated safeguarding leads or statutory bodies, in line with legal and child protection obligations.",
        "Legal compliance: In rare cases, data may be shared where required to meet legal obligations, such as in response to a court order or official investigation.",
      ],
      'footer': "Schools do not receive identifiable student data by default, unless individual access has been granted through consent. Schools are only provided with anonymised, aggregated reports to help monitor overall wellbeing trends.",
    },
    {
      'header': "Anonymised data is used for:",
      'bullets': [
        "Evaluating app impact",
        "Improving content and accessibility",
        "Reporting on trends",
        "Supporting research",
        "Service development and commercial planning",
      ],
      'footer': "It does not contain any identifiable information.",
    },
    {
      'header': "Users can:",
      'bullets': [
        "Access and correct their data",
        "Request deletion or data portability",
        "Object to or restrict processing",
        "Withdraw consent (where applicable)",
      ],
    },
    "Kamelion is a preventative and early help mental health service, under UK GDPR and the Data Protection Act 2018. Parental consent is not required for users of any age. This is consistent with Section 9 of the Data Protection Act 2018 and Recital 38 of UK GDPR.",
    {
      'header': "Licence Holders (e.g., schools, local authorities or organisations) are responsible for:",
      'bullets': [
        "Building awareness of the platform",
        "Distributing licence codes to young people",
        "Nominating an officer to oversee the project and safeguarding lead",
        "Collaboration to ensure transparent progress monitoring and early issue identification."
      ]
    },
    "The app is designed to be self-directed and reduce staff workload. Staff are mainly involved in introducing the app, building awareness of the app, distributing licences, responding to alerts and using anonymised reports to inform wellbeing strategies. Schools should assign a nominated officer to oversee the project.",
    {
      'header': "Kamelion provides comprehensive onboarding including:",
      'bullets': [
        "Training for staff and young people",
        "Technical and implementation support",
        "Ongoing updates and user guides",
        "Optional live sessions, webinars, or workshops on the platform"
      ]
    },
    {
      'header': "The app tracks:",
      'bullets': [
        "Course and challenge completion",
        "Engagement patterns and trends",
        "Changes in self-reported wellbeing"
      ],
      'footer': "Schools receive anonymised trend reports, which help evaluate impact and identify areas for support."
    },
    {
      'header': "Support is available:",
      'bullets': [
        "In-app via contact us",
        "By email: hello@kamelion.co",
        "By post to the registered office",
        "Licence Holders are provided with contact information for safeguarding and technical queries."
      ]
    },




  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
