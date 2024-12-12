using HousingConstruction.Model;
using System.Data.Entity;
using System.Windows.Controls;

namespace HousingConstruction.Views.Statistics
{
    /// <summary>
    /// Логика взаимодействия для DeveloperStatistic.xaml
    /// </summary>
    public partial class DeveloperStatistic : Page
    {
        private HousingConstructionEntities _dbContext;

        public DeveloperStatistic()
        {
            InitializeComponent();

            _dbContext = HousingConstructionEntities.GetContext();
            _dbContext.DeveloperStatistics.Load();

            DataGrid_Main.ItemsSource = _dbContext.DeveloperStatistics.Local.ToBindingList();
        }
    }
}
