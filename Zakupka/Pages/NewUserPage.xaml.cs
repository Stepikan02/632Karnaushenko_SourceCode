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

namespace Zakupka.Pages
{
    /// <summary>
    /// Логика взаимодействия для NewUserPage.xaml
    /// </summary>
    public partial class NewUserPage : Page
    {
        private User _currentUser = new User();
        public NewUserPage(User selectedUser)
        {
            InitializeComponent();
            if (selectedUser != null)
                _currentUser = selectedUser;
            DataContext = _currentUser;
            comboRole.ItemsSource = PurchaseEntities.GetContext().Role.ToList();
        }

        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(_currentUser.Login))
                errors.AppendLine("Укажите логин пользователя");
            if (string.IsNullOrWhiteSpace(_currentUser.Password))
                errors.AppendLine("Укажите пароль");
            if (string.IsNullOrWhiteSpace(_currentUser.Name))
                errors.AppendLine("Укажите имя пользователя");
            if (string.IsNullOrWhiteSpace(_currentUser.Surname))
                errors.AppendLine("Укажите фамилию пользователя");
            if (_currentUser.Role == null)
                errors.AppendLine("Укажите роль пользователя");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
                PurchaseEntities.GetContext().User.Add(_currentUser);
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
