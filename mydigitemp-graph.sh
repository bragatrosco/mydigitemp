#!/bin/sh

RRD_FILE="/data/mydigitemp/mydigitemp.rrd"
DST_FILE="/var/www/html/temp/$1.png"

RRD_PARAMETERS='
  $DST_FILE --end=$(date +%s) --vertical-label "Temperatura .C" --width 1024 --height 300 --lower-limit 0
  DEF:temp0=$RRD_FILE:temp0:AVERAGE
  DEF:temp1=$RRD_FILE:temp1:AVERAGE
  DEF:temp2=$RRD_FILE:temp2:AVERAGE
  LINE1:temp0#CF00FF:"Últimos 10 minutos do sala\\n"
  LINE2:temp1#FF3C00:"Últimos 10 minutos na servidor\\n"
  LINE3:temp2#00B554:"Últimos 10 minutos na rua\\n"
  COMMENT:"Script Atualizado em 13/10/2018 \\n"
  GPRINT:temp0:MIN:"Minimo sala\\: %4.1lf .C      "
  GPRINT:temp1:MIN:"Minimo servidor\\: %4.1lf .C     "
  GPRINT:temp2:MIN:"Minimo esterno\\: %4.1lf .C     "
  GPRINT:temp0:MAX:"Maximo sala\\: %4.1lf .C      "
  GPRINT:temp1:MAX:"Maximo servidor\\: %4.1lf .C \\n"
  GPRINT:temp2:MAX:"Maximo externo\\: %4.1lf .C \\n"
  GPRINT:temp0:AVERAGE:"Maior sala\\: %4.1lf .C  "
  GPRINT:temp1:AVERAGE:"Maior servidor\\: %4.1lf .C "
  GPRINT:temp2:AVERAGE:"Maior externo\\: %4.1lf .C "
  GPRINT:temp0:LAST:"Atual sala\\: %4.1lf .C     "
  GPRINT:temp1:LAST:"Atual servidor\\: %4.1lf .C"
  GPRINT:temp2:LAST:"Atual externo\\: %4.1lf .C"
  > /dev/null
'

case $1 in
  daily)
    eval /usr/bin/rrdtool graph --start="end-2days" --title \'Gráfico diário [`date +"%F %H:%M"`]\' $RRD_PARAMETERS
  ;;
  weekly)
    eval /usr/bin/rrdtool graph --start="end-2week" --title \'Gráfico semanal [`date +"%F %H:%M"`]\' $RRD_PARAMETERS
  ;;
  monthly)
    eval /usr/bin/rrdtool graph --start="end-2month" --title \'Gráfico mensal [`date +"%F %H:%M"`]\' $RRD_PARAMETERS
  ;;
  yearly)
    eval /usr/bin/rrdtool graph --start="end-1year" --title \'Gráfico anual [`date +"%F %H:%M"`]\' $RRD_PARAMETERS
  ;;
  2years)
    eval /usr/bin/rrdtool graph --start="end-2years" --title \'Gráfico de 2 anos [`date +"%F %H:%M"`]\' $RRD_PARAMETERS
  ;;
  5years)
    eval /usr/bin/rrdtool graph --start="end-5years" --title \'Gráfico de 5 anos [`date +"%F %H:%M"`]\' $RRD_PARAMETERS
  ;;
  10years)
    eval /usr/bin/rrdtool graph --start="end-10years" --title \'Gráfico de 10 anos [`date +"%F %H:%M"`]\' $RRD_PARAMETERS
  ;;
  *)
    echo "Please specify $0 [daily|weekly|monthly|yearly|2years|5years|10years]"

  ;;
esac
