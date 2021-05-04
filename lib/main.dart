import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/util/route.dart';
import 'package:hagglex/widgets/graphqlConfig.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GraphQLProvider(
      client: graphQLConfiguration.client,
      child: CacheProvider(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'HaggleX',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Grotesque Pro'),
    );
  }
}
