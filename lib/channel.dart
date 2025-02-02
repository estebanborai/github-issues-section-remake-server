import 'package:github_issues_section_remake_server/config/environment.dart';
import 'package:github_issues_section_remake_server/controller/todo_controller.dart';
import 'github_issues_section_remake_server.dart';
/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class GithubIssuesSectionRemakeServerChannel extends ApplicationChannel {
	ManagedContext context;	
	/// Initialize services in this method.
	///
	/// Implement this method to initialize services, read values from [options]
	/// and any other initialization required before constructing [entryPoint].
	///
	/// This method is invoked prior to [entryPoint] being accessed.
	@override
	Future prepare() async {
		logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

		final Map<String, String> appEnvVars = getAppEnvVars();
	
		final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
		final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
			"admin_user", "root", appEnvVars['DB_HOST_NAME'], 5432, "github_issues_remake");

		context = ManagedContext(dataModel, persistentStore);
	}

	/// Construct the request channel.
	///
	/// Return an instance of some [Controller] that will be the initial receiver
	/// of all [Request]s.
	///
	/// This method is invoked after [prepare].
	@override
	Controller get entryPoint {
		final router = Router();
		const String apiBase = 'api/v1';

		// Prefer to use `link` instead of `linkFunction`.
		// See: https://aqueduct.io/docs/http/request_controller/
		router
			.route("/$apiBase/todos/[:id]")
			.link(() => TodoController(context));

		return router;
	}
}
