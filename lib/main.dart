import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironkey/app_theme.dart';
import 'package:ironkey/password_generator.dart';
import 'package:ironkey/password_type_enum.dart';
import 'package:ironkey/pin_password_generator.dart';
import 'package:ironkey/standard_password_generator.dart';

void main(){
  runApp(IronKeyApp());
}

class IronKeyApp extends StatelessWidget {
  const IronKeyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //chama o app_theme.dart que criamos
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: IronKeyScreen(),
    );
  }
}

class IronKeyScreen extends StatefulWidget {
  const IronKeyScreen({super.key});

  @override
  State<IronKeyScreen> createState() => _IronKeyScreenState();
}

class _IronKeyScreenState extends State<IronKeyScreen> {
  final TextEditingController _passwordController = TextEditingController();

  int maxCharacter =12;
  bool isEditable = false;
  PasswordTypeEnum passwordTypeSelected = PasswordTypeEnum.pin;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener((){
      setState(() {});
    });
  }

@override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void copyPassword(String password) {
  Clipboard.setData(ClipboardData(text: password));
  ScaffoldMessenger.of(
 context,
 ).showSnackBar(const SnackBar(content: Text('Senha copiada!')));
}

void generatePassword() {
  final PasswordGenerator generator;

  switch(passwordTypeSelected){
    case PasswordTypeEnum.pin:
    generator = PinPasswordGenerator();
    break;
    case PasswordTypeEnum.standard:
    generator = StandardPasswordGenerator();
  }

  setState(() {
    _passwordController.text = generator.generate(maxCharacter);
  });


 }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ColorScheme = theme.colorScheme;
    return Scaffold(
      //Column TEM QUE TER Children
    body: SafeArea(child: Column(
      children: [
        Expanded(child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            ClipOval(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset("assets/images/images.png",
                fit: BoxFit.cover,
                )
                ),
            ),
            SizedBox(height: 16,),
            Text("Sua senha segura",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 18,),
            TextField(
              controller: _passwordController,
              maxLength: maxCharacter,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: _passwordController.text.isNotEmpty
                ? IconButton(onPressed: () {
                  copyPassword(_passwordController.text);
                }, icon: Icon(Icons.copy))
                : null,
              ),
            ),
            
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Tipo de senha")
              ),
            

            Row(
              children: [ 
                Expanded(child: 
                RadioListTile(
                value: PasswordTypeEnum.pin, 
                groupValue: passwordTypeSelected, 
                title: Text("PIN"),
                onChanged: (value){
                  setState(() {
                    passwordTypeSelected = value!; 
                  });
                }
                )
                ),
                Expanded(child: RadioListTile(
                value: PasswordTypeEnum.standard, 
                groupValue: passwordTypeSelected, 
                title: Text ("Padrão"),
                onChanged: (value){
                  setState(() {
                    passwordTypeSelected =  value!;
                  });
                })),
              ],
            ),
            
            Divider(color: ColorScheme.outline),
            
            Row(
              children: [
                Icon(isEditable ? Icons.lock_open : Icons.lock),
                Text("Permite editar a senha?"),
                Switch(
                  value: isEditable, 
                  onChanged: (value){
                    setState(() {
                      isEditable = value;
                    });
                },
                )
                ],),
              ],
            )


          ],
          ),
        ),
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton(onPressed: generatePassword, child: Text("Gerar Senha")
          )
          )
      ],
    )
    ),
    );
  }
}