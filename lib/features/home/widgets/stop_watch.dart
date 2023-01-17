import 'dart:async';
import 'package:flutter/material.dart';



class StopwatchPage extends StatefulWidget {
   
  const StopwatchPage({super.key});

  @override
  StopwatchPageState createState() => StopwatchPageState();
}

class StopwatchPageState extends State<StopwatchPage> {
  bool userIsInqueue = false;
  Stopwatch stopwatch = Stopwatch();
  Duration duration = const Duration(seconds: 0);
  late Timer timer;
  bool isRunning = false;

  bool get isUserInQueue {
    return userIsInqueue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(width: 6),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    userIsInqueue = true;
                  });
                  if (!isRunning) {
                    setState(() {
                      isRunning = true;
                      
                    });

                    stopwatch.start();

                    timer = Timer.periodic(const Duration(milliseconds: 100),
                        (timer) {
                      setState(() {
                        // Update the duration
                        duration = stopwatch.elapsed;
                      });
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'In Que',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            const SizedBox(width: 6),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    userIsInqueue = false;
                  });
                  // Stop the stopwatch if it's running
                  if (isRunning) {
                    setState(() {
                      isRunning = false;
                      
                    });

                    stopwatch.stop();

                    // Cancel the timer
                    timer.cancel();
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Fueled',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(width: 6),
            ElevatedButton(
                onPressed: () {
                  // Reset the stopwatch
                  setState(() {
                    isRunning = false;
                    duration = const Duration(seconds: 0);
                    stopwatch.reset();
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(isUserInQueue.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}
