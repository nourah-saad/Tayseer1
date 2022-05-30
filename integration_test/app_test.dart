// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tayseer2/authintication/login_screen.dart';
import 'package:tayseer2/contact_with_Najem/contact_with_najem.dart';
import 'package:tayseer2/dummy_view/dummy_Screen.dart';
import 'package:tayseer2/guidlines.dart';
import 'package:tayseer2/main.dart' as app;
import 'package:tayseer2/mainScreen/main_screen.dart';
import 'package:tayseer2/report_an_accident/add_new_car.dart';
import 'package:tayseer2/report_an_accident/confirmation/confirmation_loading_page.dart';
import 'package:tayseer2/report_an_accident/confirmation/confirmation_page.dart';
import 'package:tayseer2/report_an_accident/confirmation/confirmed.dart';
import 'package:tayseer2/report_an_accident/mapScreen/map_screen.dart';
import 'package:tayseer2/report_an_accident/select_involved_car.dart';
import 'package:tayseer2/report_an_accident/select_your_car.dart';
import 'package:tayseer2/tapPages/home.dart';
import 'package:tayseer2/view_accidents/Search_Bar.dart';
import 'package:tayseer2/view_accidents/view_accident_report.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("integration test", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 4));

// sign in screen
    final idField = find.byKey(Key('IDField'));
    final passwordField = find.byKey(Key('passField'));
    final signInButton = find.byKey(Key('signInButton'));

// main screen
    final profileButton = find.byKey(Key('profileButton'));

//profile screen
    final displayedName = find.byKey(Key('profileName'));
    final editProfileButton = find.byKey(Key('editProfileButton'));
    final editEmailField = find.byKey(Key('editEmailField'));
    final confirmEmailButton = find.byKey(Key('confirmEmailChanges'));
    final disConfirmEmailButton = find.byKey(Key('disConfirmEmailChanges'));

// log out elements
    final logoutButton = find.byKey(Key('logOutButton'));
    final confirmLogout = find.byKey(Key('confirmlogout'));
    final disConfirmLogout = find.byKey(Key('DisConfirmlogout'));

// enter login information

    await tester.enterText(idField,
        '1198878865'); // 1198878865 rawan 1324656662 faisal 1427458655 ahmad
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.enterText(passwordField, 'Rr123456');
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(signInButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byWidgetPredicate((widget) => widget is MainScreen),
        findsOneWidget);

      //contact najm
    await tester.tap(find.byKey(Key('contact')));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byWidgetPredicate((widget) => widget is ContactWithNajem),
        findsOneWidget);

    await tester.tap(find.byKey(Key('callNajm')));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    app.main();

    await tester.tap(find.byKey(Key('contact')));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byWidgetPredicate((widget) => widget is ContactWithNajem),
        findsOneWidget);
    await tester.tap(find.byKey(Key('emailNajm')));

    app.main();

    // profile

    //confirm email changes
    await tester.tap(profileButton);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(editProfileButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.enterText(editEmailField, 'rawan@gmail.com');
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(confirmEmailButton);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    // ensure new email is displayed
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'rawan@gmail.com'),
        findsOneWidget);

    // cnacel email changes
    await tester.tap(editProfileButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.enterText(editEmailField, 'faisalKhalid@gmail.com');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(disConfirmEmailButton);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    // ensure old email is displayed and not changed
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'rawan@gmail.com'),
        findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 2));

    // log out

    //cancel logout
    await tester.tap(logoutButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(disConfirmLogout);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    //ensure page is not changed
    expect(find.byWidgetPredicate((widget) => widget is Dummy_Screen),
        findsOneWidget);

    await tester.tap(find.byKey(Key('homeButton')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    //view report details merge3
    await tester.tap(find.byKey(Key('viewAccidents')));
    await tester.pumpAndSettle(const Duration(seconds: 15));
    await tester.tap(find.byKey(Key('viewReport 0')));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byWidgetPredicate((widget) => widget is AccidentReportWidget),
        findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    //search
    await tester.tap(find.byKey(Key('searchBar')));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byWidgetPredicate((widget) => widget is Search_bar),
        findsOneWidget);

    await tester.enterText(
        find.byWidgetPredicate(
            (widget) => widget is GooglePlaceAutoCompleteTextField),
        'King Fahad Road');
    await tester.pumpAndSettle(const Duration(seconds: 10));
    
    await tester.tap(find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'King Fahd Road, Riyadh Saudi Arabia')); 

    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.data!
                .contains('King Fahd Road, Riyadh Saudi Arabia'.toUpperCase())),
        findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.pageBack();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // choose driver's car tested
    await tester.tap(find.byKey(Key('homeButton')));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(Key('reportButton')));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byWidgetPredicate((widget) => widget is MapScreen),
        findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.tap(find.byKey(Key('nextButton')));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byWidgetPredicate((widget) => widget is select_your_carWidget),
        findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.tap(find.byKey(Key('selectYourCarButton 0')));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is SelectCarInvolvedCarsPageWidget),
        findsOneWidget);

    // choose involved car tested
    await tester.tap(find.byKey(Key('selectInvolved')));

    for (int i = 0; i < 6; i++) {
      await tester.pump(Duration(seconds: 1));
    }
    
    expect(
        find.byWidgetPredicate(
            (widget) => widget is ConfirmationLoadingPageWidget),
        findsOneWidget);

    await tester.tap(find.byKey(Key('backLoading')));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // enter plate number manually
    await tester.tap(find.byKey(Key('reportButton')));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byWidgetPredicate((widget) => widget is MapScreen),
        findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.tap(find.byKey(Key('nextButton')));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byWidgetPredicate((widget) => widget is select_your_carWidget),
        findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.tap(find.byKey(Key('selectYourCarButton 0')));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is SelectCarInvolvedCarsPageWidget),
        findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 20));

    await tester.tap(find.byKey(Key('enterPlate')));
    await tester.pumpAndSettle(const Duration(seconds: 10));
    expect(find.byWidgetPredicate((widget) => widget is AddCarManuallyWidget),
        findsOneWidget);

    await tester.enterText(find.byKey(Key('enterManuallyField')), 'A S E 4170');
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.byKey(Key('enterManuallyButton')));
    await tester.pumpAndSettle(const Duration(seconds: 10));
    await tester.tap(find.byKey(Key('OkButton')));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is ConfirmationLoadingPageWidget),
        findsOneWidget);

    await tester.tap(find.byKey(Key('backLoading')));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    

    //view guidelines
await tester.tap(find.byKey(Key('guidelines')));
await tester.pumpAndSettle(const Duration(seconds: 5));
expect(find.byWidgetPredicate((widget) => widget is guidelines),
        findsOneWidget);

   await tester.pumpAndSettle(const Duration(seconds: 30)); 


//confirm involvment 
await tester.tap(find.byKey(Key('confirmInvolvmentButton')));
await tester.pumpAndSettle(const Duration(seconds: 5));
expect(find.byWidgetPredicate((widget) => widget is ConfirmedPage),
        findsOneWidget);

await tester.pumpAndSettle(const Duration(seconds: 30)); 

//disconfirm involvment 
await tester.tap(find.byKey(Key('disConfirmInvolvmentButton')));
await tester.pumpAndSettle(const Duration(seconds: 5));
expect(find.byWidgetPredicate((widget) => widget is ConfirmedPage),
        findsOneWidget);*/
        

//confirm logout
    await tester.tap(logoutButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(confirmLogout);
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byWidgetPredicate((widget) => widget is LoginScreen),
        findsOneWidget);


  });
}
