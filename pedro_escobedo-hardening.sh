so1=$(hostnamectl | sudo grep "CentOS" | wc -c)
so2=$(hostnamectl | sudo grep "Ubuntu" | wc -c)

echo "El sistema operativo es:"
if [ "$so1" != "0" ];
        then
                echo "CentOS"
                echo "Instalando repositorio EPEL"
                sudo yum -y install epel-release
                echo "Repositorio EPEL instalado"
                antivirus=$(yum list installed | sudo grep "clamav")
                if [ -z "$antivirus" ];
                then
                        sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
                else
                        echo "Ya existe una version de ClamAV, se detendra el programa y se desinstalara"
                        sudo systemctl stop clamav-freshclam
                        echo "Se detuvo el programa"
                        sudo yum -y remove clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
                        echo "Se removio el programa"
                        echo "Se instalara ClamAV"
                        sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
                        echo "Se instalo ClamAV"

                sudo yum update
                fi

elif [ "$so2" != "2" ];
        then
                echo "Ubuntu"
                antivirus2=$(apt list --installed | sudo grep "clamav")
                if [ -z "$antivirus2" ];
                then
                        sudo apt-get install clamav clamav-daemon -y
                else
                        echo "Ya existe una version de ClamAV, se detendra el programa y se desinstalara"
                        sudo systemctl stop clamav-freshclam
                        echo "Se detuvo el programa"
                        sudo apt-get remove clamav clamav-daemon -y
                        echo "Se removio el programa"
                        echo "Se instalara ClamAV"
                        sudo apt-get install clamav clamav-daemon -y
                        echo "Se instalo ClamAV"
                sudo apt upgrade
        fi
fi
