using DEVOPS5.Data;
using DEVOPS5.Interfaces;
using DEVOPS5.Repositories;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Connection string do appsettings.json ou variável de ambiente
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

// Configura o EF Core com SQL Server
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddScoped<IGameRepository, GameRepository>();
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Forçar Swagger em qualquer ambiente
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "DEVOPS5 API V1");
});

// Redirecionar raiz para Swagger
app.MapGet("/", context =>
{
    context.Response.Redirect("/swagger/index.html");
    return Task.CompletedTask;
});

app.UseHttpsRedirection();
app.UseAuthorization();

app.MapControllers();

app.Run();
