import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabib/constants/constants.dart';
import 'package:tabib/providers/current_user_provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late final TextEditingController _callIDController;

  @override
  void initState() {
    super.initState();
    _initAllControllers();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeAllControllers();
  }

  /// #initializations
  void _initAllControllers() {
    _callIDController = TextEditingController();
  }

  void _disposeAllControllers() {
    _callIDController.dispose();
  }

  void _joinCallButtonOnPressed() {
    _callIDController.clear();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          final callID = _callIDController.text.trim();

          return CallRoom(callID: callID);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 140,
              child: TextFormField(
                controller: _callIDController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            /// #
            ElevatedButton(
              onPressed: _joinCallButtonOnPressed,
              child: Text('Join A Call'),
            ),
          ],
        ),
      ),
    );
  }
}

class CallRoom extends StatelessWidget {
  final String callID;

  const CallRoom({
    super.key,
    required this.callID,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<CurrentUserProvider>().userModel;
    final currentUserId = currentUser.id;
    final userName = '${currentUser.firstName} ${currentUser.lastName}';

    return ZegoUIKitPrebuiltCall(
      appID: Constants.appID,
      appSign: Constants.appSign,
      callID: callID,
      userID: currentUserId,
      userName: userName,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
