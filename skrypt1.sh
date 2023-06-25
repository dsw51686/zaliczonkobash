if [ "$1" == "--date" ]; then
 date
elif [ "$1" == "--logs" ]; then
 if [ -z "$2" ]; then
   num_logs=100
 else
   num_logs=$2
 fi

 for ((i=1; i<=$num_logs; i++)); do
   filename="log$i.txt"
   echo "Nazwa pliku: $filename" >> $filename
   echo "Nazwa skryptu: skrypt.sh" >> $filename
   date >> $filename
 done
elif [ "$1" == "--help" ]; then
 echo "Dostępne opcje:"
 echo "- skrypt.sh --date : Wyświetla dzisiejszą datę."
 echo "- skrypt.sh --logs : Tworzy 100 plików logx.txt z informacjami."
 echo "- skrypt.sh --logs <liczba> : Tworzy określoną liczbę plików logx.txt z informacjami."
 echo "- skrypt.sh --help : Wyświetla dostępne opcje."
else
 echo "Nieznana opcja. Użyj 'skrypt.sh --help' aby uzyskać więcej informacji."
fi