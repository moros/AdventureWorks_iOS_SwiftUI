using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Newtonsoft.Json;

namespace AdventureWorksAPI.Database.Models
{
    [Table("Department", Schema = "HumanResources")]
    public class HRDepartment
    {
        [JsonProperty("department_id")]
        [Key]
        public short DepartmentID { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("group_name")]
        public string GroupName { get; set; }

        [JsonProperty("modified_date")]
        public DateTime ModifiedDate { get; set; }
    }
}
