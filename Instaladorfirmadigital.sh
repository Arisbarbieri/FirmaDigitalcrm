#Debe estar en la misma carpeta el archivo de instalacion de firma digital, el archivo rpm de 64 bits, para que esto funcione. Se obtiene de https://www.soportefirmadigital.com/web/es/
sudo pacman -Syu --noconfirm --needed firefox firefox-i18n-es-ar unzip cpio rpm-tools pcsclite ccid icedtea-web jre-openjdk
unzip ~/sfd_ClientesLinux_RPM64_Rev18.zip 
#cd ~/sfd_ClientesLinux_RPM64_Rev18.zip ~/Firma\ Digital/PinTool/IDProtect\ PINTool\ 7.24.02/RPM/
#unzip ~/Firma\ Digital/PinTool/IDProtect\ PINTool\ 7.24.02/RPM/sfd_ClientesLinux_RPM64_Rev18.zip
sudo cp -p ~/Firma\ Digital/Certificados/* /usr/share/ca-certificates/trust-source/anchors/

sudo update-ca-trust

#Instalacion de pkcs#11

rpm2cpio ~/Firma\ Digital/PinTool/IDProtect\ PINTool\ 7.24.02/RPM/idprotectclient-7.24.02-0.x86_64.rpm | cpio -dim ./usr/lib/x64-athena/libASEP11.so

sudo cp -p ./usr/lib/x64-athena/libASEP11.so /usr/lib/

sudo mkdir -p /usr/lib/x64-athena/

sudo mkdir -p /Firma_Digital/LIBRERIAS/

sudo ln -s /usr/lib/libASEP11.so /usr/lib/x64-athena/

sudo ln -s /usr/lib/libASEP11.so /usr/local/lib/

sudo ln -s /usr/lib/libASEP11.so /Firma_Digital/LIBRERIAS/

sudo ln -s /usr/share/ca-certificates/trust-source/anchors/Firma_Digital/CERTIFICADOS

#Crear fichero Athena

sudo mkdir /etc/Athena/


sudo echo "<?xml version=\"1.0\" encoding=\"utf-8\" ?>
<IDProtect>
 <TokenLibs>
  <IDProtect>
   <Cards>
    <IDProtectXF>
     <ATR type='hexBinary'>3BDC00FF8091FE1FC38073C821106600000000000000</ATR>
     <ATRMask type='hexBinary'>FFFF00FFF0FFFFFFFFFFFFFFFFF0FF00000000000000</ATRMask>
    </IDProtectXF>
   </Cards>
  </IDProtect>
 </TokenLibs>
</IDProtect>" > ~/IDPClientDB.xml

sudo mv ~/IDPClientDB.xml /etc/Athena/

sudo echo "remote: |bwrap --unshare-all --dir /tmp --proc /proc --dev /dev --ro-bind /etc/Athena /etc/Athena --ro-bind /usr /usr --ro-bind /var/run/pcscd /var/run/pcscd --ro-bind /run/pcscd /run/pcscd p11-kit remote /usr/lib/libASEP11.so" > /usr/share/p11-kit/modules/firma-digital.module
sudo systemctl enable --now pcscd.socket


sudo pacman -Syu --noconfirm --needed gtk-engine-murrine
cp ~/Firma\ Digital/Firmador\ BCCR/firmador-bccr* ~/
rpmextract.sh firmador-bccr*
sudo cp -p -r ~/opt/Firmador-BCCR/ /opt/ 
sudo cp -p ~/opt/Firmador-BCCR/Firmador-BCCR.desktop /usr/share/applications/

# Para instalar en firefox:

#Se debe cargar el módulo /usr/lib/libASEP11.so en security devices en firefox.
