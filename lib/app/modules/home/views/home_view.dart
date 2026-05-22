import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final homeKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isDesktop = size.width > 1100;
    final isTablet = size.width > 700 && size.width <= 1100;

    return Scaffold(
      backgroundColor: const Color(0xffF4F7FF),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffF8FAFF),
                  Color(0xffEEF4FF),
                  Color(0xffFFF5FB),
                ],
              ),
            ),
          ),

          const AnimatedBlob(
            top: -120,
            left: -80,
            size: 320,
            color: Color(0xff6C63FF),
          ),

          const AnimatedBlob(
            bottom: -150,
            right: -80,
            size: 350,
            color: Color(0xff00C2FF),
          ),

          const AnimatedBlob(
            top: 300,
            right: -60,
            size: 220,
            color: Color(0xffFF4D8D),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  AnimatedSnakeBorder(
                    radius: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.72),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(.7),
                            ),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xff6C63FF),
                                          Color(0xff00C2FF),
                                        ],
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.flutter_dash,
                                      color: Colors.white,
                                    ),
                                  ),

                                  const SizedBox(width: 16),

                                  Text(
                                    "Vivek Mudgal",
                                    style: GoogleFonts.greatVibes(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w600,
                                      foreground: Paint()
                                        ..shader =
                                            const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xff4F46E5),
                                                Color(0xff7C3AED),
                                                Color(0xff06B6D4),
                                              ],
                                            ).createShader(
                                              const Rect.fromLTWH(
                                                0,
                                                0,
                                                320,
                                                80,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),

                              if (isDesktop)
                                Row(
                                  children: [
                                    navItem(
                                      "Home",
                                      () => scrollToSection(homeKey),
                                    ),

                                    navItem(
                                      "Skills",
                                      () => scrollToSection(skillsKey),
                                    ),

                                    navItem(
                                      "Projects",
                                      () => scrollToSection(projectKey),
                                    ),

                                    navItem("Resume", () {
                                      showResumeDialog(context, controller);
                                    }),

                                    navItem(
                                      "Contact",
                                      () => scrollToSection(contactKey),
                                    ),
                                  ],
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.menu_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).animate().fade(duration: 600.ms).slideY(begin: -.2),
                  SizedBox(height: isDesktop ? 70 : 40),

                  Container(
                    key: homeKey,
                    child: isDesktop
                        ? Row(
                            children: [
                              Expanded(child: heroText()),
                              const SizedBox(width: 40),
                              Expanded(child: heroImage()),
                            ],
                          )
                        : Column(
                            children: [
                              heroImage(),
                              const SizedBox(height: 30),
                              heroText(),
                            ],
                          ),
                  ),

                  SizedBox(height: isDesktop ? 80 : 50),

                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: const [
                      GlassCard(title: "1+", subtitle: "Years Experience"),

                      GlassCard(title: "10+", subtitle: "Projects Completed"),

                      GlassCard(title: "5+", subtitle: "Happy Clients"),
                    ],
                  ),

                  SizedBox(height: isDesktop ? 90 : 60),

                  Container(
                    key: skillsKey,
                    child: sectionTitle("Skills & Expertise"),
                  ),

                  const SizedBox(height: 40),

                  Wrap(
                    spacing: 22,
                    runSpacing: 22,
                    alignment: WrapAlignment.center,
                    children: const [
                      SkillCard(
                        title: "Flutter",
                        icon: Icons.flutter_dash,
                        color: Color(0xff00C2FF),
                      ),

                      SkillCard(
                        title: "GetX",
                        icon: Icons.bolt,
                        color: Color(0xff10B981),
                      ),
                      SkillCard(
                        title: "REST APIs",
                        icon: Icons.api,
                        color: Color(0xff6366F1),
                      ),

                      SkillCard(
                        title: "State Management",
                        icon: Icons.settings_suggest,
                        color: Color(0xff14B8A6),
                      ),
                      SkillCard(
                        title: "Firebase",
                        icon: Icons.local_fire_department,
                        color: Color(0xffFF7A00),
                      ),
                      SkillCard(
                        title: "UI/UX",
                        icon: Icons.palette,
                        color: Color(0xffFF4D8D),
                      ),

                      SkillCard(
                        title: "Responsive UI",
                        icon: Icons.devices,
                        color: Color(0xffF59E0B),
                      ),
                    ],
                  ),

                  SizedBox(height: isDesktop ? 100 : 60),

                  Container(
                    key: projectKey,
                    child: sectionTitle("Featured Projects"),
                  ),

                  const SizedBox(height: 40),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isDesktop
                        ? 3
                        : isTablet
                        ? 2
                        : 1,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25,
                    childAspectRatio: 1.1,
                    children: const [
                      ProjectCard(
                        appUrl:
                            'https://play.google.com/store/search?q=waaree%20prime&c=apps&hl=en_IN',
                        title: "Waaree Prime+",
                        subtitle:
                            "Waaree Group App is a modern enterprise-level Flutter application developed for the solar and energy sector. The app delivers a smooth, scalable, and user-friendly experience with responsive UI, secure API integration, real-time data handling, and optimized performance. It is designed to streamline business operations, improve user engagement, and provide seamless accessibility across Android devices.",
                        colors: [Color(0xff6C63FF), Color(0xff8B7CFF)],
                      ),
                      ProjectCard(
                        appUrl:
                            'https://play.google.com/store/apps/details?id=com.almonds.somany&hl=en_IN',
                        title: "Somany Sales Hero",
                        subtitle:
                            "Somany Sales Hero is a reward and engagement application designed for sales representatives associated with authorized Somany dealers. The app enables users to upload product invoices, earn reward points, track performance, and redeem rewards directly from an integrated catalogue.",
                        colors: [Color(0xff00C2FF), Color(0xff5CE1FF)],
                      ),

                      ProjectCard(
                        appUrl: 'https://play.google.com/store/apps/details?id=com.almonds.vijayibhava&hl=en_IN',
                        title: "Vijayi Bhava",
                        subtitle:
                            "Vijayi Bhava is a rewards and loyalty application designed for mechanics and retailers, helping users earn points through QR code scanning, track rewards, and redeem exciting gifts. Built with Flutter, the app delivers a smooth and engaging experience with realtime point tracking, secure authentication, responsive UI, and seamless reward management.",
                        colors: [Color(0xffFF4D8D), Color(0xffFF9EBB)],
                      ),
                    ],
                  ),

                  SizedBox(height: isDesktop ? 100 : 70),

                  Container(
                    key: contactKey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 45,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff6C63FF),
                          Color(0xff00C2FF),
                          Color(0xffFF4D8D),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Let’s Build Something Amazing 🚀",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "Available for freelance projects and full-time opportunities.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(.9),
                            fontSize: 18,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 30),

                        Container(
                          height: 62,
                          width: 230,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (_) {
                                  return Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 5,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 25),

                                        Text(
                                          "Contact Me",
                                          style: GoogleFonts.poppins(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff111827),
                                          ),
                                        ),

                                        const SizedBox(height: 25),

                                        contactOption(
                                          icon: Icons.call,
                                          title: "Call",
                                          color: Colors.green,
                                          onTap: () {
                                            Get.back();
                                            controller.makeCall();
                                          },
                                        ),

                                        const SizedBox(height: 16),

                                        contactOption(
                                          icon: Icons.message,
                                          title: "WhatsApp",
                                          color: const Color(0xff25D366),
                                          onTap: () {
                                            Get.back();
                                            controller.openWhatsApp();
                                          },
                                        ),

                                        const SizedBox(height: 16),

                                        contactOption(
                                          icon: Icons.email,
                                          title: "Email",
                                          color: const Color(0xffEA4335),
                                          onTap: () {
                                            Get.back();
                                            controller.sendEmail();
                                          },
                                        ),

                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Contact Me >",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: const Color(0xff374151),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [Color(0xff6C63FF), Color(0xff00C2FF)],
        ).createShader(bounds);
      },
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget heroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSnakeBorder(
          radius: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              "✨ Flutter Developer • 1+ Years Experience",
              style: GoogleFonts.poppins(
                color: const Color(0xff6C63FF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        Text(
          "Turning Ideas Into\nBeautiful Apps",
          style: GoogleFonts.poppins(
            color: const Color(0xff111827),
            fontSize: 65,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ).animate().fade(duration: 800.ms).slideX(begin: -.2),

        const SizedBox(height: 25),

        Text(
          "Flutter Developer with 1+ years of experience building scalable mobile applications with beautiful UI, smooth performance, Firebase integration, API handling and modern architecture. Worked on enterprise level projects like Waaree, Somany and Vijayi Bhava.",
          style: GoogleFonts.poppins(
            color: const Color(0xff6B7280),
            fontSize: 18,
            height: 1.8,
          ),
        ),

        const SizedBox(height: 35),

        Container(
          height: 62,
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xff6C63FF), Color(0xff00C2FF)],
            ),
          ),
          child: MaterialButton(
            onPressed: () {
              scrollToSection(contactKey);
            },
            child: Text(
              "Hire Me >>",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget heroImage() {
    return Center(
      child: Animate(
        onPlay: (controller) {
          controller.repeat(reverse: true);
        },
        effects: [
          MoveEffect(
            begin: const Offset(0, -10),
            end: const Offset(0, 10),
            duration: const Duration(seconds: 3),
            curve: Curves.easeInOut,
          ),
        ],
        child: Lottie.network(
          "https://assets10.lottiefiles.com/packages/lf20_w51pcehl.json",
          height: 500,
        ),
      ),
    );
  }
}

class AnimatedBlob extends StatefulWidget {
  final double size;
  final Color color;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const AnimatedBlob({
    super.key,
    required this.size,
    required this.color,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  State<AnimatedBlob> createState() => _AnimatedBlobState();
}

class _AnimatedBlobState extends State<AnimatedBlob>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      bottom: widget.bottom,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + controller.value * .12,
            child: child,
          );
        },
        child: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withOpacity(.18),
          ),
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const GlassCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.75),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: const Color(0xff111827),
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: const Color(0xff6B7280),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const SkillCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 42),
          ),

          const SizedBox(height: 18),

          SizedBox(
            height: 65,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xff111827),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> colors;
  final String appUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.appUrl,
  });

  Future<void> openApp() async {
    final Uri url = Uri.parse(appUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(35),
      onTap: openApp,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          gradient: LinearGradient(colors: colors),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.18),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.phone_iphone,
                color: Colors.white,
                size: 34,
              ),
            ),

            const Spacer(),

            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(.9),
                fontSize: 12,
                height: 1.7,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Text(
                  "View App",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(width: 8),

                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget contactOption({
  required IconData icon,
  required String title,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 18),

          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xff111827),
            ),
          ),

          const Spacer(),

          const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        ],
      ),
    ),
  );
}

