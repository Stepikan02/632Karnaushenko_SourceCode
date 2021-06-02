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

namespace Zakupka
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class StartWindow : Window
    {
        public StartWindow()
        {
            InitializeComponent();
            baseFrame.Navigate(new AutorizationPage());
            Manager.baseFrame = baseFrame;
        }

        private void baseFrame_ContentRendered(object sender, EventArgs e)
        {
            if (baseFrame.CanGoBack)
            {
                this.ResizeMode = ResizeMode.CanResize;
                txtUserAndRole.Text = "Пользователь: " + Manager.userName + " " + Manager.userSurname + "(" + Manager.userRole + ")";
                btnBack.Visibility = Visibility.Visible;
                if (Manager.userRole.Equals("Администратор"))
                {
                    adminImg.Visibility = Visibility.Visible;
                    btnUsers.Visibility = Visibility.Visible;
                    btnHistory.Visibility = Visibility.Visible;
                }
                else if (Manager.userRole.Equals("Менеджер"))
                {
                    managerImg.Visibility = Visibility.Visible;
                    btnProviders.Visibility = Visibility.Visible;
                    btnProduct.Visibility = Visibility.Visible;
                    btnCatalog.Visibility = Visibility.Visible;
                    btnOrders.Visibility = Visibility.Visible;
                }
                    
                
            }
            else
            {
                txtUserAndRole.Text = "";
                this.ResizeMode = ResizeMode.NoResize;
                adminImg.Visibility = Visibility.Collapsed;
                managerImg.Visibility = Visibility.Collapsed;
                btnUsers.Visibility = Visibility.Collapsed;
                btnHistory.Visibility = Visibility.Collapsed;
                btnProviders.Visibility = Visibility.Collapsed;
                btnProduct.Visibility = Visibility.Collapsed;
                btnProduct.Visibility = Visibility.Collapsed;
                btnCatalog.Visibility = Visibility.Collapsed;
                btnBack.Visibility = Visibility.Collapsed;
                btnOrders.Visibility = Visibility.Collapsed;

                MinHeight = 500;
                MinWidth = 800;
            }
        }

        private void btnUsers_Click(object sender, RoutedEventArgs e)
        {
            baseFrame.Navigate(new UsersPage());
        }

        private void btnHistory_Click(object sender, RoutedEventArgs e)
        {
            baseFrame.Navigate(new HistoryPage());
        }

        private void btnProviders_Click(object sender, RoutedEventArgs e)
        {
            baseFrame.Navigate(new ProvidersPage());
        }

        private void btnProduct_Click(object sender, RoutedEventArgs e)
        {
            baseFrame.Navigate(new ProductsPage());
        }

        private void btnCatalog_Click(object sender, RoutedEventArgs e)
        {
            baseFrame.Navigate(new CatalogPage());
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            baseFrame.GoBack();
        }

        private void btnOrders_Click(object sender, RoutedEventArgs e)
        {
            baseFrame.Navigate(new OrdersPage());
        }
    }
}
