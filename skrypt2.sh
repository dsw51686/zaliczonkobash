if [[ "$1" == "--date" || "$1" == "-d" ]]; then
    current_date=$(date +%Y-%m-%d)
    echo "Dzisiejsza data: $current_date"
elif [[ "$1" == "--logs" || "$1" == "-l" ]]; then
    if [[ -n "$2" ]]; then
        num_files=$2
    else
        num_files=100
    fi

 

    for ((i=1; i<=num_files; i++)); do
        filename="log$i/log$i.txt"
        echo "Nazwa pliku: $filename" >> $filename
        echo "Nazwa skryptu: $0" >> $filename
        echo "Data: $(date +%Y-%m-%d)" >> $filename
    done

 

    echo "Utworzono $num_files plików log"
elif [[ "$1" == "--error" || "$1" == "-e" ]]; then
    if [[ -n "$2" ]]; then
        num_files=$2
    else
        num_files=100
    fi

 

    for ((i=1; i<=num_files; i++)); do
        filename="error$i/error$i.txt"
        echo "Nazwa pliku: $filename" >> $filename
        echo "Nazwa skryptu: $0" >> $filename
        echo "Data: $(date +%Y-%m-%d)" >> $filename
    done

 

    echo "Utworzono $num_files plików error"
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Dostępne opcje skryptu:"
    echo "skrypt.sh --date (-d) : Wyświetla dzisiejszą datę."
    echo "skrypt.sh --logs (-l) [liczba] : Tworzy automatycznie podaną liczbę plików log z informacjami o nazwie, skrypcie i dacie."
    echo "skrypt.sh --error (-e) [liczba] : Tworzy automatycznie podaną liczbę plików error z informacjami o nazwie, skrypcie i dacie."
    echo "skrypt.sh --help (-h) : Wyświetla tę pomoc."
    exit 0
elif [[ "$1" == "--init" ]]; then
    git clone <repo_url> .
    export PATH=$(pwd):$PATH
    echo "Repozytorium zostało sklonowane do bieżącego katalogu."
    echo "Ścieżka do repozytorium została dodana do zmiennej środowiskowej PATH."
    exit 0
else
    echo "Nieznana opcja. Użyj skrypt.sh --help (-h), aby uzyskać listę dostępnych opcji."
    exit 1
fi

 

if [[ "$1" == "--date" || "$1" == "--logs" || "$1" == "--error" ]]; then
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