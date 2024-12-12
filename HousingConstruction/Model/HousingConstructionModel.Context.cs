﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class HousingConstructionEntities : DbContext
    {
        public HousingConstructionEntities()
            : base("name=HousingConstructionEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Construction> Construction { get; set; }
        public virtual DbSet<Developer> Developer { get; set; }
        public virtual DbSet<Housing> Housing { get; set; }
        public virtual DbSet<HousingType> HousingType { get; set; }
        public virtual DbSet<Position> Position { get; set; }
        public virtual DbSet<Shift> Shift { get; set; }
        public virtual DbSet<Status> Status { get; set; }
        public virtual DbSet<Worker> Worker { get; set; }
        public virtual DbSet<CompletedHousingInfo> CompletedHousingInfo { get; set; }
        public virtual DbSet<DeveloperStatistics> DeveloperStatistics { get; set; }
        public virtual DbSet<InProgressHousingInfo> InProgressHousingInfo { get; set; }
        public virtual DbSet<ShiftSummary> ShiftSummary { get; set; }
        public virtual DbSet<SoldHousingInfo> SoldHousingInfo { get; set; }
        public virtual DbSet<WorkerStatictics> WorkerStatictics { get; set; }
    
        [DbFunction("HousingConstructionEntities", "FindMostExpensiveHousing")]
        public virtual IQueryable<FindMostExpensiveHousing_Result> FindMostExpensiveHousing()
        {
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<FindMostExpensiveHousing_Result>("[HousingConstructionEntities].[FindMostExpensiveHousing]()");
        }
    
        public virtual int AddConstruction(Nullable<int> housingID, Nullable<System.DateTime> startDate, Nullable<System.DateTime> endDate, Nullable<int> developerID)
        {
            var housingIDParameter = housingID.HasValue ?
                new ObjectParameter("HousingID", housingID) :
                new ObjectParameter("HousingID", typeof(int));
    
            var startDateParameter = startDate.HasValue ?
                new ObjectParameter("StartDate", startDate) :
                new ObjectParameter("StartDate", typeof(System.DateTime));
    
            var endDateParameter = endDate.HasValue ?
                new ObjectParameter("EndDate", endDate) :
                new ObjectParameter("EndDate", typeof(System.DateTime));
    
            var developerIDParameter = developerID.HasValue ?
                new ObjectParameter("DeveloperID", developerID) :
                new ObjectParameter("DeveloperID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AddConstruction", housingIDParameter, startDateParameter, endDateParameter, developerIDParameter);
        }
    
        public virtual int AddDeveloper(string name, string phone)
        {
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var phoneParameter = phone != null ?
                new ObjectParameter("Phone", phone) :
                new ObjectParameter("Phone", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AddDeveloper", nameParameter, phoneParameter);
        }
    
        public virtual int AddHousing(Nullable<decimal> area, Nullable<int> roomCount, string address, Nullable<decimal> price, Nullable<int> developerID, Nullable<int> housingTypeID, Nullable<int> statusID)
        {
            var areaParameter = area.HasValue ?
                new ObjectParameter("Area", area) :
                new ObjectParameter("Area", typeof(decimal));
    
            var roomCountParameter = roomCount.HasValue ?
                new ObjectParameter("RoomCount", roomCount) :
                new ObjectParameter("RoomCount", typeof(int));
    
            var addressParameter = address != null ?
                new ObjectParameter("Address", address) :
                new ObjectParameter("Address", typeof(string));
    
            var priceParameter = price.HasValue ?
                new ObjectParameter("Price", price) :
                new ObjectParameter("Price", typeof(decimal));
    
            var developerIDParameter = developerID.HasValue ?
                new ObjectParameter("DeveloperID", developerID) :
                new ObjectParameter("DeveloperID", typeof(int));
    
            var housingTypeIDParameter = housingTypeID.HasValue ?
                new ObjectParameter("HousingTypeID", housingTypeID) :
                new ObjectParameter("HousingTypeID", typeof(int));
    
            var statusIDParameter = statusID.HasValue ?
                new ObjectParameter("StatusID", statusID) :
                new ObjectParameter("StatusID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AddHousing", areaParameter, roomCountParameter, addressParameter, priceParameter, developerIDParameter, housingTypeIDParameter, statusIDParameter);
        }
    
        public virtual int AddShift(Nullable<int> workerID, Nullable<int> constructionID, Nullable<System.DateTime> shiftDate)
        {
            var workerIDParameter = workerID.HasValue ?
                new ObjectParameter("WorkerID", workerID) :
                new ObjectParameter("WorkerID", typeof(int));
    
            var constructionIDParameter = constructionID.HasValue ?
                new ObjectParameter("ConstructionID", constructionID) :
                new ObjectParameter("ConstructionID", typeof(int));
    
            var shiftDateParameter = shiftDate.HasValue ?
                new ObjectParameter("ShiftDate", shiftDate) :
                new ObjectParameter("ShiftDate", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AddShift", workerIDParameter, constructionIDParameter, shiftDateParameter);
        }
    
        public virtual int AddWorker(string fullName, Nullable<int> positionID, Nullable<decimal> paymentPerShift)
        {
            var fullNameParameter = fullName != null ?
                new ObjectParameter("FullName", fullName) :
                new ObjectParameter("FullName", typeof(string));
    
            var positionIDParameter = positionID.HasValue ?
                new ObjectParameter("PositionID", positionID) :
                new ObjectParameter("PositionID", typeof(int));
    
            var paymentPerShiftParameter = paymentPerShift.HasValue ?
                new ObjectParameter("PaymentPerShift", paymentPerShift) :
                new ObjectParameter("PaymentPerShift", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AddWorker", fullNameParameter, positionIDParameter, paymentPerShiftParameter);
        }
    
        public virtual int DeleteConstruction(Nullable<int> constructionID)
        {
            var constructionIDParameter = constructionID.HasValue ?
                new ObjectParameter("ConstructionID", constructionID) :
                new ObjectParameter("ConstructionID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeleteConstruction", constructionIDParameter);
        }
    
        public virtual int DeleteDeveloper(Nullable<int> developerID)
        {
            var developerIDParameter = developerID.HasValue ?
                new ObjectParameter("DeveloperID", developerID) :
                new ObjectParameter("DeveloperID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeleteDeveloper", developerIDParameter);
        }
    
        public virtual int DeleteHousing(Nullable<int> housingID)
        {
            var housingIDParameter = housingID.HasValue ?
                new ObjectParameter("HousingID", housingID) :
                new ObjectParameter("HousingID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeleteHousing", housingIDParameter);
        }
    
        public virtual int DeleteShift(Nullable<int> shiftID)
        {
            var shiftIDParameter = shiftID.HasValue ?
                new ObjectParameter("ShiftID", shiftID) :
                new ObjectParameter("ShiftID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeleteShift", shiftIDParameter);
        }
    
        public virtual int DeleteWorker(Nullable<int> workerID)
        {
            var workerIDParameter = workerID.HasValue ?
                new ObjectParameter("WorkerID", workerID) :
                new ObjectParameter("WorkerID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeleteWorker", workerIDParameter);
        }
    
        public virtual int UpdateConstruction(Nullable<int> constructionID, Nullable<int> housingID, Nullable<System.DateTime> startDate, Nullable<System.DateTime> endDate, Nullable<int> developerID)
        {
            var constructionIDParameter = constructionID.HasValue ?
                new ObjectParameter("ConstructionID", constructionID) :
                new ObjectParameter("ConstructionID", typeof(int));
    
            var housingIDParameter = housingID.HasValue ?
                new ObjectParameter("HousingID", housingID) :
                new ObjectParameter("HousingID", typeof(int));
    
            var startDateParameter = startDate.HasValue ?
                new ObjectParameter("StartDate", startDate) :
                new ObjectParameter("StartDate", typeof(System.DateTime));
    
            var endDateParameter = endDate.HasValue ?
                new ObjectParameter("EndDate", endDate) :
                new ObjectParameter("EndDate", typeof(System.DateTime));
    
            var developerIDParameter = developerID.HasValue ?
                new ObjectParameter("DeveloperID", developerID) :
                new ObjectParameter("DeveloperID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("UpdateConstruction", constructionIDParameter, housingIDParameter, startDateParameter, endDateParameter, developerIDParameter);
        }
    
        public virtual int UpdateDeveloper(Nullable<int> developerID, string name, string phone)
        {
            var developerIDParameter = developerID.HasValue ?
                new ObjectParameter("DeveloperID", developerID) :
                new ObjectParameter("DeveloperID", typeof(int));
    
            var nameParameter = name != null ?
                new ObjectParameter("Name", name) :
                new ObjectParameter("Name", typeof(string));
    
            var phoneParameter = phone != null ?
                new ObjectParameter("Phone", phone) :
                new ObjectParameter("Phone", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("UpdateDeveloper", developerIDParameter, nameParameter, phoneParameter);
        }
    
        public virtual int UpdateHousing(Nullable<int> housingID, Nullable<decimal> area, Nullable<int> roomCount, string address, Nullable<decimal> price, Nullable<int> developerID, Nullable<int> housingTypeID, Nullable<int> statusID)
        {
            var housingIDParameter = housingID.HasValue ?
                new ObjectParameter("HousingID", housingID) :
                new ObjectParameter("HousingID", typeof(int));
    
            var areaParameter = area.HasValue ?
                new ObjectParameter("Area", area) :
                new ObjectParameter("Area", typeof(decimal));
    
            var roomCountParameter = roomCount.HasValue ?
                new ObjectParameter("RoomCount", roomCount) :
                new ObjectParameter("RoomCount", typeof(int));
    
            var addressParameter = address != null ?
                new ObjectParameter("Address", address) :
                new ObjectParameter("Address", typeof(string));
    
            var priceParameter = price.HasValue ?
                new ObjectParameter("Price", price) :
                new ObjectParameter("Price", typeof(decimal));
    
            var developerIDParameter = developerID.HasValue ?
                new ObjectParameter("DeveloperID", developerID) :
                new ObjectParameter("DeveloperID", typeof(int));
    
            var housingTypeIDParameter = housingTypeID.HasValue ?
                new ObjectParameter("HousingTypeID", housingTypeID) :
                new ObjectParameter("HousingTypeID", typeof(int));
    
            var statusIDParameter = statusID.HasValue ?
                new ObjectParameter("StatusID", statusID) :
                new ObjectParameter("StatusID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("UpdateHousing", housingIDParameter, areaParameter, roomCountParameter, addressParameter, priceParameter, developerIDParameter, housingTypeIDParameter, statusIDParameter);
        }
    
        public virtual int UpdateShift(Nullable<int> shiftID, Nullable<int> workerID, Nullable<int> constructionID, Nullable<System.DateTime> shiftDate)
        {
            var shiftIDParameter = shiftID.HasValue ?
                new ObjectParameter("ShiftID", shiftID) :
                new ObjectParameter("ShiftID", typeof(int));
    
            var workerIDParameter = workerID.HasValue ?
                new ObjectParameter("WorkerID", workerID) :
                new ObjectParameter("WorkerID", typeof(int));
    
            var constructionIDParameter = constructionID.HasValue ?
                new ObjectParameter("ConstructionID", constructionID) :
                new ObjectParameter("ConstructionID", typeof(int));
    
            var shiftDateParameter = shiftDate.HasValue ?
                new ObjectParameter("ShiftDate", shiftDate) :
                new ObjectParameter("ShiftDate", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("UpdateShift", shiftIDParameter, workerIDParameter, constructionIDParameter, shiftDateParameter);
        }
    
        public virtual int UpdateWorker(Nullable<int> workerID, string fullName, Nullable<int> positionID, Nullable<decimal> paymentPerShift)
        {
            var workerIDParameter = workerID.HasValue ?
                new ObjectParameter("WorkerID", workerID) :
                new ObjectParameter("WorkerID", typeof(int));
    
            var fullNameParameter = fullName != null ?
                new ObjectParameter("FullName", fullName) :
                new ObjectParameter("FullName", typeof(string));
    
            var positionIDParameter = positionID.HasValue ?
                new ObjectParameter("PositionID", positionID) :
                new ObjectParameter("PositionID", typeof(int));
    
            var paymentPerShiftParameter = paymentPerShift.HasValue ?
                new ObjectParameter("PaymentPerShift", paymentPerShift) :
                new ObjectParameter("PaymentPerShift", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("UpdateWorker", workerIDParameter, fullNameParameter, positionIDParameter, paymentPerShiftParameter);
        }
    }
}