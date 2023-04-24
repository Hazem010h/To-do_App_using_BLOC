abstract class AppStates{}

class AppInitialState extends AppStates{}
class AppChangeScreenState extends AppStates{}
class AppChangeDateState extends AppStates{}
class AppChangeTimeState extends AppStates{}
class AppDatabaseCreatedState extends AppStates{}
class AppDatabaseOpenedState extends AppStates{}
class AppDatabaseGetRecordsState extends AppStates{}
class AppDatabaseInsertRecordsState extends AppStates{}
class AppDatabaseUpdateRecordsState extends AppStates{}
class AppDatabaseDeleteRecordsState extends AppStates{}