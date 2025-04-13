import Hummingbird

@main
struct App {
  static func main() async throws {
    let env: Environment = try await Environment.dotEnv()
    let hostname = env.get("HOSTNAME")
    let router: Router<BasicRequestContext> = Router()

    router.get("/") { request, _ -> String in
      return "Hello World"
    }

    let app: Application<RouterResponder<BasicRequestContext>> = Application(
      router: router,
      configuration: .init(address: .hostname(hostname ?? "", port: 8080))
    )

    try await app.runService()
  }
}
