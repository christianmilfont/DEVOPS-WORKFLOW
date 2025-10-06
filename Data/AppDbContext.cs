using DEVOPS5.Domain;
using Microsoft.EntityFrameworkCore;

namespace DEVOPS5.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Game> Games { get; set; }
    }

}
