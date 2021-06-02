using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Packaging;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
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
using System.Windows.Xps;
using System.Windows.Xps.Packaging;
using Zakupka.Data;

namespace Zakupka
{
    /// <summary>
    /// Логика взаимодействия для NewOrderPage.xaml
    /// </summary>
    public partial class NewOrderPage : Page
    {
        private int ctgId = 0;

        private Catalog _currentCatalog = new Catalog();
        public NewOrderPage(Catalog selectedCatalog)
        {
            InitializeComponent();
            if (selectedCatalog != null)
                _currentCatalog = selectedCatalog;
            DataContext = _currentCatalog;

            textPriceKg.IsReadOnly = true;
            textCost.IsReadOnly = true;
            comboProduct.ItemsSource = PurchaseEntities.GetContext().Product.ToList();
            textPriceKg.Text = Convert.ToString(_currentCatalog.Price);          
        }

        private void btnPrint_Click(object sender, RoutedEventArgs e)
        {
            PrintDialog p = new PrintDialog();
            
            if (p.ShowDialog() == true)
            {             
                p.PrintVisual(printGrid, "Печать");         
            }
        }

        private void textCountKg_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textCountKg.Text == "")
            {
                MessageBox.Show("Введите количество!");
                textCost.Text = "";
            }
            else
            {
                double prisik = Convert.ToDouble(textPriceKg.Text);
                double countik = Convert.ToDouble(textCountKg.Text);
                double costik = Convert.ToDouble(prisik) * Convert.ToDouble(countik);
                textCost.Text = costik.ToString();
            }                     
        }

        private void comboProduct_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        public String[] textPrisec = new String[3];

        private void comboProduct_IsMouseCapturedChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            TextBlock[] textBloxes = new TextBlock[3];
            textBloxes[0] = textProvider1;
            textBloxes[1] = textProdiver2;
            textBloxes[2] = textProvider3;

            RadioButton[] radioBoxes = new RadioButton[3];
            radioBoxes[0] = checkProvider1;
            radioBoxes[1] = checkProvider2;
            radioBoxes[2] = checkProvider3;
            int idProduct = 0;

            textPrisec[0] = "";
            textPrisec[1] = "";
            textPrisec[2] = "";

            checkProvider1.IsChecked = false;
            checkProvider2.IsChecked = false;
            checkProvider3.IsChecked = false;
            textPriceKg.Text = null;

            foreach (Product product in PurchaseEntities.GetContext().Product.ToList())
            {
                if (product.Title == comboProduct.Text)
                {
                    idProduct = product.Id;
                    break;
                }
                
            }
            textProvider1.Text = null;
            textProdiver2.Text = null;
            textProvider3.Text = null;
            checkProvider1.Visibility = Visibility.Collapsed;
            checkProvider2.Visibility = Visibility.Collapsed;
            checkProvider3.Visibility = Visibility.Collapsed;            
            int i = 0;            

            foreach (Catalog catalog in PurchaseEntities.GetContext().Catalog.ToList())
            {                   
                if (idProduct == catalog.ProductId)
                {
                    textBloxes[i].Text = Convert.ToString(catalog.Provider.Name) + ": " + Convert.ToString(catalog.Price) + " рублей";
                    i++;
                    radioBoxes[i].Visibility = Visibility.Visible;
                    textPrisec[i] = Convert.ToString(catalog.Price);
                    ctgId = catalog.Id;
                }
            }    
            
        }

        private void checkProvider1_Click(object sender, RoutedEventArgs e)
        {
            textPriceKg.Text = textPrisec[0];
        }

        private void checkProvider2_Click(object sender, RoutedEventArgs e)
        {
            textPriceKg.Text = textPrisec[1];
        }

        private void checkProvider3_Click(object sender, RoutedEventArgs e)
        {
            textPriceKg.Text = textPrisec[2];
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            Order order = new Order();
            StringBuilder errors = new StringBuilder();
            if (_currentCatalog.Product == null)
                errors.AppendLine("Выберите продукт");
            if (string.IsNullOrWhiteSpace(textCost.Text))
                errors.AppendLine("Укажите количество товара");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            if (_currentCatalog.Id == 0)
                if (textCost.Text != null)
                {
                    addOrder();
                }               
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
        public void addOrder()
        {            
            Order order = new Order()
            {             
                CatalogId = ctgId,
                Count = Convert.ToInt32(textCountKg.Text),
                Cost = Convert.ToDecimal(textCost.Text),
                OrderDate = DateTime.Now
            };
            PurchaseEntities.GetContext().Order.Add(order);
        }

        private void textCountKg_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            Regex regex = new Regex("[^0-9]+");
            e.Handled = regex.IsMatch(e.Text);
        }
    }
}
