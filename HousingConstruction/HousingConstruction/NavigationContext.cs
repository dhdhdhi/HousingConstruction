using System.Windows.Controls;

namespace HousingConstruction
{
    public class NavigationContext
    {
        private Frame _frame;
        public NavigationContext(Frame frame)
        {
            _frame = frame;
        }

        public void Navigate(Page page)
        {
            _frame.Navigate(page);
        }

        public void Back()
        {
            if (_frame.CanGoBack)
            {
                _frame.GoBack();
            }
        }
    }
}