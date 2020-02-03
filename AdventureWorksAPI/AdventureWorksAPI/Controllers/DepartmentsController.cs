using System.Collections.Generic;
using System.Linq;
using AdventureWorksAPI.Database;
using AdventureWorksAPI.Database.Models;
using Microsoft.AspNetCore.Mvc;
using RouteAttribute = Microsoft.AspNetCore.Mvc.RouteAttribute;

namespace AdventureWorksAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DepartmentsController : ControllerBase
    {
        private readonly MotherContext _context;

        public DepartmentsController(MotherContext context)
        {
            _context = context;
        }

        [HttpGet]
        [Route("index")]
        public ActionResult<IEnumerable<HRDepartment>> Index([FromQuery] string name = default)
        {
            if (!string.IsNullOrEmpty(name))
                return _context.Departments.Where(dept => dept.Name.Contains(name)).ToList();

            return _context.Departments.ToList();
        }
    }
}
