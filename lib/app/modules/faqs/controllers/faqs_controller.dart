import 'package:get/get.dart';

class FaqsController extends GetxController {
  //TODO: Implement FaqsController

  final count = 0.obs;
  List<String> faqQuestions = [
    "Who is Kamelion for?",
    "What makes Kamelion different from other apps?",
    "What is the Kamelion reward system?",
    "How do I sign up for Kamelion?",
    "How can I collaborate with Kamelion?"
  ];
  List<String> answers = [
    "Kamelion is designed for young people, educators, local authorities, organisations and parents to support young people in navigating life and prioritising mental health, personal development and holistic wellbeing. Through interactive tools, expert insights and a supportive community, we help users build self-awareness, resilience and personal growth. Kamelion offers tailored solutions by providing personalised learning tools to support student wellbeing and track engagement.",
    "Kamelion was co-produced with young people in Suffolk, UK. We combine evidence-backed insights with a gamified experience, making mental health, wellbeing and self-growth engaging and rewarding. We focus on helping young people develop self-acceptance, emotional intelligence and a strong sense of purpose.",
    "KaliKoins are our wellbeing virtual reward system that encourages young people to engage with wellbeing activities. Coins can be earned by completing mental gym workouts, challenges, reflecting on experiences and staying consistent with self investment and personal growth.",
    "Kamelion is accessible through license codes purchased by educators, local authorities, and organisations across various industries. If you have a license code, you can use it to create an account and start exploring. If you do not have a licence code, contact us on hello@kamelion.co or still sign up and we will send you details on how to obtain a licence.",
    "We love working with educators, mental health professionals and organisations that share our mission. Get in touch with us at hello@kamelion.co ",
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
