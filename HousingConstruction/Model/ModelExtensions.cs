using System.Data.Entity;
using System.Linq;

namespace HousingConstruction.Model
{
    public partial class HousingConstructionEntities : DbContext
    {
        private static HousingConstructionEntities _context;

        public static HousingConstructionEntities GetContext()
        {
            if (_context == null)
            {
                _context = new HousingConstructionEntities();
            }

            return _context;
        }

        public void RollBack()
        {
            var changedEntries = _context.ChangeTracker.Entries()
                .Where(x => x.State != EntityState.Unchanged).ToList();

            foreach (var entry in changedEntries)
            {
                switch (entry.State)
                {
                    case EntityState.Modified:
                        entry.CurrentValues.SetValues(entry.OriginalValues);
                        entry.State = EntityState.Unchanged;
                        break;
                    case EntityState.Added:
                        entry.State = EntityState.Detached;
                        break;
                    case EntityState.Deleted:
                        entry.State = EntityState.Unchanged;
                        break;
                }
            }
        }
    }
}