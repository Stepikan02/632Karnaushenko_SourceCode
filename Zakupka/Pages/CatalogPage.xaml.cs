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
    /// Логика взаимодействия для CatalogPage.xaml
    /// </summary>
    public partial class CatalogPage : Page
    {
        public CatalogPage()
        {
            InitializeComponent();
            dGridCatalog.ItemsSource = PurchaseEntities.GetContext().Catalog.ToList();
            comboFilter.Items.Add("Продукт");
            comboFilter.Items.Add("Цена");
            comboFilter.Items.Add("Поставщик");
            comboFilter.SelectedIndex = 0;
            Update();
        }

        private void txtBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            Update();
        }

        private void comboFilter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }

        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            Manager.baseFrame.Navigate(new NewCatalogPage(null));
        }

        private void btnDel_Click(object sender, RoutedEventArgs e)
        {
            var catalogForRemoving = dGridCatalog.SelectedItems.Cast<Catalog>().ToList();

            if (MessageBox.Show($"Вы точно хотите удалить следующие {catalogForRemoving.Count} элементов?", "Внимание",
                MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                try
                {
                    PurchaseEntities.GetContext().Catalog.RemoveRange(catalogForRemoving);
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
            Manager.baseFrame.Navigate(new NewCatalogPage((sender as Button).DataContext as Catalog));
        }
        private void Update()
        {
            try
            {
                List<Catalog> currentCatalog = PurchaseEntities.GetContext().Catalog.ToList();
                currentCatalog = currentCatalog.Where(p => p.Product.Title.ToLower().Contains(txtBoxSearch.Text.ToLower()) || p.Price.ToString().Contains(txtBoxSearch.Text.ToLower()) || p.Provider.Name.Contains(txtBoxSearch.Text.ToLower())).ToList();

                if (comboFilter.SelectedIndex == 0)
                    dGridCatalog.ItemsSource = currentCatalog.OrderBy(p => p.Product.Title).ToList();
                if (comboFilter.SelectedIndex == 1)
                    dGridCatalog.ItemsSource = currentCatalog.OrderBy(p => p.Price);
                if (comboFilter.SelectedIndex == 1)
                    dGridCatalog.ItemsSource = currentCatalog.OrderBy(p => p.Provider.Name);

                if (currentCatalog.Count == 0)
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
    }
}
