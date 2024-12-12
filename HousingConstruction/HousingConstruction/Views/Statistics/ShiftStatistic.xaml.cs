using HousingConstruction.Model;
using System.Data.Entity;
using System.Windows.Controls;

namespace HousingConstruction.Views.Statistics
{
    /// <summary>
    /// Логика взаимодействия для ShiftStatistic.xaml
    /// </summary>
    public partial class ShiftStatistic : Page
    {
        private HousingConstructionEntities _dbContext;

        public ShiftStatistic()
        {
            InitializeComponent();

            _dbContext = HousingConstructionEntities.GetContext();
            _dbContext.ShiftSummary.Load();

            DataGrid_Main.ItemsSource = _dbContext.ShiftSummary.Local.ToBindingList();
        }
    }
}
