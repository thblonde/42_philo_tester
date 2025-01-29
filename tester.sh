cd ..; make >/dev/null


echo "Test 1 800 200 200 : The philosopher should not eat and should die.";echo
if ./philo 1 800 200 200 | grep died >/dev/null
then
    printf "\033[0;32mOK\033[0m\n"
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


echo; echo "Test 5 800 200 200 : No philosopher should die and the simulation should stop when every philosopher has eaten at least 7 times.";echo
if ./philo 5 800 200 200 7 | grep died >/dev/null
then
    printf "\033[0;31mKO\033[0m\n"
else
    printf "\033[0;32mOK\033[0m\n"
fi


echo; echo "Test 4 410 200 200 : No philosopher should die. (10s test)";echo
if timeout 10 ./philo 4 410 200 200 | grep died >/dev/null
then
    printf "\033[0;31mKO\033[0m\n"
else
    printf "\033[0;32mOK\033[0m\n"
fi


echo; echo "Test 3 310 200 100 : One philosopher should die.";echo
if ./philo 4 310 200 100 | grep died >/dev/null
then
    printf "\033[0;32mOK\033[0m\n"
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
