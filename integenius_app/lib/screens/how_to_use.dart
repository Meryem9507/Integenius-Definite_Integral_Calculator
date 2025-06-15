import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(11, 15, 26, 1.0),
          leading: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        //HEADER
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight * 1 / 8,
                color: const Color.fromRGBO(11, 15, 26, 1.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "How to Use the App?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // MAIN CONTENT
              Container(
                width: deviceWidth,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "This app allows you to calculate definite integrals of mathematical functions. Below is a step-by-step guide on how to use the app:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Academic',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              //User Guide
              Container(
                width: deviceWidth,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "User Guide",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Academic',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Follow the instructions below to enter your function correctly.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Academic',
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "1.**INPUT FUNCTION**: Enter a valid mathematical function to calculate its definite integral.\n"
                      "- For exponentiation use `**`. Example: `x**2`.\n"
                      "\n"

                      "2.**EULER'S NUMBER (e)**: Use `E` for Euler's number. Example: `E**(2*x)`.\n"
                      "- Avoid using lowercase `e` as it will be interpreted differently.\n"
                      "\n"

                      "3.**LOGARITHMS**: Use `ln(x)` for natural logarithms.\n"
                      "- If you need a logarithm with a different base, use `log2(x)` for base 2, `log10(x)` for base 10.\n"
                      "- Example inputs:\n"
                      "  - Natural log: `ln(x)`\n"
                      "  - Base 2 log: `log2(x)`\n"
                       "  - Base 10 log: `log10(x)`\n"
                      "\n"

                      "4.**TRIGONOMETRIC FUNCTIONS**: Use standard trigonometric functions such as `sin(x)`, `cos(x)`, `tan(x)`.\n"
                      "- Example: `sin(x)` for the sine of x, `cos(x)` for cosine of x.\n"
                      "\n"

                      "5.**INVERSE TRIGONOMETRIC FUNCTIONS**: Use the internal function names such as `atan(x)`, `asin(x)`, `acos(x)`.\n"
                      "- Example: `atan(x)` for the inverse tangent of x.\n"
                      "- Avoid using `arctan(x)`, `arcsin(x)`, or `arccos(x)` as they are not recognized.\n"
                      "\n"

                      "6.**PARANTHESES**: Use parentheses `()` to clarify the order of operations.\n"
                      " - Example: `(x + 1)**2` or `sin(x) * cos(x)`.\n"
                      "\n"

                      "7.**MULTIPLICATION AND DIVISION**: To specify multiplication, use `*` or simply place variables next to each other. For division, use `/` and additionally you can also use parentheses to clarify the order of operations when dividing.\n"
                      "- Example: `x * sin(x)` or `xsin(x)`.\n"
                      "- Example: `x / sin(x)` or `x/sin(x)`.\n"
                      "- Example: `(x + 1) / (sin(x) + cos(x))`.\n"
                      "\n"

                      "8.**EXPONENT RULES**: When using exponentiation, be careful with how you enter the expression.\n"
                      "- Always use `**` to represent exponentiation, not `^`.\n"
                      "- To raise a number or constant to a compound expression (like `2*x`), use parentheses.\n"
                      "- ✅ Correct: `E**(2*x)` → means e^(2x)\n"
                      " - ❌ Incorrect: `E**2*x` → means (e^2) * x, not e^(2x)\n"
                      "- Summary:\n"
                      "- Use `E**(expression)` for exponential expressions involving variables.\n"
                      "- Never use `^` as it performs bitwise XOR, not exponentiation in Python/SymPy.\n"
                      "\n",

                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Academic',
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Image.asset(
                      "lib/assets/images/integral.jpg",
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Example input for the above integral: (x+2)*E**(3*x)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Academic',
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              //Add space for scrolling
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
