import 'package:flutter/material.dart';
import '../../admin_dashboard/shedule/AddScheduleScreen.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> schedules = [
      {'date': 'Monday', 'time': '8:00-10:00', 'class': 'Lorem spein'},
      {'date': 'Tuesday', 'time': '10:00-12:00', 'class': 'Lorem spein'},
      {'date': 'Wednesday', 'time': '1:00-3:00', 'class': 'Lorem spein'},
      {'date': 'Thursday', 'time': '2:00-4:00', 'class': 'Lorem spein'},
      {'date': 'Friday', 'time': '9:00-11:00', 'class': 'Lorem spein'},
      {'date': 'Saturday', 'time': '10:00-12:00', 'class': 'Lorem spein'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Top background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/shedulescreen.png', // Replace with your image path
              fit: BoxFit.cover,
              height: 190,
            ),
          ),
          // Back arrow button
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 7, 7, 7),
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Main content
          Column(
            children: [
              const SizedBox(height: 150), // Space for top image and back button
              Expanded(
                child: _buildScheduleSection(context, schedules),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget for the schedule section
  Widget _buildScheduleSection(BuildContext context, List<Map<String, String>> schedules) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/admin_backgroun.png'), // Replace with your image path
          fit: BoxFit.cover,
          opacity: 0.1, // Reduce the opacity for subtle background effect
        ),
        color: Color(0xFF0066CC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Slight rounding for top corners
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Schedule",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Table header with background color
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Time",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Class",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        schedule['date']!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        schedule['time']!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            schedule['class']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AddScheduleScreen()),
                                );
                              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "ADD SCHEDULE",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "EXIT",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
