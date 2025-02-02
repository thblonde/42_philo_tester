cd ..; make >/dev/null; echo
rm -f trace

# Check argument validity
./philo >output 2>&1
echo -n "Argument check: "
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf "\033[0;32mOK\033[0m"
else
    printf "\033[0;31mKO\033[0m"
    echo "./philo: \033[0;31mKO\033[0m" >trace
fi

./philo 1 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m"
else
    printf " \033[0;31mKO\033[0m"
    echo "./philo 1: \033[0;31mKO\033[0m" >>trace
fi

./philo 1 2 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m"
else
    printf " \033[0;31mKO\033[0m"
    echo "./philo 1 2: \033[0;31mKO\033[0m" >>trace
fi

./philo 1 2 3 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m"
else
    printf " \033[0;31mKO\033[0m"
    echo "./philo 1 2 3: \033[0;31mKO\033[0m" >>trace
fi

./philo 1 2 3 4 5 6 7 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m"
else
    printf " \033[0;31mKO\033[0m"
    echo "./philo 1 2 3 4 5 6 7: \033[0;31mKO\033[0m" >>trace
fi

./philo -5 800 200 200 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m"
else
    printf " \033[0;31mKO\033[0m"
    echo "./philo -5 800 200 200: \033[0;31mKO\033[0m" >>trace
fi

./philo 5 -800 200 200 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m"
else
    printf " \033[0;31mKO\033[0m"
    echo "./philo 5 -800 200 200: \033[0;31mKO\033[0m" >>trace
fi

./philo 5 800 -200 200 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m"
else
    printf " \033[0;31mKO\033[0m"
    echo "./philo 5 800 -200 200: \033[0;31mKO\033[0m" >>trace
fi

./philo 5 800 200 -200 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m"
else
    printf " \033[0;31mKO\033[0m"
    echo "./philo 5 800 200 -200: \033[0;31mKO\033[0m" >>trace
fi

./philo 5 800 200 200 -7 >output 2>&1
if grep -qiE "error|invalid|arg|args|argument|arguments|usage" output
then
    printf " \033[0;32mOK\033[0m\n\n"
else
    printf " \033[0;31mKO\033[0m\n\n"
    echo "./philo 5 800 200 200 -7: \033[0;31mKO\033[0m" >>trace
fi


# Mandatory tests
./philo 1 800 200 200 >output
time_to_die=$(grep -iE "died|dead" <output | awk '{print $1}')
number_of_action=$(wc -l <output)
echo -n "[1 800 200 200]: "
if [ $number_of_action -eq 2 ] && grep -qiE "died|dead" <output
then
    printf "\033[0;32mOK\033[0m"
    if [ $time_to_die -eq 800 ] || [ $time_to_die -eq 801 ]
    then
        printf " \033[0;32mOK\033[0m\n\n"
    else
        printf " \033[0;31mKO\033[0m\n\n"
        echo "./philo 1 800 200 200: \033[0;31mKO\033[0m : the philo should die at around 800ms" >>trace
    fi
else
    printf "\033[0;31mKO\033[0m\n"
    echo "./philo 1 800 200 200: \033[0;31mKO\033[0m : the philo should take his fork, wait his time_to_die and die" >>trace
fi

echo -n "[5 800 200 200]: "
if timeout 10 ./philo 5 800 200 200 | grep -qiE "died|dead"
then
    printf "\033[0;31mKO\033[0m\n\n"
    echo "./philo 5 800 200 200: \033[0;31mKO\033[0m : no one should die" >>trace
else
    printf "\033[0;32mOK\033[0m\n\n"
fi

echo -n "[5 800 200 200 7]: "
./philo 5 800 200 200 7 >output
meal_count=$(grep -iE "eating|eat|ate" <output | wc -l)
if grep -qiE "died|dead" <output
then
    printf "\033[0;31mKO\033[0m\n"
    echo "./philo 5 800 200 200 7: \033[0;31mKO\033[0m : no one should die" >>trace
else
    printf "\033[0;32mOK\033[0m"
    if [ $meal_count -gt 34 ]
    then
        printf " \033[0;32mOK\033[0m\n\n"
    else
        printf " \033[0;31mKO\033[0m\n\n"
        echo "./philo 5 800 200 200 7: \033[0;31mKO\033[0m : all philos must eat 7 times" >>trace
    fi
fi

echo -n "[4 410 200 200]: "
if timeout 10 ./philo 4 410 200 200 | grep -qiE "died|dead"
then
    printf "\033[0;31mKO\033[0m\n\n"
    echo "./philo 4 410 200 200: \033[0;31mKO\033[0m : no one should die" >>trace
else
    printf "\033[0;32mOK\033[0m\n\n"
fi

./philo 4 310 200 100 >output
time_to_die=$(grep -iE "died|dead" <output | awk '{print $1}')
echo -n "[4 310 200 100]: "
if grep -qiE "died|dead" <output
then
    printf "\033[0;32mOK\033[0m"
    if [ $time_to_die -eq 310 ] || [ $time_to_die -eq 311 ]
    then
        printf " \033[0;32mOK\033[0m\n\n"
    else
        printf " \033[0;31mKO\033[0m\n\n"
        echo "./philo 4 310 200 100: \033[0;31mKO\033[0m : a philo should die around 310ms" >>trace
    fi
else
    printf "\033[0;31mKO\033[0m\n"
    echo "./philo 4 310 200 100: \033[0;31mKO\033[0m : a philo should die" >>trace
fi

echo -n "[2 410 200 200]: "
if timeout 10 ./philo 2 410 200 200 | grep -qiE "died|dead"
then
    printf "\033[0;31mKO\033[0m\n\n"
    echo "./philo 2 410 200 200: \033[0;31mKO\033[0m : no one should die" >>trace
else
    printf "\033[0;32mOK\033[0m\n\n"
fi

./philo 2 200 200 200 >output
time_to_die=$(grep -iE "died|dead" <output | awk '{print $1}')
echo -n "[2 200 200 200]: "
if grep -qiE "died|dead" <output
then
    printf "\033[0;32mOK\033[0m"
    if [ $time_to_die -gt 199 ] || [ $time_to_die -lt 211 ]
    then
        printf " \033[0;32mOK\033[0m\n\n"
    else
        printf " \033[0;31mKO\033[0m\n\n"
        echo "./philo 4 310 200 100: \033[0;31mKO\033[0m : a philo should die around 200ms" >>trace
    fi
else
    printf "\033[0;31mKO\033[0m\n"
    echo "./philo 2 200 200 200: \033[0;31mKO\033[0m : a philo should die" >>trace
fi

rm -f output
cd 42_philo_tester/