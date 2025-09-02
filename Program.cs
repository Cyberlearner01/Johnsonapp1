var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hi everyone, this is Johnson's app!");

app.Run();
