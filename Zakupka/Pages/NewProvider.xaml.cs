using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Zakupka.Data;

namespace Zakupka
{
    /// <summary>
    /// Логика взаимодействия для NewProvider.xaml
    /// </summary>
    public partial class NewProvider : Page
    {
        private Provider _currentProvider = new Provider();
        public NewProvider(Provider selectedProvider)
        {
            InitializeComponent();
            if (selectedProvider != null)
                _currentProvider = selectedProvider;
            DataContext = _currentProvider;
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(_currentProvider.Name))
                errors.AppendLine("Укажите название компании (поставщика)");
            if (_currentProvider.CountOfStars < 1 || _currentProvider.CountOfStars > 5)
                errors.AppendLine("Количество звёзд - число от 1 до 5");           

            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            if (_currentProvider.Id == 0)
                PurchaseEntities.GetContext().Provider.Add(_currentProvider);
            try
            {
                PurchaseEntities.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена");
                Manager.baseFrame.GoBack();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
    }
}
