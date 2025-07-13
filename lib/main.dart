import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/constants/app_constants.dart';
import 'core/di/injection_container.dart';
import 'presentation/blocs/warehouse_receipt_bloc.dart';
import 'presentation/screens/warehouse_receipt_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WarehouseReceiptBloc>(
          create:
              (context) => WarehouseReceiptBloc(
                getWarehouseReceiptList: InjectionContainer().getWarehouseReceiptList,
                getWarehouseReceiptById: InjectionContainer().getWarehouseReceiptById,
                addWarehouseReceipt: InjectionContainer().addWarehouseReceipt,
                updateWarehouseReceipt: InjectionContainer().updateWarehouseReceipt,
                deleteWarehouseReceipt: InjectionContainer().deleteWarehouseReceipt,
                searchWarehouseReceipt: InjectionContainer().searchWarehouseReceipt,
                getItemsByReceiptId: InjectionContainer().getItemsByReceiptId,
                updateItems: InjectionContainer().updateItems,
              ),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const WarehouseReceiptListScreen(),
      ),
    );
  }
}
