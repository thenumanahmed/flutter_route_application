import 'package:flutter/material.dart';

void customSnackbar(BuildContext context, bool isSuccess, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${isSuccess ? 'Success' : 'Error'} : $message !')));
