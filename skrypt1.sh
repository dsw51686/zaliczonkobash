if [[ "$1" == "--date" ]]; then
    current_date=$(date +%Y-%m-%d)
    echo "Dzisiejsza data: $current_date"
elif [[ "$1" == "--logs" ]]; then
    if [[ -n "$2" ]]; then
        num_files=$2
    else
        num_files=100
    fi

    for ((i=1; i<=num_files; i++)); do
        filename="log$i.txt"
        echo "Nazwa pliku: $filename" >> $filename
        echo "Nazwa skryptu: $0" >> $filename
        echo "Data: $(date +%Y-%m-%d)" >> $filename
    done

    echo "Utworzono $num_files plików log"
elif [[ "$1" == "--help" ]]; then
    echo "Dostępne opcje skryptu:"
    echo "skrypt.sh --date : Wyświetla dzisiejszą datę."
    echo "skrypt.sh --logs [liczba] : Tworzy automatycznie podaną liczbę plików log z informacjami o nazwie, skrypcie i dacie."
    echo "skrypt.sh --help : Wyświetla tę pomoc."
else
    echo "Nieznana opcja. Użyj skrypt.sh --help, aby uzyskać listę dostępnych opcji."
fi

if [[ "$1" == "--date" || "$1" == "--logs" ]]; then
    branch_name="taskBranch"
    main_branch="głównyBranch"

    git checkout -b $branch_name
    git add .
    git commit -m "Wykonano zmiany na branchu $branch_name"
    git push origin $branch_name

    git checkout $main_branch
    git merge $branch_name
    git push origin $main_branch
fi

