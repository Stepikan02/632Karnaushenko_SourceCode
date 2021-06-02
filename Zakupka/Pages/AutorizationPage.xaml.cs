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
    /// Логика взаимодействия для Autorization.xaml
    /// </summary>
    public partial class AutorizationPage : Page
    {
        public AutorizationPage()
        {
            InitializeComponent();
        }

        public static string login = null;

        private void btnGo_Click(object sender, RoutedEventArgs e)
        {
            if (textPassBox.Text != "")
            {
                passBox.Password = textPassBox.Text;
            }
            foreach (User user in PurchaseEntities.GetContext().User.ToList()) 
            {
                if (logBox.Text == user.Login && passBox.Password == user.Password)
                {
                    Manager.userName = user.Name;
                    Manager.userSurname = user.Surname;
                    Manager.userRole = user.Role.Name;
                    MessageBox.Show("Вы успешно вошли!");
                    if (Manager.userRole.Equals("Администратор"))
                    {
                        Manager.baseFrame.Navigate(new HistoryPage());
                    }
                    else if (Manager.userRole.Equals("Менеджер"))
                    {
                        Manager.baseFrame.Navigate(new OrdersPage());
                    }
                    login = logBox.Text;
                    AddHistory(login, true);
                }
                else if (logBox.Text == user.Login && passBox.Password != user.Password)
                {
                    MessageBox.Show("Неправильный пароль!");
                    login = logBox.Text;
                    AddHistory(login, false);
                }
            }
            PurchaseEntities.GetContext().SaveChanges();
        }

        public void AddHistory(string login, bool successful)
        {
            History his = new History
            {
                Date = DateTime.Now,
                Login = login,
                Successful = successful
            };
            PurchaseEntities.GetContext().History.Add(his);
        }
        private void passCheck_Click(object sender, RoutedEventArgs e)
        {
            if (passCheck.IsChecked == true)
            {
                passBox.Visibility = Visibility.Collapsed;
                textPassBox.Visibility = Visibility.Visible;
                textPassBox.Text = passBox.Password;
            }
            else
            {
                passBox.Visibility = Visibility.Visible;
                textPassBox.Visibility = Visibility.Collapsed;
                passBox.Password = textPassBox.Text;
            }
        }
    }
}
