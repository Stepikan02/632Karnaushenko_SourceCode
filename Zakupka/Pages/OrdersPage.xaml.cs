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
    /// Логика взаимодействия для OrdersPage.xaml
    /// </summary>
    public partial class OrdersPage : Page
    {
        public OrdersPage()
        {
            InitializeComponent();
            dGridOrders.ItemsSource = PurchaseEntities.GetContext().Order.ToList();
            comboFilter.Items.Add("Все");
            comboFilter.Items.Add("Количество");
            comboFilter.Items.Add("Цена");
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
            Manager.baseFrame.Navigate(new NewOrderPage(null));
        }



        private void Update()
        {
            try 
            {
                List<Order> currentOrder = PurchaseEntities.GetContext().Order.ToList();
                currentOrder = currentOrder.Where(p => p.Catalog.Product.Title.ToLower().Contains(txtBoxSearch.Text.ToLower()) || p.Count.ToString().Contains(txtBoxSearch.Text.ToLower()) || p.Cost.ToString().Contains(txtBoxSearch.Text.ToLower())).ToList();

                if (comboFilter.SelectedIndex == 0)
                    dGridOrders.ItemsSource = currentOrder.OrderBy(p => p.Id).ToList();
                if (comboFilter.SelectedIndex == 1)
                    dGridOrders.ItemsSource = currentOrder.OrderBy(p => p.Count);
                if (comboFilter.SelectedIndex == 2)
                    dGridOrders.ItemsSource = currentOrder.OrderBy(p => p.Cost);

                if (currentOrder.Count == 0)
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
