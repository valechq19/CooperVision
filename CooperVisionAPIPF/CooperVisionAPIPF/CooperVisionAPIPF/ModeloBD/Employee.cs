//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CooperVisionAPIPF.ModeloBD
{
    using global::System;
    using global::System.Collections.Generic;
    
    public partial class Employee
    {
        [global::System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Employee()
        {
            this.Requests = new HashSet<Request>();
        }
    
        public long ID { get; set; }
        public string Employee1 { get; set; }
        public string LastName1 { get; set; }
        public string LastName2 { get; set; }
    
        [global::System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Request> Requests { get; set; }
    }
}