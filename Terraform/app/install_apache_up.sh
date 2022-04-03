# 
#
#
dirApp="/home/adminuser/app"
dirServ="/etc/systemd/system"
dirApa="/etc/apache2"


echo "Atualizando"
apt update
echo "Instalar o Apache2"
apt install -y apache2
echo "Copiar o ${dirApp}/apache2.service ${dirServ}/."
cp ${dirApp}/apache2.service ${dirServ}/.
echo "Renomear o ${dirApa}/ports.conf ${dirApa}/ports.conf.orig"
mv ${dirApa}/ports.conf ${dirApa}/ports.conf.orig
echo "Copiar o ${dirApp}/apache2.service ${dirServ}/."
cp ${dirApp}/ports.conf ${dirApa}/.
apachectl stop
service apache2 start