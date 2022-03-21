library social_media_recorder;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:social_media_recorder/provider/sound_record_notifier.dart';
import 'package:social_media_recorder/widgets/show_counter.dart';

// ignore: must_be_immutable
class SoundRecorderWhenLockedDesign extends StatelessWidget {
  final SoundRecordNotifier soundRecordNotifier;
  final String? cancelText;
  final Function sendRequestFunction;
  final Widget? recordIconWhenLockedRecord;
  final TextStyle? cancelTextStyle;
  final TextStyle? counterTextStyle;
  final Color recordIconWhenLockBackGroundColor;
  final Color? counterBackGroundColor;
  // ignore: sort_constructors_first
  const SoundRecorderWhenLockedDesign({
    Key? key,
    required this.soundRecordNotifier,
    required this.cancelText,
    required this.sendRequestFunction,
    required this.recordIconWhenLockedRecord,
    required this.cancelTextStyle,
    required this.counterTextStyle,
    required this.recordIconWhenLockBackGroundColor,
    required this.counterBackGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          soundRecordNotifier.isShow = false;
          soundRecordNotifier.resetEdgePadding();
        },
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                soundRecordNotifier.isShow = false;
                if (soundRecordNotifier.second > 1 || soundRecordNotifier.minute > 0) {
                  String path = soundRecordNotifier.mPath;
                  await Future.delayed(Duration(milliseconds: 500));
                  sendRequestFunction(File.fromUri(Uri(path: path)));
                }
                soundRecordNotifier.resetEdgePadding();
              },
              child: Container(

                child: Transform.scale(
                  scale: 1.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(600),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      width: 50,
                      height: 50,
                      child: Container(
                        color: recordIconWhenLockBackGroundColor,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: recordIconWhenLockedRecord ??
                              Icon(
                                Icons.send,
                                textDirection: TextDirection.ltr,
                                size: 28,
                                color: (soundRecordNotifier.buttonPressed)
                                    ? Colors.grey.shade200
                                    : Colors.black,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(

              child: InkWell(
                  onTap: () {
                    soundRecordNotifier.isShow = false;
                    soundRecordNotifier.resetEdgePadding();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cancelText ?? "",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: cancelTextStyle ??
                          TextStyle(
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                    ),
                  )),
            ),
            ShowCounter(
              soundRecorderState: soundRecordNotifier,
              counterTextStyle: counterTextStyle,
              counterBackGroundColor: counterBackGroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
