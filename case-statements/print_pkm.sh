# Version 1
os=Fedora

case $os in
  "Fedora") echo "Uses RPM package manager" ;;

  "RHEL") echo "Uses RPM package manager" ;;

  "CentOS") echo "Uses RPM package manager" ;;

  "Debian") echo "Uses DEB package manager" ;;

  "Ubuntu")
            echo "Uses DEB package manager" ;;
esac

# Version 2
echo "Start by entering your OS"
echo "q to quit"
read -p "Enter your OS: " os

case $os in
    "Fedora") echo "Uses RPM package manager" ;;

    "RHEL") echo "Uses RPM package manager" ;;

    "CentOS") echo "Uses RPM package manager" ;;

    "Debian") echo "Uses DEB package manager" ;;

    "Ubuntu") echo "Uses DEB package manager" ;;
    
    "q") break ;;

esac