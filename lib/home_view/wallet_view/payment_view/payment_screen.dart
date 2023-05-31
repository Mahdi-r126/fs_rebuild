import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freesms/home_view/wallet_view/widget/payment_alert.dart';
import 'package:toast/toast.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../apis/apis.dart';

bool _loading = false;

class PaymentScreen extends StatefulWidget {
  final int wallet;
  const PaymentScreen(this.wallet, {Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _creditCardController = TextEditingController();
  static const amountLimit = 10000;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0039C8),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            AppLocalizations.of(context).cashOut,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        body: ClipPath(
          // clipper :ArcClipper(),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.maxFinite,
            height: double.maxFinite,
            // height: 300,
            // color:  const Color(0xFF3f51b5),
            // alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF0039C8),
                    Color(0xFF002861),
                  ],
                  //  begin: const FractionalOffset(-1.0, 0.0),
                  // end: const FractionalOffset(1.0, 0.0),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),

            child: Container(
              width: double.maxFinite,
              // height: 500,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                  color: const Color(0xFF0B44D1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 0,
                    // color: Color(0xFF25CEA0)
                  )),

              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Text(
                          AppLocalizations.of(context).walletBalance,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Text(
                          widget.wallet.toString() + " ",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 32),
                    child: Text.rich(TextSpan(
                        text: AppLocalizations.of(context).cardNumber,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        children: const <InlineSpan>[
                          TextSpan(
                            text: ' * ',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.red),
                          )
                        ])),
                  ),

                  ///Card Number
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _creditCardController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter(),
                        ],
                        decoration: const InputDecoration(
                          hintText: "Card number",
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        cursorColor: Colors.blue,
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 32),
                    child: Text.rich(TextSpan(
                        text: AppLocalizations.of(context).withdrawalAmount,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        children: <InlineSpan>[
                          const TextSpan(
                            text: ' * ',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.red),
                          )
                        ])),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        cursorColor: Colors.blue,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 32.0, bottom: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _loading?null: () async {
                          if (!(isValidCardNumber(
                              _creditCardController.text))) {
                            showDialog(context: context,
                              builder: (context) => PaymenetAlert(message: "Card number is invalid",),);
                          } else if (int.parse(_amountController.text) <
                              amountLimit) {
                            showDialog(context: context,
                              builder: (context) => PaymenetAlert(message: 'payment amount must be more than $amountLimit',),);
                          } else if (int.parse(_amountController.text) >
                              widget.wallet) {
                            showDialog(context: context,
                              builder: (context) => PaymenetAlert(message: 'payment amount is more than your wallet',),);
                          } else {
                            setState(() {
                              _loading = true;
                            });
                            print("|||+true");
                            Apis api = Apis();
                            String amount = _amountController.text;
                            String cardNumber =
                                _creditCardController.text.replaceAll(" ", "");
                            bool response =
                                await api.reportCashOut(amount, cardNumber);
                            setState(() {
                              _loading = false;
                            });
                            if (response == true) {
                              await showDialog(context: context,
                                  builder: (context) => PaymenetAlert(message: "cash out successfully reported",));
                              Navigator.pop(context);
                            } else {
                              showDialog(context: context,
                                builder: (context) => PaymenetAlert(message: "cash out report failed",),);
                            }
                          }
                        },
                        icon: _loading
                            ? const SizedBox.square(
                                dimension: 20,
                                child: CircularProgressIndicator(),
                              )
                            : const Icon(
                                Icons.save,
                                color: Color(0xFF0B44D1),
                              ), //icon data for elevated button
                        label: _loading?const Text(""):Text(
                            " " + AppLocalizations.of(context).cashOut + " ",
                            style: const TextStyle(
                              color: Color(0xFF0B44D1),
                            )),

                        //label text
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.blue.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ), // HexColor("#F46D9D")
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  bool isValidCardNumber(String cardNumber) {
    cardNumber = cardNumber.replaceAll(" ", "");
    if (cardNumber.isEmpty || cardNumber.length != 16) {
      return false;
    }

    int cardTotal = 0;
    for (int i = 0; i < 16; i += 1) {
      int c = int.parse(cardNumber[i]);

      if (i % 2 == 0) {
        cardTotal += ((c * 2 > 9) ? (c * 2) - 9 : (c * 2));
      } else {
        cardTotal += c;
      }
    }
    return (cardTotal % 10 == 0);
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
