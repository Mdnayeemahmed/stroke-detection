import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PredModel extends StatefulWidget {
  @override
  _PredModelState createState() => _PredModelState();
}

class _PredModelState extends State<PredModel> {
  var predValue = "Click predict button";
  var predictedLabel = "Predicted Label: -1";
  var predictedProbability = "Predicted Probability: -1";
  List<double> probabilities = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController hypertensionController = TextEditingController();
  TextEditingController heartDiseaseController = TextEditingController();
  TextEditingController everMarriedController = TextEditingController();
  TextEditingController workTypeController = TextEditingController();
  TextEditingController residenceTypeController = TextEditingController();
  TextEditingController avgGlucoseLevelController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController smokingStatusController = TextEditingController();

  // Age options
  final List<String> ageOptions = [
    "Child-age<16",
    "Young-[age>16 and age<26]",
    "Adult[age>26 and age<36]",
    "Mid-age[age>36 and age<62]",
    "Senior[age>62]"
  ];

  // Smoking status options
  final List<String> smokingStatusOptions = [
    "Never smoked",
    "Smokes",
    "Formerly smoked",
    "Unknown"
  ];

  // BMI options
  final List<String> bmiOptions = [
    "Underweight[BMI<18.5]",
    "Normal[BMI>18.5 and BMI<24.9]",
    "Overweight[BMI>24.9 and BMI<29.9]",
    "Obese[BMI>29.9]"
  ];

  // Avg Glucose Level options
  final List<String> glucoseLevelOptions = [
    "Low (avg_glucose_level < 70)",
    "Normal (70 <= avg_glucose_level < 100)",
    "Elevated (100 <= avg_glucose_level < 126)",
    "High (avg_glucose_level >= 126)"
  ];

  // Work Type options
  final List<String> workTypeOptions = [
    "Never worked",
    "Self-employed",
    "Private",
    "Children",
    "Govt job"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Stroke Risk Prediction",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Input values in the fields to get the prediction",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            buildInputField("Gender", genderController),
            const SizedBox(height: 12),

            buildDropDown("Age", ageController, ageOptions),
            const SizedBox(height: 12),

            buildInputField("Hypertension", hypertensionController),
            const SizedBox(height: 12),

            buildInputField("Heart Disease", heartDiseaseController),
            const SizedBox(height: 12),

            buildInputField("Ever Married", everMarriedController),
            const SizedBox(height: 12),

            buildDropDown("Work Type", workTypeController, workTypeOptions),
            const SizedBox(height: 12),

            buildInputField("Residence Type", residenceTypeController),
            const SizedBox(height: 12),

            buildDropDown("Avg Glucose Level", avgGlucoseLevelController,
                glucoseLevelOptions),
            const SizedBox(height: 12),

            buildDropDown("BMI", bmiController, bmiOptions),
            const SizedBox(height: 12),

            buildDropDown("Smoking Status", smokingStatusController,
                smokingStatusOptions),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(fontSize: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: predData,
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Predict",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 12),
            // Text(
            //   "Predicted value: $predValue",
            //   style: TextStyle(color: Colors.red, fontSize: 23),
            // ),
            // SizedBox(height: 12),
            // Text(
            //   "$predictedProbability",
            //   style: TextStyle(color: Colors.green, fontSize: 18),
            // ),
            // SizedBox(height: 12),
            // Text(
            //   "$predictedLabel",
            //   style: TextStyle(color: Colors.green, fontSize: 18),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller) {
    switch (label) {
      case "Gender":
        return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Set your desired border color here
                width: 1.0, // Set your desired border width here
              ),
              borderRadius: BorderRadius.circular(
                  10.0), // Set your desired border radius here
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildRadioButtons(
                  label, ["Male", "Female"], [1, 0], controller),
            ));
      case "Hypertension":
      case "Heart Disease":
      case "Ever Married":
      case "Work Type":
        return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Set your desired border color here
                width: 1.0, // Set your desired border width here
              ),
              borderRadius: BorderRadius.circular(
                  10.0), // Set your desired border radius here
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  buildRadioButtons(label, ["Yes", "No"], [1, 0], controller),
            ));
      case "Residence Type":
        return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Set your desired border color here
                width: 1.0, // Set your desired border width here
              ),
              borderRadius: BorderRadius.circular(
                  10.0), // Set your desired border radius here
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildRadioButtons(
                  label, ["Urban", "Rural"], [1, 0], controller),
            ));
      default:
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              controller: controller,
              keyboardType: label == "Avg Glucose Level" || label == "BMI"
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.text,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Set your desired border color here
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Set your desired border color here
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue, // Set your desired border color here
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors
                        .red, // Set your desired border color here for errors
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors
                        .red, // Set your desired border color here for focused errors
                  ),
                ),
              ),
            ));
    }
  }

  Widget buildRadioButtons(String label, List<String> options, List<int> values,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: List.generate(options.length, (index) {
            return Row(
              children: [
                Radio(
                  value: values[index].toString(),
                  groupValue: controller.text,
                  onChanged: (value) {
                    setState(() {
                      controller.text = value.toString();
                    });
                  },
                ),
                Text(options[index]),
              ],
            );
          }),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget buildDropDown(
      String label, TextEditingController controller, List<String> options) {
    int defaultIndex = options.indexOf(controller.text);
    if (defaultIndex == -1) {
      defaultIndex = 0;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Set your desired border color here
          width: 1.0, // Set your desired border width here
        ),
        borderRadius:
            BorderRadius.circular(10.0), // Set your desired border radius here
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: options.isNotEmpty ? options[defaultIndex] : null,
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  controller.text = newValue!;
                });
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Future<void> predData() async {
    final interpreter = await Interpreter.fromAsset('assets/svm_model.tflite');

    var input = [
      [
        double.parse(genderController.text),
        ageOptions.indexOf(ageController.text).toDouble(),
        double.parse(hypertensionController.text),
        double.parse(heartDiseaseController.text),
        double.parse(everMarriedController.text),
        workTypeOptions.indexOf(workTypeController.text).toDouble(),
        double.parse(residenceTypeController.text),
        glucoseLevelOptions.indexOf(avgGlucoseLevelController.text).toDouble(),
        bmiOptions.indexOf(bmiController.text).toDouble(),
        smokingStatusOptions.indexOf(smokingStatusController.text).toDouble()
      ]
    ];

    var output = List.filled(1, 0.0).reshape([1, 1]);
    interpreter.runForMultipleInputs([input], {0: output});

    double probability = output[0][0];
    int label = (probability > 0.5) ? 1 : 0;

    // Store results in a local variable
    String predValueResult = probability.toString();
    String predictedProbabilityResult = "Predicted Probability: $probability";
    String predictedLabelResult = "Predicted Label: $label";

    String riskMessage =
        (label == 0) ? 'Low risk for stroke' : 'High risk for stroke';

// Show the results in an alert box
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Stroke Risk Prediction"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text("Predicted value: $predValueResult"),
              // Text(predictedProbabilityResult),
              //Text(predictedLabelResult),
              Text(
                predictedLabelResult,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                riskMessage,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: (label == 0) ? Colors.green : Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
