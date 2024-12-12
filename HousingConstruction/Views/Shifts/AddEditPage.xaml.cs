using HousingConstruction.Model;
using System.Data.Entity;
using System.Windows;
using System.Windows.Controls;

namespace HousingConstruction.Views.Shifts
{
    /// <summary>
    /// Логика взаимодействия для AddEditPage.xaml
    /// </summary>
    public partial class AddEditPage : Page
    {
        private HousingConstructionEntities _dbContext;
        private NavigationContext _navigationContext;

        private AddEditMode _addEditMode;

        private Shift _record;

        public AddEditPage(NavigationContext navigationContext, Shift record)
        {
            InitializeComponent();

            _dbContext = HousingConstructionEntities.GetContext();
            _navigationContext = navigationContext;

            if (record == null)
            {
                _addEditMode = AddEditMode.Add;
                _record = new Shift();
            }
            else
            {
                _addEditMode = AddEditMode.Edit;
                _record = record;
            }

            _dbContext.Construction.Load();
            Constructions.ItemsSource = _dbContext.Construction.Local.ToBindingList();

            _dbContext.Worker.Load();
            Workers.ItemsSource = _dbContext.Worker.Local.ToBindingList();

            DataContext = _record;
        }

        private void OK_Button_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                switch (_addEditMode)
                {
                    case AddEditMode.Add:
                        _dbContext.Shift.Add(_record);
                        break;
                    case AddEditMode.Edit:
                        break;
                }

                _dbContext.SaveChanges();

                MessageBox.Show("Успешно!");

                _navigationContext.Back();
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(ex.Message + "\n" + ex.InnerException, "Ошибка!");
            }
        }

        private void Cancel_Button_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            _dbContext.RollBack();
            _navigationContext.Back();
        }
    }
}
