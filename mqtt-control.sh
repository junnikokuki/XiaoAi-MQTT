#!/bin/sh
. /root/mqtt.conf

killall mosquitto_sub 2> /dev/null

/usr/bin/mosquitto_sub -v -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/# | while read -r line ; do
  case $line in
    "${TOPIC}/player/prev"*)
      mphelper prev > /dev/null
	  /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/info -r -m "$(ubus call mediaplayer player_get_context)"
	  /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/status -r -m "$(ubus call mediaplayer player_get_play_status)"
    ;;

    "${TOPIC}/player/next"*)
      mphelper next > /dev/null
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/info -r -m "$(ubus call mediaplayer player_get_context)"
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/status -r -m "$(ubus call mediaplayer player_get_play_status)"
    ;;
	
    "${TOPIC}/player/toggle"*)
      mphelper toggle > /dev/null
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/info -r -m "$(ubus call mediaplayer player_get_context)"
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/status -r -m "$(ubus call mediaplayer player_get_play_status)"
    ;;

    "${TOPIC}/player/play"*)                                                  
      mphelper play > /dev/null                                               
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/info -r -m "$(ubus call mediaplayer player_get_context)"
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/status -r -m "$(ubus call mediaplayer player_get_play_status)"
    ;;

    "${TOPIC}/player/pause"*)                                                  
      mphelper pause > /dev/null                                               
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/info -r -m "$(ubus call mediaplayer player_get_context)"
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/status -r -m "$(ubus call mediaplayer player_get_play_status)"
    ;;
	
    "${TOPIC}/volume/up"*)
      mphelper volume_up > /dev/null
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/volume -r -m "$(mphelper volume_get)"
    ;;
	
    "${TOPIC}/volume/down"*)
      mphelper volume_down > /dev/null
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/volume -r -m "$(mphelper volume_get)"
    ;;
	
    "${TOPIC}/player/ch"*)
      mphelper ch > /dev/null
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/info -r -m "$(ubus call mediaplayer player_get_context)"
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/player/status -r -m "$(ubus call mediaplayer player_get_play_status)"
    ;;
	
    "${TOPIC}/volume/set "*)
      vol=$(echo "$line" | awk '{print $2}')
      mphelper volume_set $vol > /dev/null
      /usr/bin/mosquitto_pub -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}"/volume -r -m "$(mphelper volume_get)"
    ;;
	
    "${TOPIC}/tts/set "*)
      tts=$(echo "$line" | awk '{print $2}')
      ubus call mibrain text_to_speech "{\"text\":\"$tts\",\"save\":0}" > /dev/null
    ;;
  esac
done