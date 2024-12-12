using HousingConstruction.Views.Statistics;
using System.Windows;

namespace HousingConstruction
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            Tab_DeveloperStat.Navigate(new DeveloperStatistic());
            Tab_ShiftStat.Navigate(new ShiftStatistic());
            Tab_Status.Navigate(new HousingStatusStatistic());
            Tab_WorkerStat.Navigate(new WorkerStatistic());

            Tab_ConstructionMain.Navigate(new Views.Constructions.MainPage(new NavigationContext(Tab_ConstructionMain)));
            Tab_DeveloperMain.Navigate(new Views.Developers.MainPage(new NavigationContext(Tab_DeveloperMain)));
            Tab_HousingMain.Navigate(new Views.Housings.MainPage(new NavigationContext(Tab_HousingMain)));
            Tab_ShiftMain.Navigate(new Views.Shifts.MainPage(new NavigationContext(Tab_ShiftMain)));
            Tab_WorkerMain.Navigate(new Views.Workers.MainPage(new NavigationContext(Tab_WorkerMain)));
        }
    }
}