void showResumeDialog(BuildContext context, HomeController controller) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Resume",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "View or Download your resume",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              controller.viewResume();
            },
            child: const Text("View"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.downloadResume();
            },
            child: const Text("Download"),
          ),
        ],
      );
    },
  );
}

class AnimatedSnakeBorder extends StatefulWidget {
  final Widget child;
  final double radius;

  const AnimatedSnakeBorder({super.key, required this.child, this.radius = 40});

  @override
  State<AnimatedSnakeBorder> createState() => _AnimatedSnakeBorderState();
}

class _AnimatedSnakeBorderState extends State<AnimatedSnakeBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // continuous
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: SnakeLinePainter(
            progress: controller.value,
            radius: widget.radius,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class SnakeLinePainter extends CustomPainter {
  final double progress;
  final double radius;

  SnakeLinePainter({required this.progress, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(-2, -2, size.width + 4, size.height + 4);

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final path = Path()..addRRect(rrect);

    final metric = path.computeMetrics().first;

    const snakeLength = 120.0;

    final end = metric.length * progress;

    final start = end - snakeLength;

    for (double i = 0; i < snakeLength; i++) {
      final current = start + i;

      final tangent = metric.getTangentForOffset(current % metric.length);

      if (tangent == null) continue;

      final t = i / snakeLength;

      final strokeWidth = lerpDouble(1.2, 5.5, t)!;

      final opacity = lerpDouble(.15, 1, t)!;

      final paint = Paint()
        ..color = const Color(0xff8B0000).withOpacity(opacity)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      final nextTangent = metric.getTangentForOffset(
        (current + 1) % metric.length,
      );

      if (nextTangent != null) {
        canvas.drawLine(tangent.position, nextTangent.position, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SnakeLinePainter oldDelegate) {
    return true;
  }
}
