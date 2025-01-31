cd ..; make >/dev/null

./philo 1 800 200 200 >tmp
echo "Test 1 800 200 200 : The philosopher should not eat and should die at 800ms.";echo
time_to_die=$(grep died <tmp | awk '{print $1}')
if grep died <tmp >/dev/null
then
    printf "\033[0;32mOK\033[0m"
    if [ $time_to_die -eq 800 ] || [ $time_to_die -eq 801 ]
    then
        printf " \033[0;32mOK\033[0m\n"
    else
        printf " \033[0;31mKO\033[0m\n"
        echo "Test 1 800 200 200: The philo death is not equal to 800ms (or 801ms)" >traces
    fi
else
    printf "\033[0;31mKO\033[0m\n"
fi


echo; echo "Test 5 800 200 200 : No philosopher should die. (10s test)";echo
if timeout 10 ./philo 5 800 200 200 | grep died >/dev/null
then
    printf "\033[0;31mKO\033[0m\n"
else
    printf "\033[0;32mOK\033[0m\n"
fi


echo; echo "Test 5 800 200 200 7 : No philosopher should die and the simulation should stop when every philosopher has eaten at least 7 times.";echo
./philo 5 800 200 200 7 >tmp
meal_count=$(grep eating <tmp | wc -l)
if grep died <tmp >/dev/null
then
    printf "\033[0;31mKO\033[0m\n"
else
    printf "\033[0;32mOK\033[0m"
    if [ $meal_count -gt 34 ]
    then
        printf " \033[0;32mOK\033[0m\n"
    else
        printf " \033[0;31mKO\033[0m\n"
        echo "Test 5 800 200 200: The philosophers did not eat 7 times" >traces
    fi
fi


echo; echo "Test 4 410 200 200 : No philosopher should die. (10s test)";echo
if timeout 10 ./philo 4 410 200 200 | grep died >/dev/null
then
    printf "\033[0;31mKO\033[0m\n"
else
    printf "\033[0;32mOK\033[0m\n"
fi


echo; echo "Test 3 310 200 100 : One philosopher should die at 310ms.";echo
./philo 4 310 200 100 >tmp
time_to_die=$(grep died <tmp | awk '{print $1}')
if grep died <tmp >/dev/null
then
    printf "\033[0;32mOK\033[0m"
    if [ $time_to_die -eq 310 ] || [ $time_to_die -eq 311 ]
    then
        printf " \033[0;32mOK\033[0m\n"
    else
        printf " \033[0;31mKO\033[0m\n"
        echo "Test 3 310 200 100: The philo death is not equal to 310ms" >traces
    fi
else
    printf "\033[0;31mKO\033[0m\n"
fi


echo; echo "Test 2 400 200 200 : No philosopher should die. (10s test)";echo
if timeout 10 ./philo 2 400 200 200 | grep died >/dev/null
then
    printf "\033[0;31mKO\033[0m\n"
else
    printf "\033[0;32mOK\033[0m\n"
fi

echo; echo "Test 2 200 200 200 : One philosopher should die at 200ms.";echo
./philo 2 200 200 200 >tmp
time_to_die=$(grep died <tmp | awk '{print $1}')
if grep died <tmp >/dev/null
then
    printf "\033[0;32mOK\033[0m"
    if [ $time_to_die -gt 199 ] || [ $time_to_die -lt 211 ]
    then
        printf " \033[0;32mOK\033[0m\n"
    else
        printf " \033[0;31mKO\033[0m\n"
        echo "Test 2 200 200 200: The death is delayed by more than 10 ms" >traces
    fi
else
    printf "\033[0;31mKO\033[0m\n"
fi

rm tmp