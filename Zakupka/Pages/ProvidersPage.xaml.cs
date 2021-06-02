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
    /// Логика взаимодействия для ProviderPage.xaml
    /// </summary>
    public partial class ProvidersPage : Page
    {
        public ProvidersPage()
        {
            InitializeComponent();
            dGridProviders.ItemsSource = PurchaseEntities.GetContext().Provider.ToList();
            comboFilter.Items.Add("Название поставщика");
            comboFilter.Items.Add("Описание");
            comboFilter.Items.Add("Рейтинг");
            comboFilter.SelectedIndex = 0;
            Update();
        }

        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            Manager.baseFrame.Navigate(new NewProvider(null));
        }

        private void btnDel_Click(object sender, RoutedEventArgs e)
        {
            var providerForRemoving = dGridProviders.SelectedItems.Cast<Provider>().ToList();

            if (MessageBox.Show($"Вы точно хотите удалить следующие {providerForRemoving.Count} элементов?", "Внимание",
                MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                try
                {
                    PurchaseEntities.GetContext().Provider.RemoveRange(providerForRemoving);
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
            Manager.baseFrame.Navigate(new NewProvider((sender as Button).DataContext as Provider));
        }

        private void comboFilter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }

        private void txtBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            Update();
        }

        private void Update()
        {
            try
            {
                List<Provider> currentProvider = PurchaseEntities.GetContext().Provider.ToList();
                currentProvider = currentProvider.Where(p => p.Name.ToLower().Contains(txtBoxSearch.Text.ToLower()) || p.Description.ToLower().Contains(txtBoxSearch.Text.ToLower()) || p.CountOfStars.ToString().Contains(txtBoxSearch.Text.ToLower())).ToList();

                if (comboFilter.SelectedIndex == 0)
                    dGridProviders.ItemsSource = currentProvider.OrderBy(p => p.Name).ToList();
                if (comboFilter.SelectedIndex == 1)
                    dGridProviders.ItemsSource = currentProvider.OrderBy(p => p.Description).ToList();
                if (comboFilter.SelectedIndex == 2)
                    dGridProviders.ItemsSource = currentProvider.OrderBy(p => p.CountOfStars).ToList();

                if (currentProvider.Count == 0)
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
