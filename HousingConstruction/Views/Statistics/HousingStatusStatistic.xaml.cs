using HousingConstruction.Model;
using System.Data.Entity;
using System.Windows;
using System.Windows.Controls;

namespace HousingConstruction.Views.Statistics
{
    /// <summary>
    /// Логика взаимодействия для HousingStatusStatistic.xaml
    /// </summary>
    public partial class HousingStatusStatistic : Page
    {
        private HousingConstructionEntities _dbContext;

        public HousingStatusStatistic()
        {
            InitializeComponent();

            _dbContext = HousingConstructionEntities.GetContext();
        }

        private void StatusChange_Button_Click(object sender, RoutedEventArgs e)
        {
            switch ((sender as Button).Name)
            {
                case "InProgress_Button":
                    _dbContext.InProgressHousingInfo.Load();

                    DataGrid_Main.ItemsSource = _dbContext.InProgressHousingInfo.Local.ToBindingList();
                    break;

                case "Completed_Button":
                    _dbContext.CompletedHousingInfo.Load();

                    DataGrid_Main.ItemsSource = _dbContext.CompletedHousingInfo.Local.ToBindingList();
                    break;

                case "Sold_Button":
                    _dbContext.SoldHousingInfo.Load();

                    DataGrid_Main.ItemsSource = _dbContext.SoldHousingInfo.Local.ToBindingList();
                    break;
            }
        }
    }
}
