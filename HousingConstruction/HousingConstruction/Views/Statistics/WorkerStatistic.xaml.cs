using HousingConstruction.Model;
using System.Data.Entity;
using System.Windows.Controls;

namespace HousingConstruction.Views.Statistics
{
    /// <summary>
    /// Логика взаимодействия для WorkerStatistic.xaml
    /// </summary>
    public partial class WorkerStatistic : Page
    {
        private HousingConstructionEntities _dbContext;

        public WorkerStatistic()
        {
            InitializeComponent();

            _dbContext = HousingConstructionEntities.GetContext();
            _dbContext.WorkerStatictics.Load();

            DataGrid_Main.ItemsSource = _dbContext.WorkerStatictics.Local.ToBindingList();
        }
    }
}
