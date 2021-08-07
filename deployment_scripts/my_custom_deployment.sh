#!/bin/bash
#
# Automate ECommerce Application Deployment
# Author: Juan Perez Jr

#######################################
# Print a message in a given color.
# Arguments:
#   Color. eg: green, red
#######################################
function print_color(){
  NC='\033[0m' # No Color

  case $1 in
    "green") COLOR='\033[0;32m' ;;
    "red") COLOR='\033[0;31m' ;;
    "*") COLOR='\033[0m' ;;
  esac

  echo -e "${COLOR} $2 ${NC}"
}

#######################################
# Check the status of a given service. If not active exit script
# Arguments:
#   Service Name. eg: firewalld, mariadb
#######################################
function check_service_status(){
  service_is_active=$(sudo systemctl is-active $1)

  if [ $service_is_active = "active" ]
  then
    echo "$1 is active and running"
  else
    echo "$1 is not active/running"
    exit 1
  fi
}

#######################################
# Check the status of a firewalld rule. If not configured exit.
# Arguments:
#   Port Number. eg: 3306, 80
#######################################
function is_firewalld_rule_configured(){

  firewalld_ports=$(sudo firewall-cmd --list-all --zone=public | grep ports)

  if [[ $firewalld_ports == *$1* ]]
  then
    echo "FirewallD has port $1 configured"
  else
    echo "FirewallD port $1 is not configured"
    exit 1
  fi
}

#######################################
# Check if a given item is present in an output
# Arguments:
#   1 - Output
#   2 - Item
#######################################
function check_item(){
  if [[ $1 = *$2* ]]
  then
    print_color "green" "Item $2 is present on the web page"
  else
    print_color "red" "Item $2 is not present on the web page"
  fi
}

function setup_firewall(){
    # Install and configure firewalld
    print_color "green" "Installing FirewallD.. "
    sudo yum install -y firewalld

    print_color "green" "Installing FirewallD.. "
    sudo service firewalld start
    sudo systemctl enable firewalld

    # Check FirewallD Service is running
    check_service_status firewalld
}

function install_and_configure_maria_db(){
    # Install and configure Maria-DB
    print_color "green" "Installing MariaDB Server.."
    sudo yum install -y mariadb-server

    print_color "green" "Starting MariaDB Server.."
    sudo service mariadb start
    sudo systemctl enable mariadb

    # Check FirewallD Service is running
    check_service_status mariadb
}

function configure_database_firewall_rules(){
    # Configure Firewall rules for Database
    print_color "green" "Configuring FirewallD rules for database.."
    sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
    sudo firewall-cmd --reload

    is_firewalld_rule_configured 3306
}

function configure_database_and_load_tables(){
    # Configuring Database
    print_color "green" "Setting up database.."
    cat > setup-db.sql <<-EOF
    CREATE DATABASE ecomdb;
    CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
    GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
    FLUSH PRIVILEGES;
EOF

    sudo mysql < setup-db.sql

    # Loading inventory into Database
    print_color "green" "Loading inventory data into database"
    cat > db-load-script.sql <<-EOF
    USE ecomdb;
    CREATE TABLE products (id mediumint(8) unsigned NOT NULL auto_increment,Name varchar(255) default NULL,Price varchar(255) default NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) AUTO_INCREMENT=1;

    INSERT INTO products (Name,Price,ImageUrl) VALUES ("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");

EOF

    sudo mysql < db-load-script.sql

    mysql_db_results=$(sudo mysql -e "use ecomdb; select * from products;")

    if [[ $mysql_db_results == *Laptop* ]]
    then
    print_color "green" "Inventory data loaded into MySQl"
    else
    print_color "green" "Inventory data not loaded into MySQl"
    exit 1
    fi
}

function install_server_packages_configure_firewall_rules(){
    # Install web server packages
    print_color "green" "Installing Web Server Packages .."
    sudo yum install -y httpd php php-mysql

    # Configure firewalld rules
    print_color "green" "Configuring FirewallD rules.."
    sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
    sudo firewall-cmd --reload

    is_firewalld_rule_configured 80
}

function setup_httpd_service(){
    # Update index.php
    sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf

    # Start httpd service
    print_color "green" "Start httpd service.."
    sudo service httpd start
    sudo systemctl enable httpd

    # Check FirewallD Service is running
    check_service_status httpd
}

function download_and_install_repo_code(){
    # Download code
    print_color "green" "Install GIT.."
    sudo yum install -y git
    sudo git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/

    print_color "green" "Updating index.php.."
    sudo sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php
}

function run_test_script(){
    # Test Script
    web_page=$(curl http://localhost)

    for item in Laptop Drone VR Watch Phone
    do
    check_item "$web_page" $item
    done
}


##########################################
# Select which tasks to complete or Full Automation

while true
do
    echo "1. Setup Database Server"
    echo "2. Setup Webserver"
    echo "3. Test Deployment"
    echo "4. Deploy Full Automation"
    echo "5. Abort"

    read -p "Enter which task to perform: " choice

    case $choice in 
        
        1)  echo "---------------- Setup Database Server ------------------"
            setup_firewall
            install_and_configure_maria_db
            configure_database_firewall_rules
            configure_database_and_load_tables
            print_color "green" "---------------- Setup Database Server - Finished ------------------" ;;
        
        2)  print_color "green" "---------------- Setup Web Server ------------------"
            install_server_packages_configure_firewall_rules
            setup_httpd_service
            download_and_install_repo_code
            print_color "green" "---------------- Setup Web Server - Finished ------------------" ;;
        
        3)  run_test_script ;;

        4)  echo "---------------- Setup Database Server ------------------"
            setup_firewall
            install_and_configure_maria_db
            configure_database_firewall_rules
            configure_database_and_load_tables
            print_color "green" "---------------- Setup Database Server - Finished ------------------"
            print_color "green" "---------------- Setup Web Server ------------------"
            install_server_packages_configure_firewall_rules
            setup_httpd_service
            download_and_install_repo_code
            print_color "green" "---------------- Setup Web Server - Finished ------------------"
            run_test_script ;;
        
        5) break ;;

    esac
done