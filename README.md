# FirmaDigitalcrm
Script para instalar la firma digital de costa rica en manjaro.

El script automatiza la información en esta guía: https://fran.cr/instalar-firma-digital-costa-rica-manjaro-arch-linux/

Instrucciones para correr el script:

- El archivo de instalacion de firma digital debe estar en la carpeta /home/user/ respectiva ,el archivo rpm de 64 bits se obtiene de https://www.soportefirmadigital.com/web/es/
- Se recomienda usar firmador.app (copiar y pegar firmador.app en firefox para obtenerlo)


Para instalar en firefox (En caso de que la instalación anterior no haya hecho que funcione por defecto):

Se debe cargar el módulo /usr/lib/libASEP11.so en security devices en firefox. El módulo debería estar en la carpeta correspondiente 
después de ejecutar el script.
