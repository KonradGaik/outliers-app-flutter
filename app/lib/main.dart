import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Outliers App Flutter';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: const InputWidget(),
    );
  }
}

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outliers App'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Wprowadź liczby odzielone przecinkiem(`,`)',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Fill a input field';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var input = _textController.text;
                    var inputArr = input.split(",");

                    if (inputArr.length >= 3) {
                      int oddCount = 0;
                      int evenCount = 0;
                      int oddNum = 0;
                      int evenNum = 0;

                      for (int i = 0; i < inputArr.length; i++) {
                        int num = int.parse(inputArr[i]);
                        if (num % 2 == 0) {
                          evenCount++;
                          evenNum = num;
                        } else {
                          oddCount++;
                          oddNum = num;
                        }
                      }

                      if (oddCount == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OutputWidget(oddNum),
                          ),
                        );
                      } else if (evenCount == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OutputWidget(evenNum),
                          ),
                        );
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                      content: Text('Nie znaleziono wartości odstającej'),
                      duration: Duration(seconds: 5),
  ),
  );
}
                    }
                  }
                },
                child: const Text('Wyszukaj'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutputWidget extends StatelessWidget {
  final int value;

  const OutputWidget(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outliers App Result'),
      ),
      body: Center(
        child: Text(
          'Wartość odstająca to $value',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
