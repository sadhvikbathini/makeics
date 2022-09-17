####### ONLY USE ONCE or USE AFTER rm files #########

cat UNweb.txt|grep -w Jan |while read line; do echo "202201$line" ; done | sed -e 's/\<Jan\>//g' >>dates.txt
cat UNweb.txt|grep -w Feb |while read line; do echo "202202$line" ; done | sed -e 's/\<Feb\>//g' >>dates.txt
cat UNweb.txt|grep -w Mar |while read line; do echo "202203$line" ; done | sed -e 's/\<Mar\>//g' >>dates.txt
cat UNweb.txt|grep -w Apr |while read line; do echo "202204$line" ; done | sed -e 's/\<Apr\>//g' >>dates.txt
cat UNweb.txt|grep -w May |while read line; do echo "202205$line" ; done | sed -e 's/\<May\>//g' >>dates.txt
cat UNweb.txt|grep -w Jun |while read line; do echo "202206$line" ; done | sed -e 's/\<Jun\>//g' >>dates.txt
cat UNweb.txt|grep -w Jul |while read line; do echo "202207$line" ; done | sed -e 's/\<Jul\>//g' >>dates.txt
cat UNweb.txt|grep -w Aug |while read line; do echo "202208$line" ; done | sed -e 's/\<Aug\>//g' >>dates.txt
cat UNweb.txt|grep -w Sep |while read line; do echo "202209$line" ; done | sed -e 's/\<Sep\>//g' >>dates.txt
cat UNweb.txt|grep -w Oct |while read line; do echo "202210$line" ; done | sed -e 's/\<Oct\>//g' >>dates.txt
cat UNweb.txt|grep -w Nov |while read line; do echo "202211$line" ; done | sed -e 's/\<Nov\>//g' >>dates.txt
cat UNweb.txt|grep -w Dec |while read line; do echo "202212$line" ; done | sed -e 's/\<Dec\>//g' >>dates.txt
#awk '{ if (NR%2==0) print}' UNweb.txt > ddates.txt
#COUNT=0
#cat ddates.txt|cut -d "-" -f3 | while read date;do
#COUNT=$[$COUNT+1]
#echo "$date$(awk -v var=$COUNT '{ if (NR==var) print}' ddates.txt|cut -d "-" -f2)$(awk -v var=$COUNT '{ if (NR==var) print}' ddates.txt| cut -d "-" -f1)"
#done >> dates.txt

awk '{ if (NR%2==1) print}' UNweb.txt > days.txt

echo '''BEGIN:VCALENDAR
VERSION:2.0
METHOD:PUBLISH
X-MS-OLK-FORCEINSPECTOROPEN:TRUE
 ''' > UNDAYS.ics

COUNTER=0
cat days.txt | while read day;do
COUNTER=$[$COUNTER +1]
echo "BEGIN:VEVENT
SUMMARY:$day
DESCRIPTION:$day Click: http://undocs.org/en/$(echo $day|cut -d "(" -f2 | cut -d ")" -f1)
URL:http://undocs.org/en/$(echo $day |cut -d "(" -f2 | cut -d ")" -f1)
DTSTART;VALUE=DATE:$(awk -v var=$COUNTER '{ if (NR==var) print}' dates.txt)
DTEND;VALUE=DATE:$(($(awk -v var=$COUNTER '{ if (NR==var) print}' dates.txt) +1))
TRANSP:TRANSPARENT
END:VEVENT
"
done >> UNDAYS.ics

echo '''END:VCALENDAR''' >> UNDAYS.ics

rm dates.txt days.txt
