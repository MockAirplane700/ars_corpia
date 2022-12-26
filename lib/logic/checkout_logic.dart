import 'package:ars_corpia/constants/functions.dart';
import 'package:ars_corpia/logic/cart_items_bloc.dart';

class CheckoutLogic {
  static void sendUrlToLocalBrowser() {
    // Edit the GET URL for our products.
    ///=========================================================================
    ///
    /// ASIN.#inCart=itemStockNumber&Quantity.#inCart=1&
    //
    // For example to add lucina as the first item in your cart and Robin as the second.
    // http://www.amazon.com/gp/aws/cart/add.html?&ASIN.1=B00V86BJV4&Quantity.1=1&ASIN.2=B00V86BRHU&Quantity.2=1
    //
    // Amazon Item Numbers:
    //
    // Lucina: B00V86BJV4
    //
    // Robin: B00V86BRHU
    ///=========================================================================

    // use bloc to get a list of the cart items
    List products = bloc.allItems['cart items'];

    // go through them one by one and add what is relevant to the url
    String url = 'https://www.amazon.ca/gp/aws/cart/add.html?';
    int count = 1;
    for(var element in products){
      String asin = element['asin'];
      String quantity = element['quantity'].toString();
      url = '${url}ASIN.${count.toString()}=$asin&Quantity.1=${quantity.toString()}&';
      count++;
    }//end

    launchWebSiteUrl(url);
  }//end method
}