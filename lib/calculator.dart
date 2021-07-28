import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({ Key? key }) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '';
  bool strOperater = false;
  String result = '0';
  int enablepoint = 0;

  void RenderFunction(String str){
    setState(() {
      equation += str;
      if(str != '+' && str != '-' && str != '*' && str != '/'){
        if(str == 'C'){
          enablepoint = 0;
          result ='0';
          equation = '';
        }
        else if(str == 'DEL'){
          if(equation.length > 3){
            equation = equation.substring(0, equation.length - 4);
          }
          else{
            equation = equation.substring(0, equation.length - 3);
          }
          if(strOperater){
            enablepoint = 1;
          }
          strOperater = false;
        }
        else if(str == '.'){
          enablepoint++;
          if(enablepoint > 1){
            equation = equation.substring(0, equation.length - 1);
          }
        }
        else if(str == '='){
          equation = '';
        }
        else{
          try{
            if(equation.length != 0){
              Parser p = Parser();
              Expression exp = p.parse(equation);
              ContextModel contextmodel = ContextModel();
              double eval = exp.evaluate(EvaluationType.REAL, contextmodel);
              result = eval.toString();
              
            }
          }catch(err){
            print(err);
          }
        }
      }
      else{
        setState(() {
          if(equation.length == 1){
            equation = equation.substring(0, equation.length - 1);
          }
          strOperater = true;
          enablepoint = 0;
        });
      }
    });
  }


  @override
  Widget ButtonClear(double Width,double Height){
    return Container(
      height: Height*0.07,
      width: Width*0.65,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: FlatButton(
        child: Center(
          child: Text(
            'CLEAR',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24
            ),
          ),
        ),
        onPressed: (){
          RenderFunction('C');
        },
      ),
    );
  }

  Widget ButtonCalculator(String str,double Width,double height,Color color){
    return Container(
      height: height* 0.07,
      width: Width*0.21,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: FlatButton(
        child: Center(
          child: Text(
            str,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24
            ),
          ),
        ),
        onPressed: (){
          if(str == 'x'){
            RenderFunction('*');
          }
          else{
            RenderFunction(str);
          }
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Width*0.06,
          vertical: Height*0.06
        ),
        child: Column(
          children: [
            Container(
              width: Width,
              height: Height*0.4,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black12
                ),
                borderRadius: BorderRadius.circular(8.0)
              ),
              padding: EdgeInsets.all(Width*0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: ListView(
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Text('$equation',style: TextStyle(fontSize: 32),)
                      ],
                    )
                  ),
                  SizedBox(height: Height*0.08,),
                  Text('$result',style: TextStyle(fontSize: 32),)
                ],
              ),
            ),
            SizedBox(
              height: Height*0.07,
            ),
            Wrap(
              spacing: Width*0.01,
              runSpacing: Width*0.01,
              children: [
                ButtonClear(Width,Height),
                ButtonCalculator('/', Width,Height, Colors.grey),
                ButtonCalculator('7', Width,Height, Colors.amber),
                ButtonCalculator('8', Width,Height, Colors.amber),
                ButtonCalculator('9', Width,Height, Colors.amber),
                ButtonCalculator('x', Width,Height, Colors.grey),
                ButtonCalculator('4', Width,Height, Colors.amber),
                ButtonCalculator('5', Width,Height, Colors.amber),
                ButtonCalculator('6', Width,Height, Colors.amber),
                ButtonCalculator('-', Width,Height, Colors.grey),
                ButtonCalculator('1', Width,Height, Colors.amber),
                ButtonCalculator('2', Width,Height, Colors.amber),
                ButtonCalculator('3', Width,Height, Colors.amber),
                ButtonCalculator('+', Width,Height, Colors.grey),
                ButtonCalculator('0', Width,Height, Colors.amber),
                ButtonCalculator('.', Width,Height, Colors.amber),
                ButtonCalculator('DEL', Width,Height, Colors.grey),
                ButtonCalculator('=', Width,Height, Colors.grey),
              ],
            )
          ],
        ),
      )
    );
  }
}
