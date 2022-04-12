import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:foodzer_customer_app/utils/helper.dart';

class PaymentUtils{


  CardType detectCardType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    cardNumberPattern.forEach(
          (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr =
          cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    return cardType;
  }
  Map<CardType, Set<List<String>>> cardNumberPattern = {
    CardType.visa: {
      ['4'],
    },
    CardType.americanExpress: {
      ['34'],
      ['37'],
    },
    CardType.discover: {
      ['6011'],
      ['622126', '622925'],
      ['644', '649'],
      ['65']
    },
    CardType.mastercard: {
      ['51', '55'],
      ['2221', '2229'],
      ['223', '229'],
      ['23', '26'],
      ['270', '271'],
      ['2720'],
    },
    CardType.dinnerClub: {
      ['54', '55'],
      ['300', '305'],
      ['3095'],
      ['36'],
      ['38', '39'],
    },
  };
  Widget? cardImage( CardType cardtype) {
    if (cardtype == CardType.visa) {
      return Image.asset(
        Helper.getAssetName('visa.png', 'virtual'),
        // "images/visa.png",
        fit: BoxFit.scaleDown,
      );
    } else if (cardtype == CardType.mastercard) {
      return Image.asset(
        Helper.getAssetName('mastercard.png', 'virtual'),
        // "images/mastercard.png",
        fit: BoxFit.scaleDown,
      );
    } else if (cardtype == CardType.discover) {
      return Image.asset(
        Helper.getAssetName('discover.png', 'virtual'),
        // "images/discover.png",
        fit: BoxFit.scaleDown,
      );
    } else if (cardtype == CardType.dinnerClub) {
      return Image.asset(
        Helper.getAssetName('diners_club.png', 'virtual'),
        // "images/diners_club.png",
        fit: BoxFit.scaleDown,
      );
    } else if (cardtype == CardType.americanExpress) {
      return Image.asset(
        Helper.getAssetName('amex.png', 'virtual'),
        // "images/amex.png",
        fit: BoxFit.scaleDown,
      );
    }
    return null;
  }

}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String? mask;
  final String? separator;

  MaskedTextInputFormatter({ this.mask,  this.separator});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask!.length) return oldValue;
        if (newValue.text.length < mask!.length && mask![newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
enum CardType {
  otherBrand,
  mastercard,
  visa,
  americanExpress,
  discover,
  dinnerClub
}