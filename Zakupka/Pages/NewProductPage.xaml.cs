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
    /// Логика взаимодействия для NewProductPage.xaml
    /// </summary>
    public partial class NewProductPage : Page
    {      
        private Product _currentProduct = new Product();
        public NewProductPage(Product selectedProduct)
        {
            InitializeComponent();
            if (selectedProduct != null)
                _currentProduct = selectedProduct;
            DataContext = _currentProduct;
            comboProduct.ItemsSource = PurchaseEntities.GetContext().ProductType.ToList();
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(_currentProduct.Title))
                errors.AppendLine("Укажите название продукта");           
            if (_currentProduct.ProductType == null)
                errors.AppendLine("Укажите тип продукта");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            if (_currentProduct.Id == 0)
                PurchaseEntities.GetContext().Product.Add(_currentProduct);
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
