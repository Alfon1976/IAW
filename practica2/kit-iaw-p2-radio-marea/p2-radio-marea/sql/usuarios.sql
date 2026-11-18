-- C1.1 · El usuario de la web y de la API: radio_web
CREATE USER IF NOT EXISTS 'radio_web'@'%' IDENTIFIED BY '8adb9709746d0a7fafe45e6029e2fc93';
GRANT SELECT ON radio.* TO 'radio_web'@'%';

-- C1.2 · root solo puede entrar desde el propio servidor
DROP USER IF EXISTS 'root'@'%';
DROP USER IF EXISTS 'root'@'172.%';
DROP USER IF EXISTS 'root'@'192.%';
FLUSH PRIVILEGES;
