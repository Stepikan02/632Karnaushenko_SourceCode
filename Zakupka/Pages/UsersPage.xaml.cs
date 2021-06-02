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
using Zakupka.Pages;

namespace Zakupka
{
    /// <summary>
    /// Логика взаимодействия для UsersPage.xaml
    /// </summary>
    public partial class UsersPage : Page
    {
        public UsersPage()
        {
            InitializeComponent();
            dGridUser.ItemsSource = PurchaseEntities.GetContext().User.ToList();
            comboFilter.Items.Add("Логин");
            comboFilter.Items.Add("Имя");
            comboFilter.Items.Add("Фамилия");
            comboFilter.Items.Add("Роль");
            comboFilter.SelectedIndex = 0;
            Update();
        }

        private void btnEdit_Click(object sender, RoutedEventArgs e)
        {
            Manager.baseFrame.Navigate(new NewUserPage((sender as Button).DataContext as User));
        }

        private void btnAdd_Click(object sender, RoutedEventArgs e)
        {
            Manager.baseFrame.Navigate(new NewUserPage(null));
        }

        private void btnDel_Click(object sender, RoutedEventArgs e)
        {

        }

        private void Update()
        {
            try
            {
                List<User> currentUser = PurchaseEntities.GetContext().User.ToList();
                currentUser = currentUser.Where(p => p.Login.ToLower().Contains(txtBoxSearch.Text.ToLower()) || p.Name.ToString().Contains(txtBoxSearch.Text.ToLower()) || p.Surname.Contains(txtBoxSearch.Text.ToLower()) || p.Role.Name.Contains(txtBoxSearch.Text.ToLower())).ToList();

                if (comboFilter.SelectedIndex == 0)
                    dGridUser.ItemsSource = currentUser.OrderBy(p => p.Login).ToList();
                if (comboFilter.SelectedIndex == 1)
                    dGridUser.ItemsSource = currentUser.OrderBy(p => p.Name);
                if (comboFilter.SelectedIndex == 1)
                    dGridUser.ItemsSource = currentUser.OrderBy(p => p.Surname);
                if (comboFilter.SelectedIndex == 1)
                    dGridUser.ItemsSource = currentUser.OrderBy(p => p.Role.Name);

                if (currentUser.Count == 0)
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

        private void txtBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            Update();
        }

        private void comboFilter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Update();
        }
    }
}
