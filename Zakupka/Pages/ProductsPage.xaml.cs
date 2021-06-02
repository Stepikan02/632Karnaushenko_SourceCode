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
    /// Логика взаимодействия для ProductPage.xaml
    /// </summary>
    public partial class ProductsPage : Page
    {
        public ProductsPage()
        {
            InitializeComponent();
            dGridProducts.ItemsSource = PurchaseEntities.GetContext().Product.ToList();
            comboFilter.Items.Add("Название");
            comboFilter.Items.Add("Тип");
            comboFilter.Items.Add("Описание");
            comboFilter.SelectedIndex = 0;
            Update();
        }

        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            Manager.baseFrame.Navigate(new NewProductPage(null));
        }

        private void btnDel_Click(object sender, RoutedEventArgs e)
        {
            var productsForRemoving = dGridProducts.SelectedItems.Cast<Product>().ToList();

            if (MessageBox.Show($"Вы точно хотите удалить следующие {productsForRemoving.Count} элементов?", "Внимание",
                MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                try
                {
                    PurchaseEntities.GetContext().Product.RemoveRange(productsForRemoving);
                    PurchaseEntities.GetContext().SaveChanges();
                    MessageBox.Show("Данные удалены!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
        }

        private void btnEdit_Click(object sender, RoutedEventArgs e)
        {
            Manager.baseFrame.Navigate(new NewProductPage((sender as Button).DataContext as Product));
        }

        private void txtBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {           
            Update();
        }

        private void Update()
        {
            try
            {
                List<Product> currentProduct = PurchaseEntities.GetContext().Product.ToList();
                currentProduct = currentProduct.Where(p => p.Title.ToLower().Contains(txtBoxSearch.Text.ToLower()) || p.ProductType.Type.ToString().Contains(txtBoxSearch.Text.ToLower()) || p.Description.Contains(txtBoxSearch.Text.ToLower())).ToList();

                if (comboFilter.SelectedIndex == 0)
                    dGridProducts.ItemsSource = currentProduct.OrderBy(p => p.Title).ToList();
                if (comboFilter.SelectedIndex == 1)
                    dGridProducts.ItemsSource = currentProduct.OrderBy(p => p.ProductType.Type);
                if (comboFilter.SelectedIndex == 2)
                    dGridProducts.ItemsSource = currentProduct.OrderByDescending(p => p.Description);

                if (currentProduct.Count == 0)
                {
                    lblNothingFound.Visibility = Visibility.Visible;
                }
                else
                {
                    lblNothingFound.Visibility = Visibility.Collapsed;
                }
            }
            catch
            {
                MessageBox.Show("Ошибка обновления данных", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void comboFilter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }
    }
}
