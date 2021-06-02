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
    /// Логика взаимодействия для NewCatalogPage.xaml
    /// </summary>
    public partial class NewCatalogPage : Page
    {
        public Catalog _currentCatalog = new Catalog();
        public NewCatalogPage(Catalog selectedCatalog)
        {
            InitializeComponent();
            if (selectedCatalog != null)
                _currentCatalog = selectedCatalog;
            DataContext = _currentCatalog;
            comboProduct.ItemsSource = PurchaseEntities.GetContext().Product.ToList();
            comboProvider.ItemsSource = PurchaseEntities.GetContext().Provider.ToList();
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();           
            if (_currentCatalog.Product == null)
                errors.AppendLine("Выберите продукт");
            if (_currentCatalog.Price.Equals("0"))
                errors.AppendLine("Укажите цену за кг.");
            if (_currentCatalog.Provider == null)
                errors.AppendLine("Выберите поставщика");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            if (_currentCatalog.Id == 0)
                PurchaseEntities.GetContext().Catalog.Add(_currentCatalog);
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
