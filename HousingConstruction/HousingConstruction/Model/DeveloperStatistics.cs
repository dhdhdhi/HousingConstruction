//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace HousingConstruction.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class DeveloperStatistics
    {
        public int DeveloperID { get; set; }
        public string DeveloperName { get; set; }
        public Nullable<int> TotalBuildings { get; set; }
        public Nullable<int> TotalConstructionDurationDays { get; set; }
        public Nullable<int> AverageConstructionDurationDays { get; set; }
    }
}