# XiaoAi-MQTT

wget -P /root https://raw.githubusercontent.com/junnikokuki/XiaoAi-MQTT/master/libcares_1.10.0-1_meson.ipk

wget -P /root https://raw.githubusercontent.com/junnikokuki/XiaoAi-MQTT/master/libmosquitto-nossl_1.4.7-1_meson.ipk

wget -P /root https://raw.githubusercontent.com/junnikokuki/XiaoAi-MQTT/master/mosquitto-client-nossl_1.4.7-1_meson.ipk

wget -P /root https://raw.githubusercontent.com/junnikokuki/XiaoAi-MQTT/master/mqtt-control.sh

wget -P /root https://raw.githubusercontent.com/junnikokuki/XiaoAi-MQTT/master/mqtt-status.sh

wget -P /root https://raw.githubusercontent.com/junnikokuki/XiaoAi-MQTT/master/mqtt.conf

wget -P /etc/init.d https://raw.githubusercontent.com/junnikokuki/XiaoAi-MQTT/master/mqtt_control_enable

wget -P /etc/init.d https://raw.githubusercontent.com/junnikokuki/XiaoAi-MQTT/master/mqtt_status_enable

cd /root

opkg install libcares_1.10.0-1_meson.ipk

opkg install libmosquitto-nossl_1.4.7-1_meson.ipk

opkg install mosquitto-client-nossl_1.4.7-1_meson.ipk

chmod +x mqtt-control.sh

chmod +x mqtt-status.sh

chmod +x /etc/init.d/mqtt_control_enable

chmod +x /etc/init.d/mqtt_status_enable

vi mqtt.conf

修改MQTT服务器信息

/etc/init.d/mqtt_control_enable enable

/etc/init.d/mqtt_control_enable start

/etc/init.d/mqtt_status_enable enable

/etc/init.d/mqtt_status_enable start
