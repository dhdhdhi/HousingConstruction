using HousingConstruction.Model;
using System.Data.Entity;
using System.Windows;
using System.Windows.Controls;

namespace HousingConstruction.Views.Constructions
{
    /// <summary>
    /// Логика взаимодействия для AddEditPage.xaml
    /// </summary>
    public partial class AddEditPage : Page
    {
        private HousingConstructionEntities _dbContext;
        private NavigationContext _navigationContext;

        private AddEditMode _addEditMode;

        private Construction _record;

        public AddEditPage(NavigationContext navigationContext, Construction record)
        {
            InitializeComponent();

            _dbContext = HousingConstructionEntities.GetContext();
            _navigationContext = navigationContext;

            if (record == null)
            {
                _addEditMode = AddEditMode.Add;
                _record = new Construction();
            }
            else
            {
                _addEditMode = AddEditMode.Edit;
                _record = record;
            }

            _dbContext.Developer.Load();
            Developers.ItemsSource = _dbContext.Developer.Local.ToBindingList();

            _dbContext.Housing.Load();
            Housings.ItemsSource = _dbContext.Housing.Local.ToBindingList();

            DataContext = _record;
        }

        private void OK_Button_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            try
            {
                switch (_addEditMode)
                {
                    case AddEditMode.Add:
                        _dbContext.Construction.Add(_record);
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