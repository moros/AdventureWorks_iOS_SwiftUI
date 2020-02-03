using AdventureWorksAPI.Database.Models;
using Microsoft.EntityFrameworkCore;

namespace AdventureWorksAPI.Database
{
    public class MotherContext : DbContext
    {
        public MotherContext(DbContextOptions<MotherContext> options) : base(options)
        {
        }

        public DbSet<HRDepartment> Departments { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
        }
    }
}
